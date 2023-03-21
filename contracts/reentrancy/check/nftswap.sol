/// @knowledgePoint 重入
 
/// @level 普通
/// @description 1.交换次数大于9。2.调用者余额大于50。
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
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
contract nftswap is ERC721("CUIT","cuit"){
    using Counters for Counters.Counter;
    Counters.Counter counter;

    ERC20 public weth = new ERC20();
    uint256 public swapTimes;

    function deposit(uint256 amount)public payable{
        require(msg.value>=amount,"insufficient value");
        weth.transfer(msg.sender,amount);
    }

    function withdraw()public payable{
        uint256 amount = weth.balanceOf(msg.sender);
        require(amount>0);
        weth.transferFrom(msg.sender,address(this),amount);
        payable(msg.sender).transfer(amount);
    }

    function swap()public{
        require(weth.balanceOf(msg.sender)>0.001 ether,"insufficient balance");
        require(swapTimes<10,"times much");

        weth.transferFrom(msg.sender,address(this),0.001 ether);
        counter.increment();
        _safeMint(msg.sender,counter._value);
        swapTimes+=1;
    }

    function retreat(uint256 tokenID)public{
        require(msg.sender == ownerOf(tokenID));
        safeTransferFrom(msg.sender,address(this),tokenID);
        weth.transfer(msg.sender,0.0001 ether);
        swapTimes-=1;
    }


    
}

contract check is nftswap{
    uint256 public score;
    function isCompleted()public{
        score =0;

        if (swapTimes>9){
            score+=25;
        }

        if(balanceOf(msg.sender)>50){
            score+=75;
        }
    }

    function scoreWithdraw()public{
        if (score==100){
            payable(msg.sender).transfer(address(this).balance);
        }
    }
}