pragma solidity ^0.6.0;

/// @knowledgePoint externalContract

/// @level 简单
/// @description 将top变为true

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Top {
    uint256 public score;
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }

    function isCompleted() public {
        score = 0;
        if(isContract(msg.sender)){
            score += 25;
        }
        if(top == true){
            score += 75;
        }
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}
