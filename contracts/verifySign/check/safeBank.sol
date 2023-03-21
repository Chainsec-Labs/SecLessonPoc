/// @knowledgePoint ecrecover的使用

/// @level 普通
/// @description 你需要使用指定用户来调用合约，并拿走合约主人的全部财产
pragma solidity 0.8.16;

contract safeBank {
    uint public score;
    address public owner;
    mapping(address => uint256) private _balances;

    constructor() {
        owner = address(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);
        _balances[owner] = 10000*10**18;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function safeTransfer(address from, address receiver, uint256 amount, bytes memory sig) public {
        bytes32 message = keccak256(abi.encodePacked(address(from), amount, receiver));
        require(from == ecrecovery(message,sig), "your sig is not right");
        require(_balances[from] >= amount);
        _balances[from] -= amount;
        _balances[receiver] += amount;
    }

    function isCompleted() public {
        score = 0;
        if(tx.origin == address(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)) {
            score += 40;
        }
        if(_balances[owner] == 0){
            score += 60;
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

        // https://github.com/ethereum/go-ethereum/issues/2053
        if (v < 27) {
            v += 27;
        }

        if (v != 27 && v != 28) {
            return address(0x0);
        }

        /* prefix might be needed for geth only
         * https://github.com/ethereum/go-ethereum/issues/3731
         */
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        hash = keccak256(abi.encodePacked(prefix, hash));

        return ecrecover(hash, v, r, s);
    }
}

