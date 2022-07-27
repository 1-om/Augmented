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
        vm.expectEmit(true,false,false,true);
        // emit NewSet(address(augmented.launchNewAugieSet("name", "symbol")));
        console.log(augmented.launchNewAugieSet("name", "symbol"));
        augmented.launchNewAugieSet("test","TST");
    }

    function testNewAugieSetLaunchNotAsOwner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        augmented.launchNewAugieSet("test","TST");
    }
}
