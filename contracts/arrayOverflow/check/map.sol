/// @knowledgePoint 数组长度溢出

/// @level 普通
/// @description 这是一个用数组模拟的map，但貌似这样写有很严重的问题。尝试去获取isComplete吧！

// SPDX-License-Identifier: MIT
pragma solidity ^0.4.21;

contract Map {
    bool public isComplete;
    uint256[] map;

    constructor(){

    }

    function set(uint256 key, uint256 value) public {
        if (map.length <= key) {
            map.length = key + 1;
        }

        map[key] = value;
    }

    function get(uint256 key) public view returns (uint256) {
        return map[key];
    }

}
contract Check{
    uint256 public score;
    Map public map;

    constructor() public {
        map = new Map();
    }
    
    function isCompleted() external {
        score = 0;
        if(isContract(msg.sender)){
            score += 25;
        }
        if(map.isComplete()){
            score += 75;
        }
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}