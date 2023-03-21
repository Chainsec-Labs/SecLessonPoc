/// @knowledgePoint txorigin误用

/// @level 简单
/// @description 考点：1.owner。2.origin。

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

contract Wallet {
    address owner;
    uint256 public score;

    constructor() public payable{
        require(address(this).balance >= 100);
        owner = address(this);
    }

    function beOwner() public {
        owner = msg.sender;
    }

    function flashLoan(address payable target,uint256 amount,bytes memory data)public payable{

        uint256 balanceBefore = address(this).balance;
        require(balanceBefore>amount,"amount must letter than balance");

        payable(target).transfer(amount);
        (bool success,) =payable(target).call(data);
        require(success,"flashLoan call failed");

        uint256 balanceAfter = address(this).balance;
        require(balanceAfter>=balanceBefore,"flashloan hasn't been paid back");
    }

      
    function isCompleted() public {
        score = 0;
        if(tx.origin == owner){
            score += 25;
        }
        if(msg.sender == address(this)){
            score += 75;
        }
    }

    fallback() external payable {

    }
}


