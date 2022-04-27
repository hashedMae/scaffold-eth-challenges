pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/access/Ownable.sol';
import './YourToken.sol';

contract Vendor is Ownable {
<<<<<<< HEAD
=======

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

>>>>>>> e35aa0dce52a2c765ed837f08ef01f8b373561c0
  YourToken public yourToken;
  uint256 public constant tokensPerEth = 100;
  uint256 private _decimals = 10**18;

<<<<<<< HEAD
  constructor(address tokenAddress) public {
=======
  uint256 public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
>>>>>>> e35aa0dce52a2c765ed837f08ef01f8b373561c0
    yourToken = YourToken(tokenAddress);
  }

  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfEth);

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
<<<<<<< HEAD
    require(msg.value > 0, 'tokens cost more than 0');
    uint256 _tokensBought = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, _tokensBought);
    emit BuyTokens(msg.sender, msg.value, _tokensBought);
=======
    uint256 _tokensToDispense = msg.value * tokensPerEth;
    emit BuyTokens(msg.sender, msg.value, _tokensToDispense);
>>>>>>> e35aa0dce52a2c765ed837f08ef01f8b373561c0
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  //function withdraw() public onlyOwner {
 //   payable(msg.sender).transfer(address(this).balance);
 // }

  // ToDo: create a sellTokens() function:
  function sellTokens(uint256 theAmount) external {
    require(yourToken.allowance(msg.sender, address(this)) >= theAmount);
    yourToken.transferFrom(msg.sender, address(this), theAmount);
    uint256 _ethToTransfer = theAmount / tokensPerEth;
    payable(msg.sender).transfer(_ethToTransfer);
    emit SellTokens(msg.sender, theAmount, _ethToTransfer);
  }



  receive() external payable {}
}
