// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/Augmented.sol";

contract AugmentedTest is Test {
    Augmented augmented;
    function setUp() public {
        augmented = new Augmented();
    }
    event NewSet(address indexed augieSet);
    function testNewAugieSetLaunch() public {
        uint[] memory divisions = new uint[](1);
        divisions[0] = 10000;
        address[] memory houses = new address[](1);
        houses[0] = msg.sender;
        augmented.launch("test","TST",houses,divisions,200,0);
    }

    // function testNewAugieSetLaunchNotAsOwner() public {
    //     vm.expectRevert("Ownable: caller is not the owner");
    //     vm.prank(address(0));
    //     augmented.launchNewAugieSet("test","TST");
    // }
}
