// deploy/01_deploy_vendor.js

const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  // You might need the previously deployed yourToken:
  const yourToken = await ethers.getContract("YourToken", deployer);

  // Todo: deploy the vendor
<<<<<<< HEAD
  await deploy("Vendor", {
    from: deployer,
    args: [yourToken.address], // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    log: true,
  });
  
  const vendor = await ethers.getContract("Vendor", deployer);

  // Todo: transfer the tokens to the vendor
   console.log("\n 🏵  Sending all 1000 tokens to the vendor...\n");
=======
   await deploy("Vendor", {
     from: deployer,
     args: [yourToken.address], // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
     log: true,
   });
  
   const vendor = await ethers.getContract("Vendor", deployer);

  // Todo: transfer the tokens to the vendor
   console.log("\n 🏵  Sending all 1000 tokens to the vendor...\n");
   
>>>>>>> e35aa0dce52a2c765ed837f08ef01f8b373561c0
  
   const transferTransaction = await yourToken.transfer(
     vendor.address,
     ethers.utils.parseEther("1000")
   );

  console.log("\n    ✅ confirming...\n");
  await sleep(5000); // wait 5 seconds for transaction to propagate

<<<<<<< HEAD
   // ToDo: change address to your frontend address vvvv
   console.log("\n 🤹  Sending ownership to frontend address...\n")
   const ownershipTransaction = await vendor.transferOwnership("0x41d2004789F3Be06C5092de53770CfC02A10bdCA");
=======
  // ToDo: change address to your frontend address 
   console.log("\n 🤹  Sending ownership to frontend address...\n")
   const ownershipTransaction = await vendor.transferOwnership("0xc838EA4027154C55e98a5ad8A273f3905FF920d7");
>>>>>>> e35aa0dce52a2c765ed837f08ef01f8b373561c0
   console.log("\n    ✅ confirming...\n");
   const ownershipResult = await ownershipTransaction.wait();

   

   
  // ToDo: Verify your contract with Etherscan for public chains
   if (chainId !== "31337") {
     try {
       console.log(" 🎫 Verifing Contract on Etherscan... ");
       await sleep(5000);  // wait 5 seconds for deployment to propagate
       await run("verify:verify", {
         address: vendor.address,
         contract: "contracts/Vendor.sol:Vendor",
         contractArguments: [yourToken.address],
       });
     } catch (e) {
       console.log(" ⚠️ Failed to verify contract on Etherscan ");
     }
   }
};

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

module.exports.tags = ["Vendor"];
