pragma solidity ^0.4.22;
contract Demo1{
        int m  = 0;

        function add( int x ) public {
                m = m + x + 14 ;
        }
        function get() public view returns (int) {
                return m;
        }

}
