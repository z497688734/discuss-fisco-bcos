## 单节点搭建

mac下安装
目前我们官方文档给出的环境搭建都是在linux下测试运行的，实际上调整一下,也能在mac上运行。mac环境需要先安装openssl curl的环境;
```
下载自动脚本
curl -LO https://github.com/FISCO-BCOS/FISCO-BCOS/releases/download/v2.5.0/build_chain.sh && chmod a+x build_chain.sh
初始化环境
./build_chain.sh -l "127.0.0.1:1"
启动
./nodes/127.0.0.1/start_all.sh
```

查看进程
```
ps -ef | grep -v grep | grep fisco-bcos

```

日志输出
```
tail -f nodes/127.0.0.1/node0/log/log_2020072613.05.log

info|2020-07-26 13:11:03.890250|[g:1][CONSENSUS][SEALER]++++++++++++++++ Generating seal on,blkNum=1,tx=0,nodeIdx=0,hash=13c70155...
info|2020-07-26 13:11:03.890799|[g:1][CONSENSUS][PBFT]checkAndChangeView: Reach consensus,org_view=325,cur_changeCycle=1,to_view=326
info|2020-07-26 13:11:03.890821|[g:1][CONSENSUS][PBFT]checkTimeout Succ,view=326,toView=326,nodeIdx=0,changeCycle=1,myNode=641a731
```

控制台
```
cd nodes/127.0.0.1/
./download_console.sh
cp sdk/* console/conf/
cp  console/conf/applicationContext-sample.xml console/conf/applicationContext.xml
./console/start.sh
```

```
There is no hello.sol in the directory of contracts/solidity/
```

在操作控制台命令,获取区块高度

```
getBlockNumber
```
查看到区块高度是0;我们看ETH的公链高度每几秒机会增加,fisco-bcos的高度没有随着时间的增加而增加。

部署一个测试合约，发现高度增加了1
```
deploy HelloWorld
getBlockNumber
getCode 0x16e8178ad85c1a820ace341637a28b8bff278540
call HelloWorld 0x16e8178ad85c1a820ace341637a28b8bff278540 get
call HelloWorld 0x16e8178ad85c1a820ace341637a28b8bff278540 set "Hello, FISCO BCOS"
call HelloWorld  0x16e8178ad85c1a820ace341637a28b8bff278540  get
```

账本的状态没有改变,所以区块高度一直没有增加;当部署合约之后，账本状态发送了改变,高度也发送了改变。ETH公链使用POW机制,需要时时给矿工正反馈的机制,在每个高度产生2ETH的奖励给某个挖矿用户,即在每个高度账本的状态都发生了改变,所以需要产生区块,高度也发生了变化.


-l 指定IP和启动多少台；-l过程经过以下几个关键步骤
* 下载二进制文件
* 生成根证书,节点证书,sdk证书
* 初始化节点和环境配置
