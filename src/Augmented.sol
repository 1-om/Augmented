// SPDX-License-Identifier: MIT
// / ----------------------------/
// /  YO?!!!?    !!              /
// / <    __!_ _-                /
// /  \ ///  (   )               /
// /=|;/< "! | O \               /
// #-=Ee @ ?| \__|               /
// /   -= _____  |               /
// / / z /     \ |               /
// /-==3 \_____/ |               /
// /    \        |               /
// /    |\______/|               /
// /    | |   |  |______________ /
// /    \  << AUGMENTING... >> / /
// / //   .    ."|  ----       / /
// /   |                       / /
// / ----------------------------/
pragma solidity ^0.8.13;

import "./NFTCollection.sol";

/// @title Augmented
/// @author 0x1om
/// @notice Augments are stories featuring Augies
/// @dev Augies & Augments are ERC721 NFT collections
contract Augmented is Ownable {
    address[] public collections;

    function launch(
        string memory name_,
        string memory symbol_,
        address[] memory house,
        uint256[] memory division,
        uint96 royalty,
        uint256 supply
    )
        public onlyOwner
    {
        collections.push(
            address(new NFTCollection(name_, symbol_, house, division, royalty, supply))
        );
    }


}