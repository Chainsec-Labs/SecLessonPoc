/// @knowledgePoint 浮点和精度
 
/// @level 困难
/// @description 1.token1归零.2.token2归零
pragma solidity ^0.6.0;
interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract ERC20 is IERC20 {

    string public constant name = "ERC20";
    string public constant symbol = "ERC";
    uint8 public constant decimals = 18;
    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_ = 10 ether;


   constructor(uint256 initBal)public {
    balances[msg.sender] = initBal;
    }

    function totalSupply() public override view returns (uint256) {
    return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender]-numTokens;
        balances[receiver] = balances[receiver]+numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner]-numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender]-numTokens;
        balances[buyer] = balances[buyer]+numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}
contract swapdex{
    ERC20 public token1 = new ERC20(105);
    ERC20 public token2 = new ERC20(55);
    bool isAir;


    function airdrop()public{
        require(!isAir);
        isAir=true;
        token1.transfer(msg.sender,5);
        token2.transfer(msg.sender,5);
    }

    function swap(address from,address to,uint256 amount)public{
        require((from==address(token1) && to == address(token2))||(from==address(token2) && to == address(token1)));
        (ERC20 tokenA,ERC20 tokenB) = from == address(token1)?(token1,token2):(token2,token1);
        uint256 amountNeed = getAmountNeed(from,to,amount);

        require(tokenA.transferFrom(msg.sender,address(this),amountNeed));

        tokenB.transfer(msg.sender,amount);
    }

    function getAmountNeed(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(from).balanceOf(address(this)))/IERC20(to).balanceOf(address(this)));
  }


}

contract check is swapdex{
    uint256 public score;
    function isCompleted()public{
        score=0;
        if (token1.balanceOf(address(this))==0){
            score+=50;
        }
        if (token2.balanceOf(address(this))==0){
            score+=50;
        }
    }
}