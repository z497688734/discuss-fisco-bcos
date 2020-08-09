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
