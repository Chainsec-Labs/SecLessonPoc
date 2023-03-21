// SPDX-License-Identifier: MIT

/// @knowledgePoint Dos

/// @level 普通
/// @description 想办法让这个Wallet停止工作（无法正常存取）

pragma solidity ^0.4.0;

contract TrickleWallet {
    uint256 public oldBlance;
    address public partner; // withdrawal partner - pay the gas, split the withdraw
    address  public constant owner = address(0xB8EB5);
    uint public timeLastWithdrawn;
    mapping(address => uint) withdrawPartnerBalances; // keep track of partners balances
 
    constructor()public payable{
        oldBlance = address(this).balance;
    }
    
    function setWithdrawPartner(address _partner) public {
        partner = _partner;
    }
 
    // withdraw 1% to recipient and 1% to owner
    function withdraw() public {
        uint amountToSend = address(this).balance/100;
        // perform a call without checking return
        // The recipient can revert, the owner will still get their share
        partner.transfer(amountToSend);
        owner.transfer(amountToSend);
        
        // keep track of last withdrawal time
        timeLastWithdrawn = now;
        withdrawPartnerBalances[partner] = withdrawPartnerBalances[partner] + amountToSend;
    }

    function balanceof() public view returns(uint256){
        return owner.balance;
    }
 
    // don't allow deposit of funds
    function() external {}

}

contract Check {
    TrickleWallet public wallet;
    uint256 public score;
    constructor(address _wallet) public {
        wallet = TrickleWallet(_wallet);
    }

    function isCompleted() public {
        score = 0;
        uint256 oldbalance = wallet.balanceof();
        wallet.call(abi.encodeWithSignature("withdraw()"));
        if(isContract(msg.sender)){
            score = 25;
        }
        if(oldbalance == wallet.balanceof()){
            score = 100;
        }
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}