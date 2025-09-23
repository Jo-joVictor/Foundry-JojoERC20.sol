// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from  "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Jojo} from "../src/JojoERC20.sol";

contract DeployJojo is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        Jojo jojo = new Jojo();
        console.log("Deployed Jojo token at:", address(jojo));

        vm.stopBroadcast();
    }
}
