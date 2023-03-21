// SPDX-License-Identifier: MIT

/// @knowledgePoint Dos

/// @level 普通
/// @description 这是一个竞拍合约，想办法使这个竞拍系统无法正常运行。

pragma solidity ^0.6.0;

contract King {
    address payable king;
    uint public prize = 0;
    address payable public owner;
    uint256 public score;
    uint256 public nums;

    constructor() public payable {
        owner = msg.sender;  
        king = msg.sender;
    }

    receive() external payable {
        require(msg.value > prize || msg.sender == owner);
        require(king.send(msg.value));
        king = msg.sender;
        prize = msg.value;

        nums++;
    }

    function _king() public view returns (address payable) {
        return king;
    }
}

contract Check {
    address public victim;
    King public king;
    uint public prize;
    //你的成绩
    uint256 public score;
    constructor() public {
        king = new King();
        victim = address(king);
    }

    function getPriceNow() public {
        prize = king.prize();
    }

    function check() public payable{
        require(msg.value > king.prize());
        victim.call.gas(1000000).value(msg.value)("");
    }

    //检查时必须确保value > prize （确保msg.value足够进行一次竞拍）
    //如果你是做题者，请重新部署一个攻击合约来模拟新的竞拍者再进行此操作
    function isCompleted() public payable{
        score = 0;
        
        //如果你参与过竞拍,50分
        if(king.nums() >= 1){
            score = 50;
            address kingbefore = king._king();
            check();
            address kingafter = king._king();
            //如果你成功使此竞拍系统宕机，100分
            if(kingbefore == kingafter){
                score = 100;
            }
        }
        
    }

    fallback() external payable {
        
    }

}