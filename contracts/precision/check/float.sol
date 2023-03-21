/// @knowledgePoint 浮点和精度
 
/// @level 简单
/// @description 1.两种uint变量精度计算。2.bytes2变量精度计算。
pragma solidity ^0.5.0;
 
contract float {
    uint c = 5;
    bytes2  b = "12";
    uint256 public score;
    
    function check_var(uint _a) public view returns(bool){
        uint a = c/2 + c/2;
        return a==_a;
    }
    function check_const(uint _a) public pure returns(bool){
        uint a = 5/2 + 5/2;
        return a==_a;
    }
    function check_bytes2(bytes2 _b)public view returns(bool){
        return b==_b;
    }
    function isCompleted(uint _a,uint _a2,bytes2 _b)public{
        score=0;
        if (check_var(_a)){
            score+=25;
        }
        if (check_const(_a2)){
            score+=25;
        }
        if (check_bytes2(_b)){
            score+=50;
        }

    }
}