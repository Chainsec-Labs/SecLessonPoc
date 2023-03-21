/// @knowledgePoint 外部合约调用
 
/// @level 简单
/// @description 1.合约token余额归零.2.调用者token余额大于10000ether
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
contract tokenbank{
    address public owner;
    mapping(address => uint256)private balance;
    constructor(address _owner){
        owner = _owner;
        balance[owner]+=1000 ether;
    }

    modifier onlyOwner{
        require(msg.sender==owner,"onlyowner");

        _;
    }

    function deposit()public payable{
        require(msg.value>0,"are you kidding me?");
        balance[msg.sender]+=msg.value;
    }

    function withdraw(uint256 amount)public payable{
        require(balance[msg.sender]>=amount);
        balance[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
    }

    function transfer(address _addr,uint256 amount)public{
        require(balance[msg.sender]>=amount);
        require(msg.sender!=_addr);
        balance[msg.sender]-=amount;
        balance[_addr]+=amount;
    }
    function balanceOf(address _addr)public view returns(uint256){
        return balance[_addr];
    }

    function mint(address _addr,uint256 amount)public onlyOwner{
        balance[_addr]+=amount;
    }

    function burn(address _addr,uint256 amount)public onlyOwner{
        balance[_addr]-=amount;
    }

}
contract check{
    uint256 public score;

    constructor(){
       tokenbank bank = tokenbank(address(this));
    }

    function isCompleted(address _bank)public{
        score=0;

        if(tokenbank(_bank).balanceOf(address(this))==0){
            score+=25;
        }

        if(tokenbank(_bank).owner()==address(this) &&tokenbank(_bank).balanceOf(msg.sender)>=10000 ether){
            score+=75;
        }

    }

}