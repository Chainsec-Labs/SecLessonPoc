/// @knowledgePoint create2

/// @level 简单
pragma solidity ^0.8.0;

contract found{
    bool public resove = false;
    
    constructor(){
        if(address(this).balance >= 0.001 ether){
            resove = true;
        }  
    }
    
    function getResove() public view returns(bool){
        return resove;
    }
    
}

contract check{
    found public target;
    uint public score;
    
    function depoly(bytes32 _salt) public returns(address){
        target = new found{salt: _salt}();
        return address(target);
    }
    
    function isCompleted() public {
        score = 0;
        if(address(target) != address(0)){
            score += 30;
        }
        if(target.getResove()){
            score += 70;
        }
    }
}
