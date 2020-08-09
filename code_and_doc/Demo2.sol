pragma solidity ^0.4.22;
contract Demo2{
        int m  = 0;

        constructor(int y) public {
		    m = 15 + y;
    	}
        function add( int x ) public {
                m = m + x + 14 ;
        }
        function get() public view returns (int) {
                return m;
        }

}
