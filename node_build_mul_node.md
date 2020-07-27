# 多节点搭建
```
curl -LO https://github.com/FISCO-BCOS/FISCO-BCOS/releases/download/v2.5.0/build_chain.sh && chmod u+x build_chain.sh
 ./build_chain.sh -l "127.0.0.1:4" -p 30300,20200,8545 -v 2.5.0
 ./nodes/127.0.0.1/start_all.sh
```
启动后查看日志,看节点启动是否正常。
如果我们停止掉其中的一个，链还是能正常运行的;如果再停止一个,链就不能正常运行了。
这是拜占庭共识的特点.

