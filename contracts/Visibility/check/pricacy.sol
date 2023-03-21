pragma solidity ^0.6.0;
/// @knowledgePoint 可见性修饰符

/// @level 简单
/// @description 拿到lock
contract Privacy {
    bytes32[3] private data;
    bool public locked = true;
    uint256 public ID = block.timestamp;
    uint8 private flattening = 10;
    uint public score;
    uint16 private awkwardness = uint16(now);

    //这里初始化数组
    constructor(bytes32[3] memory _data) public {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[1]));
        locked = false;
    }

    function isCompleted() public {
        score = 0;
        if(isContract(msg.sender)){
            score += 25;
        }
        if(!locked){
            score += 75;
        }
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }

}
