// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./../Contract.sol";

contract TestContract is Test {
    Todo todo;

    function setUp() public {
        todo = new Todo();
    }

    function testCreate() public {
        todo.createTask("Buy ETH", "Buying eth for the wallet 0x00");
        assertEq(todo.getTasks()[0].id, 0);
        assertEq(todo.getTasks()[0].title, "Buy ETH");
        assertEq(todo.getTasks()[0].content, "Buying eth for the wallet 0x00");
    }
}
