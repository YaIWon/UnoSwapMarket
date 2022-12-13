//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract UnoSwapDataObjects {
  using CountersUpgradeable for CountersUpgradeable.Counter;

    mapping(uint256 => string) internal _tokenURIs;

    //TODO
    /*
   *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
   *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
   *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
   *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
   *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
   *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
   *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
   *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
   *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
   *
   *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
   *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
   */
    /*
     bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    */
    /*
    *     bytes4(keccak256('name()')) == 0x06fdde03
    *     bytes4(keccak256('symbol()')) == 0x95d89b41
    *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
    *
    *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
    */
   //bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

   /*
    *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
    *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
    *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
    *
    *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
    */
   //bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

   /**
    * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
    */

    MarketItem[] public tokens;
    CountersUpgradeable.Counter public _itemsIds;
    CountersUpgradeable.Counter public _tokenIds;
    CountersUpgradeable.Counter public _numSwapTransactions;
    CountersUpgradeable.Counter public _approvalCount;
    CountersUpgradeable.Counter public randomItem;

    // _itemID to the the nft
    mapping(uint256 => MarketItem) public idToMarketItem;
    // _itemID to the approval
    mapping(uint256 => ApprovalNeeded) public idToApproval;
    // _itemID to the completedswap
    mapping(uint256 => SwapCompleted) public idToSwapsCompleted;
    // _itemID to keep track if it was approved
    mapping(uint256 => bool) public idToOperatorApprovals;


    struct MarketItem {
    uint256 itemId;
    uint256 tokenId;
    address tokenAddress;
    string URI;
    address currentSeller;
    address currentOwner;
    uint256 price;
    bool listForSwap;
    bool anySwapAvailable;
    bool swapped;
    }

    struct SwapCompleted {
    uint256 numSwapTransactions;
    uint256 tokenId1;
    uint256 tokenId2;
    address owner1;
    address owner2;
    }

    struct ApprovalNeeded{
     bool approvalneeded;
     uint256 approvalCount;
     uint256 itemId1;
     uint256 itemId2;
     address owner1;
     address owner2;
     uint256 tokenId1;
     uint256 tokenId2;
     bool approved;
     bool requestCanceled;
     }

     event MarketItemCreated(
       uint256 itemId,
       uint256 tokenId,
       address tokenAddress,
       string URI,
       address currentSeller,
       address currentOwner,
       uint256 price,
       bool listForSwap,
       bool anySwapAvailable,
       bool swapped
      );

     event Swapped(
      uint256 swapCount,
      address indexed owner1,
      address indexed owner2,
      uint256 tokenId1,
      uint256 tokenId2
      );

uint256 public itemsIds;

function getItemsIds() public view returns(uint256) {
  return itemsIds;
}
}
