/// @knowledgePoint txorigin误用
 
/// @level 普通
/// @description 1.合约攻击。2.拿到license。
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Flashloan{
    uint256 public score;
    mapping(address => bool) license;

    constructor()payable{
        license[address(this)]=true;
    }
    modifier onlyLicense{
        require(license[msg.sender]);
        _;
    }
    receive()external payable{}
    function flashLoan(address target,uint256 amount,bytes memory data)public{
        require(tx.origin!=msg.sender);

        uint256 balanceBefore = address(this).balance;
        require(balanceBefore>amount,"amount must letter than balance");

        payable(target).transfer(amount);
        (bool success,) =payable(target).call(data);
        require(success,"flashLoan call failed");

        uint256 balanceAfter = address(this).balance;
        require(balanceAfter>=balanceBefore,"flashloan hasn't been paid back");
    }
    function getLicense()public onlyLicense{
        license[tx.origin]=true;
        
    }
    function isCompleted()external{
        score=0;
        if (msg.sender!=tx.origin){
            score =50;
        }
        if(license[msg.sender]){
            score=100;
        } 
    }
}

