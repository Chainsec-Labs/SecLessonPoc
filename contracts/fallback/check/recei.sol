/// @knowledgePoint fallback,receive
 
/// @level 简单
/// @description 1.成为owner.2.成为administration
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract recei {
    mapping(address => uint256) public contributions;
    address public owner;
    address public administration;
    uint256 public score;

    constructor() {
        contributions[msg.sender] = 10000000 ether;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }

    fallback() external payable {
        require(msg.value > 0 && msg.sender == owner);
        administration = msg.sender;
    }

    function isCompleted()public{
        score=0;
        if (owner == msg.sender){
            score+=50;
        }
        if(administration == msg.sender){
            score+=50;
        }
    }
}
