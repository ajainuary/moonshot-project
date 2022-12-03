// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenUp is ERC20 {
    address pool_addr = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    constructor() ERC20("FIFA2022FRAVPOL20221204MTK", "FIFA2022FRAVPOL20221204MTK") {
        _mint(pool_addr, 1000);
    }
}
