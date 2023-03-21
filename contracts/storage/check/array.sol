/// @knowledgePoint 动态数据类型的存储方式
 
/// @level 普通
/// @description 1.增加数组长度。2.算出数组对应元素的存储插槽。3.算出映射对应元素的存储插槽
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract array{
    struct Token{
        address addr;
        uint256 value;
        uint256 index;
    }
    Token[] public tokens;
    mapping(address => Token)public tokenOfUser;
    uint256 public score;
    constructor(){
        Token memory token =  Token(address(0),0,tokens.length);
        tokens.push(token);
        tokenOfUser[msg.sender]=token;
    }

    function checkTokensSlot(bytes32 _slot,uint256 index)public view returns(bool){
        bytes32 slot;
        Token storage token = tokens[index];

        assembly{
            slot :=token.slot
        }   

        return(slot==_slot);
    }
    function checkTokenOfUserSlot(bytes32 _slot,address _addr)public view returns(bool){
        bytes32 slot;
        Token storage token = tokenOfUser[_addr];

        assembly{
            slot :=token.slot
        }   

        return(slot==_slot);
    }

    function addToken(address _token,uint256 _value)public{
        require(tokens.length<100,"too much token");
        if(tokenOfUser[msg.sender].addr==address(0)){
            Token memory token = Token(_token,_value,tokens.length);
            tokens.push(token);
            tokenOfUser[msg.sender]=token;
        }else{
            Token memory token = tokenOfUser[msg.sender];
            token.addr=_token;
            token.value=_value;
            tokenOfUser[msg.sender]=token;

            tokens[tokenOfUser[msg.sender].index] = token;
        }
    }

    function deleteToken()public{
        uint256 index = tokenOfUser[msg.sender].index;
        Token memory temp = tokens[index];

        tokens[tokens.length-1].index = index;
        tokens[index] = tokens[tokens.length-1];
        tokens[tokens.length-1]=temp;

        tokens.pop();
        delete(tokenOfUser[msg.sender]);
    }

    function isCompleted(bytes32 slotArray,bytes32 slotMap,uint256 index,address _addr)public{
        score=0;
        if (tokens.length>=2){
            score+=25;
        }
        if(checkTokensSlot(slotArray,index)){
            score+=25;
        }
        if(checkTokenOfUserSlot(slotMap,_addr)){
            score+=50;
        }
    }
}