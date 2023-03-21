/// @knowledgePoint 未初始化的storage变量
 
/// @level 困难
/// @description 1.数组元素存储位置。2.映射元素存储位置。3.string元素存储位置
pragma solidity 0.4.24;
contract cooperate{
    struct User{
        string name;
        mapping(address => uint256)debts;
        uint256[] balances;
    }
    uint256[] public events;
    mapping(address => uint256) public borrows;
    string public contractName = "cuit is the best school in CN";
    mapping(address => User) users;
    uint256 public score;
    bool isInit;
    function init()public payable{
        require(!isInit,"you have init");
        require(msg.value>=0.001 ether);
        events.push(1);
        borrows[address(this)] = msg.value;
        isInit = true;
    }

    function borrow(string memory _name,uint256 _debt)public payable{
        if (msg.value>0){
            User storage user = users[msg.sender];
            events.push(1);
            borrows[msg.sender]+=msg.value;
            user.name = _name;
            user.debts[msg.sender] = msg.value;
            user.balances.push(msg.value);
        }else{
            user.name = _name;
            user.debts[address(this)]=_debt;
            user.balances.push(0);
        }
    }

    function isCompleted()public{
        require(isInit);
        score =0 ;
        bytes32 slot2;
        assembly{
            slot2:=sload(2)
        }
        if(events[0]>1000 ether){
            score+=30;
        }
        if(borrows[address(this)]==0){
            score+=30;
        }
        if(uint256(slot2)>0x63756974206973207468652062657374207363686f6f6c20696e20434e00003c){
            score+=40;
        }
        
    }
}