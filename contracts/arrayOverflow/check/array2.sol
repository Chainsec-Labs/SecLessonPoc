/// @knowledgePoint 数组长度溢出
 
/// @level 简单
/// @description 1.数组长度溢出.2.flag变为true
pragma solidity ^0.4.24;
contract array2{
    bool public flag;
    uint256[] public array;

    function addElement(uint256 index,uint256 value)public{
        if(index>=array.length){
            array.length=index+1;
        }
        array[index] = value;
    }

    function deleteElement()public{
        require(array.length>0);
        array.length--;
    }

    function getArrayLength()public view returns(uint256){
        return array.length;
    }


}
contract check{
    uint256 public score;
    array2 public arr;
    constructor()public{
        arr = new array2();
    }

    function isCompleted()public{
        score=0;
        if (arr.getArrayLength()>100000000000000000){
            score+=50;
        }
        if (arr.flag()==true){
            score+=50;
        }
    }
}
