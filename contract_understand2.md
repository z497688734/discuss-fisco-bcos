
智能合约编译后的字节码，分为三个部分：部署代码、runtime代码、auxdata。

部署代码：以上面的输出结果为例，EVM虚拟机在创建合约的时候，会先创建合约账户，然后运行部署代码。运行完成后它会将runtime代码+auxdata 存储到区块链上。之后再把二者的存储地址跟合约账户关联起来(也就是把合约账户中的code hash字段用该地址赋值)，这样就完成了合约的部署。


runtime代码：运行时代码。

auxdata：每个合约最后面的43字节就是auxdata，它会紧跟在runtime代码后面被存储起来。

solc命令的--bin-runtime选项，输出了runtime代码和auxdata，省略了部署代码，使用remix-ide也可以


还使用这一段代码做实验保持为Demo.sol
```
pragma solidity ^0.4.22;
contract Demo{
	int m  = 0;
	constructor(int y) public {
		m = 15 + y;
	}

	function add( int x ) public {
		m = m + x + 14 ;
	}
	function get( ) public view returns (int) {
		return m;
	}
}
```
拷贝到控制台目录下
```
cp ~/Documents/learn/discuss-fisco-bcos/code_and_doc/Demo.sol ~/2cWorkPlace/demo-fisco-bcos/demo2/nodes/127.0.0.1/console/contracts/solidity/Demo.sol
```

部署合约，查看交易详情
```
deploy Demo  1

0x60806040526000805534801561001457600080fd5b506040516020806101368339810180604052810190808051906020019092919050505080600f016000819055505060e6806100506000396000f3006080604052600436106049576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680636d4ce63c14604e57806387db03b7146076575b600080fd5b348015605957600080fd5b50606060a0565b6040518082815260200191505060405180910390f35b348015608157600080fd5b50609e6004803603810190808035906020019092919050505060a9565b005b60008054905090565b600e816000540101600081905550505600a165627a7a723058200960bbebe37420b881a6628299716dbcd0864f165b2256e475f2cf670fcc6b5200290000000000000000000000000000000000000000000000000000000000000001
```

使用solo编译



