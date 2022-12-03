// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Pool is ERC20, Ownable {
    uint256 pool_shares = 1;
    uint256 pool_value = 1;
    address pool_token = 0xEc29164D68c4992cEdd1D386118A47143fdcF142;
    
    mapping(address => uint256) public value;

    constructor() ERC20("MoonshotPoolShare", "MNSPOOL") {}

    function deposit(uint256 amt) public {
        IERC20(pool_token).transferFrom(msg.sender, address(this), amt);
        uint256 shares = (amt * pool_shares) / pool_value;
        pool_shares += shares;
        pool_value += amt;
        _mint(msg.sender, shares);
    }

    function withdraw(uint256 shares) public {
        _burn(msg.sender, shares);
        uint256 payout = (pool_value * shares) / pool_shares;
        IERC20(pool_token).transfer(msg.sender, payout);
    }

    function setValue(address token_addr, uint256 _value) public onlyOwner {
        value[token_addr] = _value;
    }

    function redeem(address token_addr, uint256 token_amt) public {
        IERC20(token_addr).transferFrom(msg.sender, address(this), token_amt);
        uint256 redeemed_value = token_amt * value[token_addr];
        IERC20(pool_token).transfer(msg.sender, redeemed_value);
    }

    function take_position(address token_addr, uint256 token_amt) public {
        uint256 payment_amt = value[token_addr] * token_amt;
        IERC20(pool_token).transferFrom(msg.sender, address(this), payment_amt);
        uint256 redeemed_value = (token_amt * value[token_addr]);
        IERC20(token_addr).transfer(msg.sender, token_amt);
    }
}
