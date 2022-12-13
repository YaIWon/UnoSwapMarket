//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './UnoSwapDataObjects.sol';

contract UnoSwapUpdates is UnoSwapDataObjects {

 function updateOwner(address newOwner, uint256 itemId) internal {
 require(msg.sender != address(0), "address 0:owner");
 MarketItem storage marketItem =idToMarketItem[itemId];
 marketItem.currentOwner = newOwner;
 }
 function updateSeller(address newSeller, uint256 itemId) internal {
   require(msg.sender != address(0), "address 0: seller");
   MarketItem storage marketItem =idToMarketItem[itemId];
   marketItem.currentSeller = newSeller;
 }
 function updateListSwapStatus(bool listStatus, uint256 itemId) internal{
   require(msg.sender != address(0), "address 0: listStatus");
   MarketItem storage marketItem =idToMarketItem[itemId];
   marketItem.listForSwap = listStatus;
 }
 function updateAnySwapAvailable(bool swapAvailabilityStatus, uint256 itemId) internal{
   require(msg.sender != address(0), "address 0: swapAvailabilityStatus");
   MarketItem storage marketItem =idToMarketItem[itemId];
   marketItem.anySwapAvailable = swapAvailabilityStatus;
 }
 function updateSwappedStatus(bool swapStatus, uint256 itemId) internal {
   require(msg.sender != address(0), "address 0: swapped");
   MarketItem storage marketItem =idToMarketItem[itemId];
   marketItem.swapped = swapStatus;
 }
 function updateApprovalStatus(bool approvalStatus, uint256 itemId) internal {
   require(msg.sender != address(0), "address 0: approval");
   ApprovalNeeded storage approvalNeeded = idToApproval[itemId];
   approvalNeeded.approved = approvalStatus;
 }
 function updateApprovalNeeded(bool approval, uint256 itemId) internal {
   require(msg.sender != address(0), "address 0: approval");
   ApprovalNeeded storage approvalNeeded = idToApproval[itemId];
   approvalNeeded.approvalneeded = approval;
 }

 function createItem(
   uint256 itemId,
   uint256 tokenId,
   address tokenAddress,
   string memory URI,
   address currentSeller,
   address currentOwner,
   uint256 price,
   bool listForSwap,
   bool anySwapAvailable,
   bool swapped
   ) internal {

     idToMarketItem[itemId] = MarketItem (
       itemId,
        tokenId,
        tokenAddress,
        URI,
        currentSeller,
        currentOwner,
        price,
        listForSwap,
        anySwapAvailable,
        swapped
       );

     emit MarketItemCreated(
       itemId,
       tokenId,
       tokenAddress,
       URI,
       currentSeller,
       currentOwner,
       price,
       listForSwap,
       anySwapAvailable,
       swapped
       );

 }


 function updateItem(
   uint256 itemId,
   uint256 tokenId,
   address tokenAddress,
   string memory URI,
   address currentSeller,
   address currentOwner,
   uint256 price,
   bool listForSwap,
   bool anySwapAvailable,
   bool swapped
   ) internal {

     idToMarketItem[itemId] = MarketItem (
       itemId,
        tokenId,
        tokenAddress,
        URI,
        currentSeller,
        currentOwner,
        price,
        listForSwap,
        anySwapAvailable,
        swapped
       );
 }


 function createUpdateApproval(
  bool approvalneeded,
  uint256 approvalCount,
  uint256 itemId1,
  uint256 itemId2,
  address owner1,
  address owner2,
  uint256 tokenId1,
  uint256 tokenId2,
  bool approved,
  bool requestCanceled
  )

  internal {
   idToApproval[approvalCount] = ApprovalNeeded (
     approvalneeded,
      approvalCount,
      tokenId1,
      tokenId2,
      owner1,
      owner2,
      tokenId1,
      tokenId2,
      approved,
      requestCanceled
     );
 }
}
