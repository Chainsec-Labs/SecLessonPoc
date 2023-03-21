/// @knowledgePoint delegatecall调用出错

/// @level 普通
/// @description 尝试着去获取owner

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
contract LibraryContract {
    uint256 storedTime;

    function setTime(uint256 _time) public {
        storedTime = _time;
    }
}

contract Check {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 public score;
    uint256 storedTime;
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(
        address _timeZone1LibraryAddress,
        address _timeZone2LibraryAddress
    ) public {
        timeZone1Library = _timeZone1LibraryAddress;
        timeZone2Library = _timeZone2LibraryAddress;
        owner = msg.sender;
    }

    function setFirstTime(uint256 _timeStamp) public {
        timeZone1Library.delegatecall(
            abi.encodePacked(setTimeSignature, _timeStamp)
        );
    }

    function setSecondTime(uint256 _timeStamp) public {
        timeZone2Library.delegatecall(
            abi.encodePacked(setTimeSignature, _timeStamp)
        );
    }

    function isContract(address addr) private view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(addr)
        }
        return size > 0;
    }

    function isCompleted() public {
        score = 0;
        if (isContract(msg.sender)) {
            score += 25;
        }
        if (owner == msg.sender) {
            score += 75;
        }
    }
}
