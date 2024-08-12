//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract UnoSwapDataObjects {
  using CountersUpgradeable for CountersUpgradeable.Counter;

    mapping(uint256 => string) internal _tokenURIs;

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
        bool swappedStatus;
    }

    struct SwapCompleted {
        uint256 swapId;
        uint256 itemId1;
        uint256 itemId2;
        address owner1;
        address owner2;
        bool completed;
    }

    struct ApprovalNeeded{
        bool approvalNeeded;
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
