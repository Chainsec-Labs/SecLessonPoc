/// @knowledgePoint 函数选择器的计算
 
/// @level 困难
/// @description 1.checkData函数选择器计算正确。2.合约token余额归零。
// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

interface ERC20Like {
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address sender, address spender)
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
        address indexed sender,
        address indexed spender,
        uint256 value
    );
}

interface IFlashloanReceiver {
    function onHintFinanceFlashloan(
        address token,
        address factory,
        uint256 amount,
        bool isUnderlyingOrReward,
        bytes memory data
    ) external;
}

contract ERC20 is IERC20 {
    string public constant name = "ERC20";
    string public constant symbol = "ERC";
    uint8 public constant decimals = 18;
    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    uint256 totalSupply_ = 10 ether;

    constructor() {
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function transfer(address receiver, uint256 amount)
        public
        override
        returns (bool)
    {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[receiver] = balances[receiver] + amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address sender, address spender)
        public
        view
        override
        returns (uint256)
    {
        return allowed[sender][spender];
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        require(amount <= balances[sender]);

        require(amount <= allowed[sender][msg.sender]);

        balances[sender] = balances[sender] - amount;
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}

contract financeVault {
    ERC20 public erc20 = new ERC20();
    bool lock;

    function checkData(bytes4 data)public returns(bool){
        return (data == this.checkData.selector);
    }

    function flashloan(
        address token,
        address receiver,
        uint256 amount,
        uint256 inneramount,
        bool isUnderlyingOrReward,
        bytes calldata data
    ) external {
        uint256 balBefore = ERC20Like(token).balanceOf(address(this));
        ERC20Like(token).transfer(msg.sender, amount);

        lock = false;
        IFlashloanReceiver(receiver).onHintFinanceFlashloan(
            token,
            receiver,
            inneramount,
            isUnderlyingOrReward,
            data
        );
        lock = true;
        uint256 balAfter = ERC20Like(token).balanceOf(address(this));

        require(balAfter == balBefore); // don't want random tokens to get stuck
    }

    function approveAndCall(
        address target,
        uint256 amount,
        bytes calldata data
    ) public returns (bytes memory) {
        require(msg.sender == address(this));

        (bool success, bytes memory returnData) = address(target).call(data);
        require(success, string(returnData));
        return returnData;
    }

}
contract check is financeVault{
    uint256 public score;
    function isCompleted(bytes4 data) public {
        require(lock);
        score = 0;
        if(checkData(data)){
            score+=25;
        }
        if (erc20.balanceOf(address(this)) == 0) {
            score += 75;
        }
    }
}


