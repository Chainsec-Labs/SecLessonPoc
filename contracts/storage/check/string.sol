/// @knowledgePoint 动态数据类型的存储方式
 
/// @level 简单
/// @description 1.猜出string1.2.猜出string2
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts-upgradeable/utils/StorageSlotUpgradeable.sol";
contract stringer{
    string private string1 = "cuit";
    string private string2 = "cuit, the best school of blockchain";
    uint256 public score;


    function setSlot(bytes32 slot,bytes32 value)public {
        require(slot !=bytes32(uint256(2)));
        StorageSlotUpgradeable.getBytes32Slot(slot).value = value;
    }

    function isCompleted()public{
        score =0;
        bytes memory str1 = bytes(string1);
        for (uint i =0;i<str1.length;i++){
            if (str1[i]!=0){
                break;
            }
            if(score<50){
                score+=10;
            }
        }

        bytes memory str2 = bytes(string2);
        for (uint i =0;i<str2.length;i++){
            if (str2[i]!=0){
                break;
            }
            if(i==str2.length-1){
                score+=50;
            }
        }
    }
}