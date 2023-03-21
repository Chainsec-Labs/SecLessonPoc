// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
contract vulquery{
    uint public score;
    bool[] public gate;
    uint public i=0;

    function culcu(uint _answer) internal view returns (bool){
        uint MOD_NUM=60;
        uint256 seed = uint256(keccak256(abi.encodePacked(block.number)))+uint256(keccak256(abi.encodePacked(block.timestamp)));
        uint256 seed_hash = uint256(keccak256(abi.encodePacked(seed)));
        uint256 shark = seed_hash % MOD_NUM;
        uint256 lucky_hash = uint256(keccak256(abi.encodePacked(msg.sender)));
        uint256 lucky = lucky_hash % shark;

        return lucky==_answer;
    }


    function collision(uint answer) public {
        gate.push(culcu(answer));
        if(gate[i]==true){
            i++;
            if(gate.length>10){
                revert("To much");
            }
        }else{
            uint length=gate.length;
            for(uint q=0;q<length;q++){
                gate.pop();
                }
                i=0;
        }
    }

    function isComplete()public returns(uint){
        score=0;
        if (gate.length<=8&&gate.length>0){score=30;}
        else{
            for(uint q=0;q<gate.length;q++){
                if(gate[q]==true){
                    score+=10;
                }
            }
        }
        
    }
}