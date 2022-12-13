//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./UnoSwapConnector.sol";
contract UnoSwapMarket is UnoSwapConnector {




 using CountersUpgradeable for CountersUpgradeable.Counter;

  address public owner;
  address internal SingleSwap;


  constructor() UnoSwapConnector("UnoSwap", "SWAP")  {
    owner = payable(_msgSender());
  }
  function mintTokens(string memory tokenURI) internal returns (uint256) {
   _tokenIds.increment();
   uint256 newTokenId = _tokenIds.current();
   _safeMint(_msgSender(),newTokenId);
   _setTokenURI(newTokenId, tokenURI);
   _tokenURIs[newTokenId] = tokenURI;
  // _setApprovalForAll(_msgSender(),address(this), true);
   //approve(address(this), newTokenId);
   return newTokenId;
 }

  function createToken(uint256 tokenId,address tokenAddress,string memory tokenURI,uint256 price,
    bool listForSwap, bool anySwapAvailable) public {

      if(tokenAddress == address(this)) {
        tokenId = mintTokens(tokenURI);
      }
      else if (tokenAddress != address(this)) {
        //IERC721Upgradeable(tokenAddress).approve(address(this), tokenId);
        //require(IERC721Upgradeable(msg.sender).getApproved(tokenId) == address(this), "UnoSwap ,not Approved");
      }
            _itemsIds.increment();
            uint256 currentItemId = _itemsIds.current();


      if(listForSwap){
          createItem(
            currentItemId,
            tokenId,
            tokenAddress,
            tokenURI,
            msg.sender,
            msg.sender,
            price,
            listForSwap,
            anySwapAvailable,
            false
            );

      }

      else if(!listForSwap) {
          createItem(
            currentItemId,
            tokenId,
            tokenAddress,
            tokenURI,
            address(0),
            msg.sender,
            price,
            listForSwap,
            anySwapAvailable,
            false
            );
        }


}

  function Owner() public view returns(address){
    return owner;
  }


 function transferToken(address tokenAddress,address to, uint256 tokenId) public {
     IERC721Upgradeable(tokenAddress).safeTransferFrom(_msgSender(),to, tokenId);
  }

  /* function burnToken(uint256 tokenId) public {

    _burn(tokenId);
  } */

   function swapToken(uint256 ItemId1, uint256 ItemId2)
  public payable swapable(ItemId1, ItemId2) nonReentrant {
    MarketItem storage marketItem1 = idToMarketItem[ItemId1]; // this is the item already listed
    MarketItem storage marketItem2 = idToMarketItem[ItemId2]; // this is the token that a user want to swap out
    address tokenAddress1 = marketItem1.tokenAddress;
    address tokenAddress2 = marketItem2.tokenAddress;


    if(marketItem1.anySwapAvailable) {
      if(marketItem2.listForSwap) {
        swapIfanySwapAvailable(marketItem1, marketItem2);
      }
      else if(!marketItem2.listForSwap)  {
        //TODO this needs work for sure
        swapIfanySwapAvailable(marketItem1, marketItem2);
      }

    }
    else if (!marketItem1.anySwapAvailable) {
      if(marketItem2.listForSwap) {
        //TODO//This needs work check if approval is function
        swapIfNotanySwapAvailable(marketItem1, marketItem2);


      }
      else if(!marketItem2.listForSwap) {
        //TODO//This needs work check if approval is function
        //IERC721(nftContract).setApprovalForAll(address(this), true);
        swapIfNotanySwapAvailable(marketItem1, marketItem2);

    }
  }
}

/* function swapToken(uint256 ItemId1, uint256 ItemId2)
public payable nonReentrant {

  MarketItem storage marketItem1 = idToMarketItem[ItemId1]; // this is the item already listed
  MarketItem storage marketItem2 = idToMarketItem[ItemId2]; // this is the token that a user want to swap out
  address tokenAddress1 = marketItem1.tokenAddress;
  address tokenAddress2 = marketItem2.tokenAddress;

  if(marketItem1.anySwapAvailable) {
    if(marketItem2.listForSwap) {
      swapIfanySwapAvailable(marketItem1, marketItem2);
    }
    else if(!marketItem2.listForSwap)  {
      //TODO this needs work for sure
      swapIfanySwapAvailable(marketItem1, marketItem2);
    }

  }
  else if (!marketItem1.anySwapAvailable) {
    if(marketItem2.listForSwap) {
      //TODO//This needs work check if approval is function
      swapIfNotanySwapAvailable(marketItem1, marketItem2);


    }
    else if(!marketItem2.listForSwap) {
      //TODO//This needs work check if approval is function
      //IERC721(nftContract).setApprovalForAll(address(this), true);
      swapIfNotanySwapAvailable(marketItem1, marketItem2);

  }
}
} */

  function swapIfanySwapAvailable(MarketItem memory marketItem1,MarketItem memory marketItem2) internal {
    //TODO work on the NFTContract for external tokens from different contract;

    address owner1 = marketItem1.currentOwner;
    address owner2 = marketItem2.currentOwner;
    uint256 tokenId1 = marketItem1.tokenId;
    uint256 tokenId2 = marketItem2.tokenId;
    address contract1 = marketItem1.tokenAddress;
    address contract2 = marketItem2.tokenAddress;
    uint256 itemId1 =  marketItem1.itemId;
    uint256 itemId2 =  marketItem2.itemId;

    require(marketItem1.listForSwap,"not listed to swap");


    IERC721Upgradeable(contract2).safeTransferFrom(owner2, owner1, tokenId2);
    IERC721Upgradeable(contract1).safeTransferFrom(owner1, owner2, tokenId1);



    _numSwapTransactions.increment();
    uint256 totalNumswaps = _numSwapTransactions.current();

    idToSwapsCompleted[totalNumswaps] = SwapCompleted(
    totalNumswaps,
    tokenId1,
    tokenId2,
    owner1,
    owner2
);

  updateOwner(owner1, itemId2);
  updateSeller(address(0), itemId2);
  updateListSwapStatus(false, tokenId2);
  updateAnySwapAvailable(false, itemId2);
  updateSwappedStatus(true,itemId2);
  //TODO I need to update the contract


  updateOwner(owner2, itemId1);
  updateSeller(address(0), itemId1);
  updateListSwapStatus(false, itemId1);
  updateAnySwapAvailable(false, itemId1);
  updateSwappedStatus(true,itemId1);

  emit Swapped(totalNumswaps ,owner1, owner2, tokenId1, tokenId2);
  }

  function swapIfNotanySwapAvailable(MarketItem memory marketItem1,MarketItem memory marketItem2)
  internal {
    _approvalCount.increment();
  uint256 newApprovalCount = _approvalCount.current();
  address owner1 = marketItem1.currentOwner;
  address owner2 = marketItem2.currentOwner;
  uint256 tokenId1 = marketItem1.tokenId;
  uint256 tokenId2 = marketItem2.tokenId;

  //TODO update the struct data, the false- false

//TODO this needs work bc I added the itemids to approvals
    /* idToApproval[newApprovalCount] = ApprovalNeeded (
      true,
      newApprovalCount,
      owner1,
      owner2,
      tokenId1,
      tokenId2,
      false,
      false
    ); */

  }

  function approveSwap(uint256 numApproval) public
  approvable(numApproval) {

      ApprovalNeeded storage approvalNeeded = idToApproval[numApproval];
      _numSwapTransactions.increment();

      uint256 newNumSwaps = _numSwapTransactions.current();

      address owner1 = _msgSender();
      address owner2 = approvalNeeded.owner2;
      uint256 tokenId1 = approvalNeeded.tokenId1;
      uint256 tokenId2 = approvalNeeded.tokenId2;

      MarketItem storage marketItem1 = idToMarketItem[tokenId1]; // this is the item already listed
      MarketItem storage marketItem2 = idToMarketItem[tokenId2]; // this is the token that a user want to swap out

      address contract1 = marketItem1.tokenAddress;
      address contract2 = marketItem2.tokenAddress;

      uint256 itemId1 =  marketItem1.itemId;
      uint256 itemId2 =  marketItem2.itemId;

      IERC721Upgradeable(contract2).safeTransferFrom(owner2, owner1, tokenId2);
      IERC721Upgradeable(contract1).safeTransferFrom(owner1, owner2, tokenId1);

      idToSwapsCompleted[newNumSwaps] = SwapCompleted(
      newNumSwaps,
      tokenId1,
      tokenId2,
      owner1,
      owner2
      );

      updateOwner(owner1, itemId2);
      updateSeller(address(0), itemId2);
      updateListSwapStatus(false, itemId2);
      updateAnySwapAvailable(false, itemId2);
      updateSwappedStatus(true,itemId2);


      updateOwner(owner2, itemId1);
      updateSeller(address(0), itemId1);
      updateListSwapStatus(false, itemId1);
      updateAnySwapAvailable(false, itemId1);
      updateSwappedStatus(true,itemId1);

      emit Swapped(newNumSwaps ,owner1, owner2, tokenId1, tokenId2);
      //TODO update the approval struct
  }


function cancelSwapRequest(uint256 tokenId) public nonReentrant {
  ApprovalNeeded storage approvalNeeded = idToApproval[tokenId];
  uint256 tokenId2 = approvalNeeded.tokenId2;
  require(_msgSender() == approvalNeeded.owner2, "canceling request not owned");
  approvalNeeded.requestCanceled = true;
  //TODO ERC721 functionality to make sure i return the token;
}

function isApprovedForAll(
    address _owner,
    address _operator

) public override view returns (bool isOperator) {
    if (_operator == address(this)) {
        return true;
    }
//TODO THIS NEEDS to work with outsider token
    return isApprovedForAll(_owner, _operator);
}

function updateListingData(uint256 itemId,bool listForSwap, bool anySwapAvailable) public{
  updateAnySwapAvailable(anySwapAvailable, itemId);
  if(listForSwap) {
  updateSeller(_msgSender(), itemId);
  updateListSwapStatus(listForSwap, itemId);
  }
  else if(listForSwap == false) {
  updateListSwapStatus(listForSwap, itemId);
  }
}

/* function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
) internal override{
  //TODO this needs work
  require(_msgSender() == ownerOf(tokenId));

} */
  /* function _afterTokenTransfer(
    address from,
    address to,
    uint256 tokenId
) internal override {

} */


 modifier swapable (uint256 itemId1, uint256 itemId2) {
  MarketItem storage marketItem1 = idToMarketItem[itemId1];
  MarketItem storage marketItem2 = idToMarketItem[itemId2];
  address tokenContract2 = marketItem2.tokenAddress;
  address tokenContract1 = marketItem1.tokenAddress;

  uint256 tokenId1 = marketItem1.tokenId;
  uint256 tokenId2 = marketItem2.tokenId;
  require(_msgSender() == IERC721Upgradeable(tokenContract2).ownerOf(tokenId2), "SingleSwap: you own this token");
  require(IERC721Upgradeable(tokenContract1).ownerOf(tokenId1)!= address(0),"ERC721: token does not exist 1");
  _;
}
modifier approvable(uint256 approvalNumber) {
  //TODO this needs so much work
  ApprovalNeeded memory approvalNeeded = idToApproval[approvalNumber];
  uint256 itemId1 = approvalNeeded.itemId1;
  uint256 itemId2 = approvalNeeded.itemId2;

  require(approvalNeeded.requestCanceled == false, "request no longer available");
  require(_msgSender() == approvalNeeded.owner1, "you do not own this token");
  require(approvalNeeded.approved == false, "this swap is already approved");
  address owner2 = approvalNeeded.owner2;
  uint256 tokenId2 = approvalNeeded.tokenId2;
  MarketItem storage marketItem2 = idToMarketItem[itemId2];
  address tokenAddress2 = marketItem2.tokenAddress;
  address sameOwner2 = IERC721Upgradeable(tokenAddress2).ownerOf(tokenId2);
  require(owner2 == sameOwner2,"owner swapped token");
  require(owner2 != address(0), "address(0)");
  _;
}



function setApproved(address user) public {
  setApprovalForAll(user,true);
}
}
