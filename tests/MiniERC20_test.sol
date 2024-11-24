// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.8.20 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../contract/MiniERC20.sol";
import "../interfaces/IERC20.sol";


contract testSuite {
    IERC20 erc20;
    function beforeAll() public {
        MiniERC20 c = new MiniERC20();
        erc20 = IERC20(address(c));
    }

    function checkStorage() public {
        bool success;
        try erc20.balanceOf(address(0)) returns(uint){
            success = true;
        }catch{
            success = false;
        }

        Assert.ok(success == true,"Can not find the balances storage, check the code and ensure it is public");
    }

    function checkTransfer() public {
        try erc20.transfer(address(1),1) returns(bool){
            // pass
        }catch{
            Assert.ok(false,"Can not call the transfer function");
        }

        uint balance = erc20.balanceOf(address(1));
        Assert.greaterThan(balance,uint(0),"Address 1 balance is zero");
    }

    function checkInitialState() public {
        Assert.equal(erc20.name(), "Mini Token", "Token name should be Mini Token");
        Assert.equal(erc20.symbol(), "MINI", "Token symbol should be MINI");
        Assert.equal(erc20.decimals(), 18, "Decimals should be 18");
        Assert.equal(erc20.totalSupply(), 1 ether, "Total supply should be 1 ether");
        
        Assert.greaterThan(erc20.balanceOf(address(this)), uint(0), "Deployer should have tokens");
        Assert.greaterThan(erc20.balanceOf(address(1)), uint(0), "Address 1 should have no tokens");
    }

    function checkApproveUpdate() public {
        erc20.approve(address(1), 1000);
        Assert.equal(erc20.allowance(address(this), address(1)), 1000, "Allowance should be updated to 1000");
    }
}
    