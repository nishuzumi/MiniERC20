pragma solidity ^0.8.20;

import "../contract/MiniERC20.sol";

contract TestMiniERC20{
    MiniERC20 erc20;
    function beforeAll() public {
        erc20 = new MiniERC20();
    }
}