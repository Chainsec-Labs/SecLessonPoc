var Web3= require('web3')
const rpcURL = "https://goerli.infura.io/v3/05bed3db7f9c4be29c68cbe048065c22"
const web3 = new Web3(rpcURL)


//拿到data[1]的数据（查询slot[2]存储的数据）
async function get1() {
slot=await web3.eth.getStorageAt("0x99E33A939e7a63033099aBbE832812d67Af2f72F", 2);
console.log(slot);
}
get1()