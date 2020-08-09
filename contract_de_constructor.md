# 合约析构方法

selfdestruct
调用析构 合约字节码清除
```
pragma solidity ^0.4.22;
contract Demo3{
	int m  = 0;
	address public minter;
	constructor(int y) public {
		m = 15 + y;
		minter = msg.sender;
	}
	function add( int x ) public {
		m = m + x + 14 ;
	}
	function get() public view returns (int) {
		return m;
	}

	function kill() public {
       if (minter == msg.sender) { // 权限检查
          selfdestruct(minter); // 销毁合约
       }
    }

}
```

运行以上代码
```
deploy Demo3 1

 ./start.sh  1  -pem  ./accounts/0x302f78599c9d62cffdd0b81b9d9b18ff77217056.pem

 //使用非生成合约的账号kill,字节码没有清空
 call Demo3 0xc69fb8bb9785fbbf3af12cafca50ba41876b0882 kill

//使用合约生成的账号可以清除字节码


```

