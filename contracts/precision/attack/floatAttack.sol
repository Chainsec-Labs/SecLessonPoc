//_a是4，_a2是5，_b是0x3132，送分题
pragma solidity ^0.5.0;
import "./float.sol";
contract floatAttack{
    float fl;
    constructor(address _fl)public{
        fl = float(_fl);
    }

    function attack()public{
        fl.isCompleted(4,5,0x3132);
    }


}