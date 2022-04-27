pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/access/Ownable.sol';
import './YourToken.sol';

contract Vendor is Ownable {
  YourToken public yourToken;
  uint256 public constant tokensPerEth = 100;
  uint256 private _decimals = 10**18;

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfEth);

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    require(msg.value > 0, 'tokens cost more than 0');
    uint256 _tokensBought = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, _tokensBought);
    emit BuyTokens(msg.sender, msg.value, _tokensBought);
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
