pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import 'hardhat/console.sol';
import './ExampleExternalContract.sol';

contract Staker {
  ExampleExternalContract public exampleExternalContract;

  mapping(address => uint256) public balances;

  event Stake(address _user, uint256 _deposit);
  
  uint256 public deadline = block.timestamp + 30 seconds;
  uint256 public constant threshold = 1 ether;
  bool public openForWithdrawal;
  
  

  constructor(address exampleExternalContractAddress) {
    exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  modifier notCompleted{
    bool isCompleted = exampleExternalContract.completed();
    require(isCompleted == false, "Staking campaign has already ended");
    _;
  }
  // fake comment to check if git
  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  //  ( make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
  function stake( uint256 _deposit) public payable notCompleted {
    
    require(block.number < deadline, "Staking has closed");
    balances[msg.sender] += _deposit;

    emit Stake(msg.sender, _deposit);
  }

  // After some `deadline` allow anyone to call an `execute()` function
  //  It should either call `exampleExternalContract.complete{value: address(this).balance}()` to send all the value
  function execute() external {
    require(block.timestamp >= deadline, "It's not over yet");
    if(address(this).balance >= threshold){
    exampleExternalContract.complete{value: address(this).balance}();
    } else {
      openForWithdrawal = true;
    }
  }

  // if the `threshold` was not met, allow everyone to call a `withdraw()` function
  function withdraw() external {
    require(openForWithdrawal == true, "Cannot withdraw at this time");
    address payable _withdrawer = payable(msg.sender);
    _withdrawer.transfer(balances[_withdrawer]);
  }

  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  function timeLeft() external view returns(uint256) {
    if(block.timestamp >= deadline){
      return 0;
    } else {
      return deadline - block.timestamp;
    }
  }
  // Add the `receive()` special function that receives eth and calls stake()
  receive() external payable {
    stake(msg.value);
  }
}
