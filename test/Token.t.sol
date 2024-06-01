// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Memecoin} from "../src/Token.sol";

contract CounterTest is Test {
    Memecoin public memecoin;

    function setUp() public {
        uint256 initialSupply = 10000000;
        memecoin = new Memecoin(initialSupply);
    }

    // function test_Increment() public {
    //     counter.increment();
    //     assertEq(counter.number(), 1);
    // }

    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
