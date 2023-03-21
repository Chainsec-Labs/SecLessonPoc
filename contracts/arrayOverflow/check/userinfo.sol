/// @knowledgePoint 数组长度溢出
 
/// @level 困难
/// @description 1.修改administration.2.调用者token余额大于1000000ether
pragma solidity ^0.4.24;

contract userinfo{
    address public administration;
    mapping(address => uint256)public balances;
    struct User{
        string name;
        uint256 balance;
    }
    mapping(address => User[])public users;
    constructor()public{
        administration = msg.sender;
    }

    function addUser(string memory _name)public payable{
        User memory user;
        user.name = _name;
        user.balance = msg.value;

        users[msg.sender].push(user);
        balances[msg.sender]+=msg.value;
    }

    function deleteUser()public{
        uint256 len = users[msg.sender].length;
        User memory user = users[msg.sender][len-1];

        require(balances[msg.sender]>=user.balance,"balance error");
        balances[msg.sender]-=user.balance;
        bool success =msg.sender.call.value(user.balance)();
        require(success,"transfer error");

        users[msg.sender].length--;
    
    }

    function setName(uint256 index,string memory newName)public{
        User storage user = users[msg.sender][index];
        user.name = newName;
    }

}
contract check{
    uint256 public score;
    userinfo public info = new userinfo();

    function isCompleted()public{
        score =0;
        if (info.administration()==address(0)){
            score+=25;
        }

        if(info.balances(msg.sender)>=1000000 ether){
            score+=75;
        }
    }
    
}