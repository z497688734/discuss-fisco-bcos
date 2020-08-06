pragma solidity ^0.6.12;
contract Demo{
	int m  = 0;
	constructor(int y) public {
		m = 15 + y;
	}
	
	function add( int x ) public {
		m = m + x + 14 ;
	}
}
