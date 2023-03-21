// SPDX-License-Identifier: MIT
pragma solidity ^0.4.26;

/// @knowledgePoint uninitializedStorage

/// @level 简单
/// @description 尝试去修改isComplete吧！

contract array {
    bool public isComplete;
    uint public score;
    uint[] public prime_number;
    
    function number_add(uint _num) public {
        uint[] tmp;
        tmp.push(_num);
        prime_number=tmp;
    }

    function isCompleted() public {
        score = 0;
        if(isContract(msg.sender)){
            score += 25;
        }
        if(isComplete){
            score +=75;
        }
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}
