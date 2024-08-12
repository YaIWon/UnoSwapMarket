//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import './UnoSwapDataObjects.sol';
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract UnoSwapViews is UnoSwapDataObjects {

    using CountersUpgradeable for CountersUpgradeable.Counter;

    function lookUpToken(uint256 itemId) public view returns (MarketItem memory) {
        return idToMarketItem[itemId];
    }

    function allTokens() public view returns (MarketItem[] memory) {
        uint256 totalTokenCount = _itemsIds.current();
        uint256 currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](totalTokenCount);
        for (uint256 i = 0; i < totalTokenCount; i++) {
            MarketItem storage currentItem = idToMarketItem[i + 1];
            items[currentIndex] = currentItem;
            currentIndex += 1;
        }
        return items;
    }

    function fetchAllApprovals() public view returns (ApprovalNeeded[] memory) {
        uint256 totalApprovalCount = _itemsIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalApprovalCount; i++) {
            if (idToApproval[i + 1].approvalNeeded) {
                itemCount += 1;
            }
        }

        ApprovalNeeded[] memory approvals = new ApprovalNeeded[](itemCount);
        for (uint256 i = 0; i < totalApprovalCount; i++) {
            if (idToApproval[i + 1].approvalNeeded) {
                ApprovalNeeded storage currentApproval = idToApproval[i + 1];
                approvals[currentIndex] = currentApproval;
                currentIndex += 1;
            }
        }
        return approvals;
    }

    function marketTokens() public view returns (MarketItem[] memory) {
        uint256 totalTokenCount = _itemsIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalTokenCount; i++) {
            if (idToMarketItem[i + 1].listForSwap) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalTokenCount; i++) {
            if (idToMarketItem[i + 1].listForSwap == true) {
                MarketItem storage currentItem = idToMarketItem[i + 1];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    function userTokens() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _itemsIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].currentOwner == msg.sender) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].currentOwner == msg.sender) {
                MarketItem storage currentItem = idToMarketItem[i + 1];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    function requestsSent() public view returns (ApprovalNeeded[] memory) {
        uint256 totalApprovalCount = _approvalCount.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalApprovalCount; i++) {
            if (idToApproval[i + 1].owner2 == msg.sender) {
                itemCount += 1;
            }
        }
        ApprovalNeeded[] memory approvals = new ApprovalNeeded[](itemCount);
        for (uint256 i = 0; i < totalApprovalCount; i++) {
            if (idToApproval[i + 1].owner2 == msg.sender) {
                ApprovalNeeded storage currentApproval = idToApproval[i + 1];
                approvals[currentIndex] = currentApproval;
                currentIndex += 1;
            }
        }
        return approvals;
    }
 function requestsReceived() public view returns (ApprovalNeeded[] memory) {
        uint256 totalApprovalCount = _approvalCount.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalApprovalCount; i++) {
            if (idToApproval[i + 1].owner1 == msg.sender) {
                itemCount += 1;
            }
        }
        ApprovalNeeded[] memory approvals = new ApprovalNeeded[](itemCount);
        for (uint256 i = 0; i < totalApprovalCount; i++) {
            if (idToApproval[i + 1].owner1 == msg.sender) {
                ApprovalNeeded storage currentApproval = idToApproval[i + 1];
                approvals[currentIndex] = currentApproval;
                currentIndex += 1;
            }
        }
        return approvals;
    }

    function completedSwaps() public view returns (SwapCompleted[] memory) {
        uint256 totalSwapCount = _numSwapTransactions.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;
        for (uint256 i = 0; i < totalSwapCount; i++) {
            if (idToSwapsCompleted[i + 1].owner1 == msg.sender || idToSwapsCompleted[i + 1].owner2 == msg.sender) {
                itemCount += 1;
            }
        }
        SwapCompleted[] memory swapsCompleted = new SwapCompleted[](itemCount);
        for (uint256 i = 0; i < totalSwapCount; i++) {
            if (idToSwapsCompleted[i + 1].owner1 == msg.sender || idToSwapsCompleted[i + 1].owner2 == msg.sender) {
                SwapCompleted storage swapCompleted = idToSwapsCompleted[i + 1];
                swapsCompleted[currentIndex] = swapCompleted;
                currentIndex += 1;
            }
        }
        return swapsCompleted;
    }
