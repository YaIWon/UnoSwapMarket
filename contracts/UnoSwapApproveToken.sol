//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "./UnoSwapUpdates.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "./UnoSwapConnector.sol";


contract UnoSwapApprove is UnoSwapConnector {

  using CountersUpgradeable for CountersUpgradeable.Counter;
  address UnoSwapMarket;
  address owner;

  constructor(address marketAddress) UnoSwapConnector("Uno Swap","WAP")  {
    owner = payable(_msgSender());
    UnoSwapMarket = marketAddress;
  }
  function setApproved(address tokenAddress, uint256 tokenID) public {
      /* require(_msgSender() == IERC721Upgradeable(tokenAddress).ownerOf(tokenID), "not owner");
      IERC721Upgradeable(tokenAddress).setApprovalForAll(UnoSwapMarket, true);
      require(IERC721Upgradeable(tokenAddress).isApprovedForAll(_msgSender(), UnoSwapMarket), "not approved"); */
      IERC721Upgradeable(tokenAddress).approve(tokenAddress, tokenID);
  }
}
