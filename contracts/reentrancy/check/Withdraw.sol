/// @knowledgePoint 重入

/// @level 普通
/// @description 为了完成此挑战，你需要先执行initWithValue()函数，随后，想办法套空合约里的这0.001ether

// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

contract Reentrance{
    address _owner;
    mapping (address => uint256) balances;
    uint256 public score;
    bool public isInit;

    
    constructor() public payable {
        _owner = msg.sender;
    }

    //初始状态：0.001ether
    function initWithValue() public payable{
        if(!isInit){
            require(address(this).balance == 1000000000000000 wei, "should init with 0.001 ether");
            isInit = true;
        }
    }

    function withdraw(uint256 amount) public payable{
        require(balances[msg.sender] >= amount);
        require(address(this).balance >= amount);
        msg.sender.call.value(amount)();
        balances[msg.sender] -= amount;
    }

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function balanceOf(address adre) public view returns(uint256){
        return balances[adre];
    }

    function wallet() public  view returns(uint256 result){
        return address(this).balance;
    }

    function isCompleted() public {
        require(isInit, "You can't do it without init");
        score = 0;
        if(isContract(msg.sender)){
            score = 25;
        }
        if(address(this).balance == 0){
            score = 100;
        }
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}