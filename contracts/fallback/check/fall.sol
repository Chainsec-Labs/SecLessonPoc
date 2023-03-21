/// @knowledgePoint fallback,receive的使用
 
/// @level 简单
/// @description 1.合约攻击。2.成功调用fallback和receive。
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract fall{
    uint256 public score;
    bool public isFallback = false;
    bool public isReceive = false;

    
    function isCompleted()public{
        score=0;
        if(msg.sender!=tx.origin){
            score=25;
        }
        if(isFallback||isReceive){
            score=50;
        }
        if(isFallback&&isReceive){
            score=100;
        }
    }

    fallback()external payable{
        require(!isFallback,"already fallback");
        isFallback=true;
    }
    receive()external payable{
        require(!isReceive,"already receive");
        isReceive=true;
    }


}