/// @knowledgePoint 整型溢出
 
/// @level 普通
/// @description 1.合约余额减少到1ether以下.2.自己的余额增加到50w以上
pragma solidity ^0.6.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract ERC20 is IERC20 {
    string public constant name = "ERC20";
    string public constant symbol = "ERC";
    uint8 public constant decimals = 18;
    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    uint256 totalSupply_ = 500000 ether;

    constructor() public {
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens)
        public
        override
        returns (bool)
    {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens)
        public
        override
        returns (bool)
    {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate)
        public
        override
        view
        returns (uint256)
    {
        return allowed[owner][delegate];
    }

    function transferFrom(
        address owner,
        address buyer,
        uint256 numTokens
    ) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}

contract amountOut {
    uint256 decimals = 1 ether;
    mapping(address => uint256) public balances;
    bool airdroped;
    ERC20 public token = new ERC20();

    function deposit(uint256 amount) public {
        uint256 value = amount * decimals;
        require(token.balanceOf(msg.sender) >= value);
        require(token.transferFrom(msg.sender, address(this), value));
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public {
        uint256 value = amount * decimals;
        require(balances[msg.sender] > amount);
        balances[msg.sender] -= amount;
        token.transfer(msg.sender, value);
    }

    function transfers(address[] memory _receivers, uint256 amount)
        public
        returns (bool)
    {
        uint256 cnt = _receivers.length;
        uint256 value = uint256(cnt) * amount;

        require(cnt > 0 && cnt <= 20,"too long length");
        require(amount > 0 && balances[msg.sender] >= value,"balance or amount");
        balances[msg.sender]-=value;
        for (uint256 i = 0; i < cnt; i++) {
            balances[_receivers[i]]+=amount;
        }
        return true;
    }

    function airdrop() public {
        require(!airdroped);
        airdroped = true;
        balances[msg.sender]+=2;
    }

}

contract check is amountOut{
    uint256 public score;
    function isCompleted()public{
        score=0;
        if (token.balanceOf(address(this))<1 ether){
            score += 50;
        }

        if (balances[msg.sender]>=500000){
            score += 50;
        }
    }
}

