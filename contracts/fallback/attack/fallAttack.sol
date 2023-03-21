//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

//调用fallba函数即触发fallback，调用recei函数即触发recieve,触发一个得50分，两个为满分
contract fallAttack {
    address public fall;

    constructor(address payable _fall) {
        fall = _fall;
    }

    function fallba() public payable {
        (bool success, bytes memory data) = fall.call("pwn()");
        require(success, string(data));
    }

    function recei() public payable {
        (bool success, bytes memory data) = payable(fall).call{
            value: msg.value
        }("");
        require(success, string(data));
    }

    function conplete() public {
        (bool success, bytes memory data) = fall.call(
            abi.encodeWithSignature("isCompleted()")
        );
        require(success, string(data));
    }
}
