/// @knowledgePoint ecrecover的使用
 
/// @level 普通
/// @description 1.调用者余额为0。2.合约余额为10000 ether。
pragma solidity ^0.8.0;

contract ectransfer {
    uint256 public score;
    mapping(address => uint256) private _balances;
    mapping(address => bool) public isAir;
    constructor() {
        _balances[address(this)] = 10000*10**18;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function safeTransfer(address receiver, uint256 amount, bytes memory sig) public {
        bytes32 message = keccak256(abi.encodePacked(msg.sender, amount, receiver));
        require(msg.sender == ecrecovery(message,sig), "your sig is not right");

        _balances[msg.sender] -= amount;
        _balances[receiver] += amount;
    }

    function airdrop()public{
        require(!isAir[msg.sender]);
        isAir[msg.sender] = true;
        _balances[msg.sender]+=1 ether;
        _balances[address(this)]-=1 ether;
    }

    function isCompleted() public {
        require(isAir[msg.sender]);
        score = 0;
        if(_balances[msg.sender] == 0){
            score += 75;
        }
        if(_balances[address(this)]==10000 ether) {
            score += 25;
        }
    }

    function ecrecovery(bytes32 hash, bytes memory sig) public pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        if (sig.length != 65) {
            return address(0x0);
        }

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := and(mload(add(sig, 65)), 255)
        }
        if (v < 27) {
            v += 27;
        }

        if (v != 27 && v != 28) {
            return address(0x0);
        }

        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        hash = keccak256(abi.encodePacked(prefix, hash));

        return ecrecover(hash, v, r, s);
    }
}

