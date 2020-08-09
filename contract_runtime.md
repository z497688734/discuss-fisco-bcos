# 合约运行方法
```
call Demo 0x07456194d14c1888a6a4358aff384431b48e9159   add 2

getTransactionByHash 0x33359a12f1c6fd57aadd3ed5654f9f3a2644533dba977b67b592ffa3de07caaa

{
    "blockHash":"0x676f254838edc813e14245989c8051ba8ab0c434901149e89ca88f91ee52c4c7",
    "blockNumber":"0x37",
    "from":"0xbd10881e4d4397dd6fe3922efed68847f0aa80c2",
    "gas":"0x11e1a300",
    "gasPrice":"0x11e1a300",
    "hash":"0x33359a12f1c6fd57aadd3ed5654f9f3a2644533dba977b67b592ffa3de07caaa",
    "input":"0x87db03b70000000000000000000000000000000000000000000000000000000000000002",
    "nonce":"0x26fe90f75b671f29d9734be7b1b5de0a7b4f5bf7f21a3033de6fbfa578fe8f7",
    "to":"0x07456194d14c1888a6a4358aff384431b48e9159",
    "transactionIndex":"0x0",
    "value":"0x0"
}

```
看input，把input拆成2部分;0x87db03b7 和0000000000000000000000000000000000000000000000000000000000000002。第一部分是函数名,使用签名的前4个字节，在geth控制台可以验证,第二部分是参数内容.

```
web3.sha3("add(int256)")

```
