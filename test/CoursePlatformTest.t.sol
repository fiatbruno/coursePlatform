// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {CoursePlatform} from "../src/CoursePlatform.sol";

contract CoursePlatformTest is Test {
    CoursePlatform coursePlatform;

    function setUp() external {
        coursePlatform = new CoursePlatform();
    }

    function testMinimumDollarIsFive() public {
        assertEq(coursePlatform.MINIMUM_USD(), 5e18);
    }
}
