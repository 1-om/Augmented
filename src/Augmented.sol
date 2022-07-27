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

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/// @title Augmented
/// @author 0x1om
/// @notice Augments are stories featuring Augies
/// @dev Augies & Augments are ERC721 NFT collections
contract Owned is Ownable{}
contract Augmented is Owned {
    // Augies launch over collections
    struct AugieCollection {
        INFT[] augieCollections;
    }
    AugieCollection augies;

    // Augments are launched over seasons
    struct AugmentSeasons {
        INFT[] augments;
    }
    AugmentSeasons seasons;

    constructor(){}
    // Collection Management
    event NewSet(address indexed augieSet);
    function launchNewAugieSet(string memory name_, string memory symbol_) public onlyOwner {
        INFT newCollection = new NFT(name_, symbol_);
        augies.augieCollections.push(newCollection);
        emit NewSet(address(newCollection));
    }
    function getAugieCollection(uint256 index_) public view returns (INFT) {
        return augies.augieCollections[index_];
    }
    function editAugieTokenURI(uint256 index_,uint augieID, string memory tokenURI_) public onlyOwner {
        INFT augieSet = augies.augieCollections[index_];
        augieSet.setTokenURI(augieID,tokenURI_);
    }
}
interface INFT{
    function setTokenURI(uint tokenID, string memory tokenURI) external;
}

contract NFT is INFT, ERC721URIStorage {
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){}
    function setTokenURI(uint tokenID_,string memory tokenURI_) external {
        _setTokenURI(tokenID_, tokenURI_);
    }
    // Royalty ERC2992
    // emit permanentURI for opensea
}

