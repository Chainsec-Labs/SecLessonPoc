      
from web3 import Web3
# ff+部署合约地址
s1 = '0xff0fC5025C764cE34df352757e82f7B5c4Df39A836'
# 需部署合约字节码哈希
s3 = '7dc9256e55ab34badcafbbf1307df2b18cc6b3317e9b61ee3a7f4771e3b5dac1'

i = 0
while(1):
    salt = hex(i)[2:].rjust(64, '0')
    s = s1+salt+s3
    hashed = Web3.sha3(hexstr=s)
    hashed_str = ''.join(['%02x' % b for b in hashed])
    # “2022”为指定结尾，"[60:]"为后四位
    if '2022' in hashed_str[60:]:
        print("0x"+salt,hashed_str)
        break
    i += 1
    print("0x"+salt)

