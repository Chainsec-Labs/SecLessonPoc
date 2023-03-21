pragma solidity ^0.6.0;

interface Top {
  function goTo(uint _floor) external;
}

contract MyBuilding{
    uint temp = 5;
    Top e;
    function isLastFloor(uint i) external returns (bool){
        if(temp == i){
            temp = 6;
            return false;
        }else{
            return true;
        }
    }

    function dosome(address adr) public{
        e = Top(adr);
        e.goTo(5);
    }
}