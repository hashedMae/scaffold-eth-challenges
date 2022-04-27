pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {
<<<<<<< HEAD
  // ToDo: add constructor and mint tokens for deployer,
  //       you can use the above import for ERC20.sol. Read the docs ^^^

  constructor() public ERC20('Gold', 'GLD') {
    // _mint() 1000 * 10 ** 18 to msg.sender;
    _mint(msg.sender, 2000 * 10 ** 18);
  }
=======
    constructor() ERC20("Gold", "GLD") {
        _mint( msg.sender , 1000 * 10 ** 18);
    }

    
>>>>>>> e35aa0dce52a2c765ed837f08ef01f8b373561c0
}
