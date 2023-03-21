/// @knowledgePoint call调用返回值检查

/// @level 简单
/// @description Bank是一个简单的银行系统，你能盗取所有的ETH吗？

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    uint256 public score;
    bool public isInit;
    modifier onlyBank{
        require(msg.sender == address(this));
        _;
    }
    mapping(address => uint256) public balanceOf;
    
    constructor() public {

    }

    //初始状态：10 wei
    function initWithValue() public payable{
        if(!isInit){
            require(address(this).balance == 10, "should init with 10 wei");
            isInit = true;
        }
    }

    //parameter
    //flag : 0 表示取款，1表示存款
    function reviseBalance(uint256 flag, address user, uint256 _amount) public onlyBank{
        if(flag == 0){
            require(balanceOf[user] > _amount, "Sorry, your credit is running low");
            balanceOf[user] -= _amount;
        }else if(flag == 1){
            balanceOf[user] += _amount;
        }else{
            require(0 == 1, "Parameter error");
        }
    }

    function deposit(uint256 _amount) public payable{
        require(msg.value >= _amount, "Value is less than amount");
        bytes memory data = abi.encodeWithSignature("reviseBalance(uint256,address,uint256)", 1, msg.sender, _amount);
        address(this).call(data);
    }

    function withdraw(uint256 _amount) public {
        require(_amount > 0, "amount can not be zero");
        bytes memory data = abi.encodeWithSignature("reviseBalance(uint256,address,uint256)", 0, msg.sender, _amount);
        address(this).call(data);
        payable(msg.sender).transfer(_amount);
    }

    function isCompleted() public {
        require(isInit, "You can't do it without init");
        score = 0;
        if(balanceOf[msg.sender] > 0){
            score += 25;
        }
        if(address(this).balance == 0){
            score +=75;
        }
    }
}
