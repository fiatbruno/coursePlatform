// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {CoursePlatform} from "../src/CoursePlatform.sol";

contract DeployCoursePlatform is Script {
    function run() external returns (CoursePlatform) {
        vm.startBroadcast();
        CoursePlatform coursePlatform = new CoursePlatform();
        vm.stopBroadcast();
        return coursePlatform;
    }
}
