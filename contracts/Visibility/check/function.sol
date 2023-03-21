/// @knowledgePoint 可见性修饰符
 
/// @level 普通
/// @description 调用check中继承func的四种不同函数。
//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.0;
contract func{
    address internal owner;
    uint256 public score;
    uint256 public times;

    constructor(){
        owner = msg.sender;
    }

    function pul()public{
        require(times==0);
        times+=1;

    }
    
    function inte()internal{
        require(times==1);
        times+=1;

    }

    function ext()external{
        require(times==2);
        times+=1;

    }

    function pri()private{
        require(times==3);
        times+=1;

    }

    function com()public{
        require(msg.sender==address(this));
        pri();
    }
}

contract check is func{

    modifier onlyOwner(){
        require(uint160(msg.sender)&0xff==uint8(uint160(owner)));
        _;
    }

    function ownerPrivalege()public onlyOwner{
        inte();
    }

    function isCompleted()public{
        score =0;
        score = times*25;
    }

    receive()external payable{}

    function flashLoan(address target,uint256 amount,bytes memory data)public{
        require(tx.origin!=msg.sender);
        require(times==3);

        uint256 balanceBefore = address(this).balance;
        require(balanceBefore>amount,"amount must letter than balance");

        payable(target).transfer(amount);
        (bool success,) =payable(target).call(data);
        require(success,"flashLoan call failed");

        uint256 balanceAfter = address(this).balance;
        require(balanceAfter>=balanceBefore,"flashloan hasn't been paid back");
    }
}