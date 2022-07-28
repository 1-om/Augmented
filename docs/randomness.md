# A survey of fair minting in famous NFTs
---
for [@augmentedPhoto](https://twitter.com/augmentedPhoto)
a look at randomness & minting prices in famous NFTs
---

## Bored Apes

[Bored Apes](https://etherscan.io/address/0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d#code) contract is a single flattened file of all the contracts in the Bored Apes project.

The main contract begins at line1906.
Features:

- **Supply** is defined in the _constructor_. Which means that it is defined at the time of deployment. Its current value is uint256 10000, as expected.
- Another variable defined at the time of deployment is REVEAL_TIMESTAMP. This value is currently uint256 1619820000. The formula in the _constructor_ is ```REVEAL_TIMESTAMP = saleStart + (86400 *9);```, which means reveal is 9 days after the sale starts.
  - The function _setRevealTimestamp_ can override **REVEAL_TIMESTAMP** value.
  - The value of saleStart is ```uint256(1619820000 - (86400* 9))``` which is equal to 1619042400, i.e., "Wed Apr 21 2021 22:00:00 +UTC". The deploy time of the contract is "Apr-22-2021 03:03:16 AM +UTC". Thus the sale started 5 hours before contract deployment.
  If someone is tracking 9 days after deployment for reveal, they will a bit surprised to find it having revealed 5 hours earlier than expected. However, it is also important to note that REVEAL_TIMESTAMP is not used anywhere in the contract.
- Minting is fixed at _apePrice_, which is 0.8 ETH.
  - Max 20 apes are allowed to be minted at one time.
  - Owner can mint 30 apes at any time.
- NFT metadata is set, or overridden by owner using function _setBaseURI_. The value of the base URI is "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/".
- The function _setProvenanceHash_ is used to set **BAYC_PROVENANCE** variable. This variable is not used anywhere in the contract.
- When the last ape is minted the variable _startingIndexBlock_ is set to the block number of that block. After this happens, someone must call a public function _setStartingIndex_ and this sets the value of _startingIndex_ variable to a random non-zero number, less than the total number of apes. Again, these values are not used anywhere in the contract.

## Mutant Ape

[Mutant Ape](https://etherscan.io/address/0x60e4d786628fea6478f785a6d7e704777c86a7c6#code) contract has a file MutantApeYachtClub.sol

- NFT metadata is set, or overridden by owner using function _setBaseURI_. The value of the base URI is "https://boredapeyachtclub.com/api/mutants/".
- Mint price decreases as public sale goes on! After the public sale ends the price is fixed to 0.01 ETH.

## CryptoKitties

[KittyCore](https://etherscan.io/address/0x06012c8cf97bead5deae237070f9587f8e7a266d#code) has a function that will return the contract that can be used to query for NFT metadata. This contract address can be set or overridden by the owner.
- Kitties are created by passing in _genes_ & are then auctioned, starting at a minimum price of 0.01 ETH.

## Crypto Punks

[Punks](https://github.com/larvalabs/cryptopunks/blob/master/contracts/CryptoPunksMarket.sol) are not even ERC721 bro!
- Only a hash of the image file containing all the punks is stored. No methods to use it.
- Minting is free!

## Azuki

[Azuki](https://etherscan.io/token/0xed5af388653567af2f388e6224dc7c4b3241c544#code) has public minting.

- NFT metadata is set, or overridden by owner using function _setBaseURI_. The value of the base URI is "https://ikzttp.mypinata.cloud/ipfs/QmQFkLSQysj94s5GvTHPyzTxrawwtjgiiYS2TBLgrvw8CW" which is a weblink to ipfs resource!
- Mint price is auction drop similar to MAYC.

```solidity
  uint256 public constant AUCTION_START_PRICE = 1 ether;
  uint256 public constant AUCTION_END_PRICE = 0.15 ether;
  uint256 public constant AUCTION_PRICE_CURVE_LENGTH = 340 minutes;
  uint256 public constant AUCTION_DROP_INTERVAL = 20 minutes;
  uint256 public constant AUCTION_DROP_PER_STEP =
    (AUCTION_START_PRICE - AUCTION_END_PRICE) /
      (AUCTION_PRICE_CURVE_LENGTH / AUCTION_DROP_INTERVAL);
```

## NBA Topshots

[Topshots NFT](https://github.com/dapperlabs/nba-smart-contracts/blob/master/contracts/TopShot.cdc) is on a custom Flow blockchain.
Admin makes sets of NFTs called plays & sets a price for their sale. No randomness is involved.

## Meebits

- Function _mintWithPunkOrGlyph_ is used to mint by punk & glyph owners. After that public mint is allowed.
- Meebits index is a random number and not sequential.
- NFT metadata is offchain

```solidity
    function tokenURI(uint256 _tokenId) external view validNFToken(_tokenId) returns (string memory) {
        return string(abi.encodePacked("https://meebits.larvalabs.com/meebit/", toString(_tokenId)));
    }
```

- Mint price is an auction drop.

```solidity
    function getPrice() public view returns (uint) {
        require(publicSale, "Sale not started.");
        uint elapsed = block.timestamp.sub(saleStartTime);
        if (elapsed >= saleDuration) {
            return 0;
        } else {
            return saleDuration.sub(elapsed).mul(price).div(saleDuration);
        }
    }
```

## Artblocks

[Artblocks project](https://etherscan.io/address/0xa7d8d9ef8d8ce8992df33d8b8cf4aebabd5bd270#code) uses a single core erc721 contract to mint all collections!

```solidity
function _mintToken(address _to, uint256 _projectId) internal returns (uint256 _tokenId) {

        uint256 tokenIdToBe = (_projectId * ONE_MILLION) + projects[_projectId].invocations;
```

- NFT metadata can be set & overridden by artist of the project.

## CoolCats

There are 10000 [coolcats](https://etherscan.io/address/0x1a92f7381b9f03921564a437210bb9396471050c#code) that anyone can mint for a price of 0.06 ETH, upto 20 maximum per wallet.

- NFT metadata is set, or overridden by owner using function _setBaseURI_ & also can be supplied at the time of deployment. The value of the base URI is "https://api.coolcatsnft.com/cat/".

## Decentraland

The decentraland [LAND](https://etherscan.io/token/0xf87e31492faf9a91b02ee0deaad50d51d56d5d4d#code) is a proxy, currently pointing to [a land registry contract](https://etherscan.io/address/0x554bb6488ba955377359bed16b84ed0822679cdc) that can be overridden by the owner.

- Decentraland tokenId is also the land coordinate! There is no concept of area of the land.

```solidity

  function _encodeTokenId(int x, int y) internal pure returns (uint result) {
    require(
      -1000000 < x && x < 1000000 && -1000000 < y && y < 1000000,
      "The coordinates should be inside bounds"
    );
    return _unsafeEncodeTokenId(x, y);
  }

  function _unsafeEncodeTokenId(int x, int y) internal pure returns (uint) {
    return ((uint(x) * factor) & clearLow) | (uint(y) & clearHigh);
  }
```

- There is no _tokenURI_ function so it is not ERC721Metadata compliant, but there is a _tokenMetadata_ function that can be used to get the metadata.
