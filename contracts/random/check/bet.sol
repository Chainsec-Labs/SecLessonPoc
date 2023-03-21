// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
contract bet{
    bytes32 private number;
    uint private lotteryTime;
    uint public s;
    uint public score;
    mapping(address=>uint)public balance;
    mapping(address=>bool)public betted;

    function mint(address to,uint amount)public{
        require(msg.sender==address(this));
        balance[to]+=amount;
    }

    function cseNumber(bytes32 answer)public{
        number=answer;//which u cann't change
        lotteryTime=block.number;
    }

    function check()internal view returns(bytes32){
        require(block.number>=lotteryTime+1);
        bytes32 result=blockhash(lotteryTime);
        return result;
    }

    function bet2profit()public{
        require(!betted[msg.sender]);
        bytes32 result=check();
        s=0;
        if (uint(number)-uint(result)==0||uint(result)-uint(number)==0){
            this.mint(msg.sender,100);
        }else{
            bytes32 mask=0xf000000000000000000000000000000000000000000000000000000000000000;
            for (uint i=0;i<63;i++){
                if(mask&result==mask&number){
                    s++;
                    if(s>=10){break;}
                }
                mask>>=4;
            }
            this.mint(msg.sender,s*5);
        }
        betted[msg.sender]=true;
    }

    function isComplete()public returns(uint){
        score=0;
        score=balance[msg.sender];
        return score;
    }
}
