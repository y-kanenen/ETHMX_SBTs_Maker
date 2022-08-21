// Web3Mint.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
// いくつかの OpenZeppelin のコントラクトをインポートします。
//import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./libraries/Base64.sol";
import "hardhat/console.sol";

contract Web3Mint is ERC721{
    struct NftAttributes{
        string name;
        string imageURL;
    }

    NftAttributes[] Web3Nfts;

    using Counters for Counters.Counter;
    // tokenIdはNFTの一意な識別子で、0, 1, 2, .. N のように付与されます。
    Counters.Counter private _tokenIds;

    uint256 constant MAX_NFT_NUMBER = 10;

    event NewNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("NFT","nft"){
        console.log("This is my NFT contract.");
    }

    // ユーザーが NFT を取得するために実行する関数です。

    function mintIpfsNFT(string memory name,string memory imageURI) public{
        uint256 newItemId = _tokenIds.current();
        require(
            newItemId < MAX_NFT_NUMBER,
            "Max value of minting NFT is exceeded."
        );
        _safeMint(msg.sender,newItemId);
        Web3Nfts.push(NftAttributes({
            name: name,
            imageURL: imageURI
        }));
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        console.log("The number of Minted NFT is %s / %s", newItemId, MAX_NFT_NUMBER);
        emit NewNFTMinted(msg.sender, newItemId);
        
        _tokenIds.increment();
    }
    function tokenURI(uint256 _tokenId) public override view returns(string memory){
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        Web3Nfts[_tokenId].name,
                        ' -- SBTs #: ',
                        Strings.toString(_tokenId),
                        '", "description": "An epic NFT", "image": "ipfs://',
                        Web3Nfts[_tokenId].imageURL,'"}'
                    )
                )
            )
        );
        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        return output;
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal override(ERC721)
    {
        // if sender is a 0 address, this is a mint transaction, not a transfer
        require(from == address(0), "ERR: TOKEN IS SOUL BOUND");
        super._beforeTokenTransfer(from, to, tokenId);
    }
}