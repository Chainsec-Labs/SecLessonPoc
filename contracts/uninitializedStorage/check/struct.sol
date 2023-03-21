/// @knowledgePoint 未初始化的storage变量
 
/// @level 简单
/// @description 1.owner.2.余额归零
pragma solidity ^0.4.24;
contract Struct{
    struct Student{
        uint256 score;
        uint256 time;
    }
    address public owner;
    Student[] public students;
    uint256 public score;

    function addStudent(uint256 _score,uint256 _time)public{
        Student student;
        student.score=_score;
        student.time = _time;
        students.push(student);
    }

    function deleteStudent(uint256 index)public{
        require(students.length>0);
        Student memory temp = students[index];
        students[index]=students[students.length-1];
        students[students.length-1]=temp;
        students.length--;
    }
     
    function isCompleted()public{
        score=0;
        if(msg.sender==owner){
            score=50;
        }
        if(students.length>=1000000000000000){
            score=100;
        }
    }
}