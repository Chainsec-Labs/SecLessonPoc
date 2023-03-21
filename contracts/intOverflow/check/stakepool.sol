/// @knowledgePoint 整型溢出
 
/// @level 普通
/// @description 1.结构体amount增加.2.token余额增加
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;

        return c;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}
contract ERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) public _balances;

    mapping (address => mapping (address => uint256)) public _allowances;

    string public _name;
    string public _symbol;
    uint8 public _decimals;

    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public virtual returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");
        _balances[account] = _balances[account].add(amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");
        _balances[account] = _balances[account].sub(amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
    }

}

contract ZT is ERC20("ZERO TOKEN", "ZT"){
    //RULE 1
    bytes32 constant RULE_WITHDRAW_WANT = keccak256(abi.encodePacked("withdraw"));

    //RULE 2
    bytes32 constant RULE_NONE_WANT = keccak256(abi.encodePacked("depositByValue"));


    constructor()public{
        _mint(msg.sender,10000000*10**18);
    }
    function depositByWant(uint amount)external payable{
        // uint amount = _amount.mul(10**18);
        require(msg.value>=amount,"you want to trick me?");
        MkaheChange(msg.sender,amount,RULE_NONE_WANT);
    }

    function withdraw(uint amount)external payable returns(bool){
        // uint amount = _amount.mul(10**18);
        require(balanceOf(msg.sender)>=amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        return MkaheChange(msg.sender,amount,RULE_WITHDRAW_WANT);
    }

    function MkaheChange(address to,uint amount,bytes32 ID)internal returns(bool){
        if(ID==RULE_NONE_WANT)
        {
            _balances[msg.sender]=_balances[msg.sender].add(amount);
            return true;
        }else if(ID==RULE_WITHDRAW_WANT){
            bool a;
            (a,)=payable(to).call.value(amount)("");
            require(a,"withdraw fail");
            return true;
        }
        else{
            return false;
        }
    }


    fallback()external payable{
        MkaheChange(
            msg.sender,
            msg.value,
            RULE_NONE_WANT
        );
    }
}
contract stakepool{
    ZT public token;
    uint  totalsupply;
    string symbol;
    mapping(address=>uint)internal workbalance;
    mapping(address=>bool)internal passed;
    struct userInfo{
        uint amount;
        uint duration;
        uint startTime;
    }
    mapping(address=>userInfo)internal userDetails;

    constructor()public{
        token =new ZT();
        symbol = "cuit";
        totalsupply = token.balanceOf(address(this));
    }

    function getDetails(address account)public view returns(userInfo memory){
        return userDetails[account];
    }

    function workBalanceOf(address account)public view returns(uint){
        bool pass=passed[account];
        if(pass){
            return workbalance[account];
        }else{
            return 0;
        }
    }

    function Zt()public view returns(address){
        return address(token);
    }

    function stake(uint amount,uint blocknumber)external{
        require(blocknumber>=1,"At least 1 block");

        userInfo storage user = userDetails[msg.sender];

        user.startTime = block.number;
        user.duration = blocknumber;
        user.amount += amount;
        passed[msg.sender] = false;

        token.transferFrom(msg.sender,address(this),amount*10**18);
        workbalance[msg.sender] += blocknumber;

    }

    function unstake()external{
        userInfo storage user = userDetails[msg.sender];
        require(block.number>=user.startTime+user.duration,"you are in a hurry ");
        passed[msg.sender] = true;
        uint amount = user.amount;
        user.amount = 0;
        token.transfer(msg.sender,amount*10**18);
    }

    function swap(uint amount)external{
        uint balance = workBalanceOf(msg.sender);
        require(balance>=amount,"exceed");
        workbalance[msg.sender] -= amount;
        token.transfer(msg.sender,amount*10**18);
    }

}

contract check is stakepool{
    uint256 public score;
    function isCompleted()public{
        score=0;
        if (getDetails(msg.sender).amount>5000000 ether){
            score+=25;
        }
        if (token.balanceOf(msg.sender)>500000 ether){
            score+=75;
        }
    }
}
