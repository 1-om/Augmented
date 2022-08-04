// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "openzeppelin/contracts/token/common/ERC2981.sol";
import "openzeppelin/contracts/finance/PaymentSplitter.sol";
import "openzeppelin/contracts/utils/Strings.sol";
import "openzeppelin/contracts/utils/Base64.sol";
// import "chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract NFTCollection is
    Ownable
    , ERC721URIStorage
    , ERC721Enumerable
    , ERC2981
    , PaymentSplitter
    // , VRFConsumerBaseV2
{
    string internal baseURI;
    address internal vrfCoordinator;
    uint256 public mintPrice = 0.5 ether;
    uint256 public supply;

    /// @param royalty total in basis points
    constructor(
        string memory _name
        , string memory _symbol
        , address[] memory house
        , uint256[] memory division
        , uint96 royalty
        , uint256 _supply
    )
        ERC721(_name, _symbol)
        PaymentSplitter(house, division)
        // VRFConsumerBaseV2(vrfCoordinator)
    {
        _setDefaultRoyalty(address(this), royalty);
        supply = _supply;
    }

    function mint() public payable {
        require(msg.value >= mintPrice, "Not enough ether");

        uint256 id = totalSupply();
        require(id < supply, "Collection is sold out");
        _mint(msg.sender, id);
    }

    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
    }

    function setTokenURI(uint256 _tokenID, string memory _tokenURI)
        public
        onlyOwner
    {
        if (_tokenID >= supply) {
            supply++;
            require(_tokenID < supply, "Token ID is out of sequence");
            listOnExchanges(_tokenID);
        }
        _setTokenURI(_tokenID, _tokenURI);
    }

    function listOnExchanges(uint256 _tokenID) public {
        // TODO
    }

    function setBaseURI(string memory baseURI_) public onlyOwner {
        baseURI = baseURI_;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    // function fulfillRandomWords(uint256 requestID, uint256[] memory randomWords)
    //     internal
    //     override
    // {
    //     _revealCast(requestID, randomWords);
    // }

    // function _revealCast(uint256 requestID, uint256[] memory randomWords)
    //     internal
    // {
    //     // use the random words to generate the number between 1 and x
    //     uint256 randomNumber = 0;
    //     for (uint256 i = 0; i < randomWords.length; i++) {
    //         randomNumber = randomNumber * 32 + randomWords[i];
    //     }
    //     uint256 randomNumberModulo = randomNumber % 100;
    //     _updateURI(requestID, randomNumberModulo);
    // }

    // function _updateURI(uint256 requestID, uint256 randomNumberModulo)
    //     internal
    // {
    //     // update the URI with the random number
    //     string memory uri;
    //     _setTokenURI(requestID, uri);
    // }

    // required by ERC721Enumerable
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override (ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override (ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override (ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    // required by ERC2981 implementation
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override (ERC721, ERC721Enumerable, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
// TODO: emit permanentURI for opensea on metadata finalization
}