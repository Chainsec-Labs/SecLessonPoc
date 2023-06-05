contract Exploit {
    
    function isCompleted(address che) public {
        array(che).number_add(1);
        array(che).isCompleted();
    }
}
