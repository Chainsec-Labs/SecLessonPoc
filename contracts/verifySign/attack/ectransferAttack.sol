pragma solidity ^0.8.0;
//先调用airdrop,算出哈希后用remix签名再调用safeTransfer和isCompleted
import "./ectransfer.sol";
contract ectransferAttack{
    ectransfer ect;
    constructor(address _ect){
        ect  = ectransfer(_ect);
    }
    function fighash()public view returns(bytes32){
        return keccak256(abi.encodePacked(msg.sender, uint256(1 ether), address(ect)));
    }
}