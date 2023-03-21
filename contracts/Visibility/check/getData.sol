/// @knowledgePoint 可见性修饰符

/// @level 简单
/// @description 1.拿到lock1.2.拿到lock2
pragma solidity ^0.4.0;

contract getData {

 uint256 public score;
 address public data1;
 uint256 private data2;
  bool public lock1;
  bool public lock2;
  constructor()public {
     data1 = msg.sender;
     data2 =uint256(keccak256(block.blockhash(block.number - 9), now));
  }
  function VerifyData1(address _addr)external{
     require(_addr==data1,"Your answer is wrong");
     lock1=true;
  }
  function VerifyData2(uint256 _data2)external{
    
      require(_data2==data2,"Your answer is wrong");
     lock2=true;
  }
//想办法拿到data1和data2
  function isComplete()public {

     if(lock1==true &&lock2==true){
       score=100;
     }else if(lock1==true &&lock2==false){
         score=25;
     }else if(lock1==false &&lock2==true){
         score=75;
     }else{
         score=0;
     }
  }
}
