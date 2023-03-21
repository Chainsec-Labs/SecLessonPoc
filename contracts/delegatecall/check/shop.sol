/// @knowledgePoint delegatecall
 
/// @level 简单
/// @description 1.成为owner。2.商品价格修改为0。
pragma solidity ^0.5.0;
contract shop{
    goods public _goods;
    address public owner = address(this);
    uint256 public prize;
    uint256 public score;
    constructor()public{
        _goods = new goods("food",1000000 ether);
        prize = 1000000 ether;
    }
    function changePrice(uint256 amount)public{
      (bool success,) = address(_goods).delegatecall(abi.encodeWithSignature("setPrize(uint256)",amount));
       require(success,"delegatecall failed");
       require(score==0);
    }
}

contract goods{
    uint256 public prize;
    string public name;
    constructor(string memory _name,uint256 _prize)public{
        name = _name;
        prize = _prize;
    }
    function setPrize(uint256 amount)public {
        prize = amount;
    }
}

contract check is shop{
    function isCompleted()external{
        score=0;
        if(owner==msg.sender){
            score+=50;
        }
        if(prize==0){
            score+=50;
        }
    }
}