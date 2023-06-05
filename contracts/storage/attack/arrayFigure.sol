//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./array.sol";
/*
攻击合约一个函数用来计算array的存储位置，一个函数用来计算figureMap的存储位置。算出对应的slot后
将对应的参数放入，只要成功向合约中添加了一个结构体且array和map的slot位置都正确即可满分
*/
contract arrayAttack{
    array arr;
    constructor(address _arr){
        arr = array(_arr);
        complete();
    }
    function figureArray(uint256 slot)public pure returns(bytes32){
        return keccak256(abi.encodePacked(bytes32(slot)));
    }
    function figureMap(uint256 slot,address _addr)public pure returns(bytes32){
        return keccak256(abi.encodePacked(bytes32(uint256(uint160(_addr))),bytes32(slot)));
    }

    function complete()public{
        address _addr = address(this);
        arr.addToken(msg.sender,0);
        arr.isCompleted(figureArray(0),figureMap(1,_addr),0,_addr);
    }

}
