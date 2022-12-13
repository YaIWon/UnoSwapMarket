//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "./UnoSwapViews.sol";
import "./UnoSwapUpdates.sol";


contract UnoSwapConnector is ERC721URIStorageUpgradeable ,UnoSwapUpdates ,ReentrancyGuardUpgradeable,UnoSwapViews {

  constructor(string memory Name, string memory Symbol) initializer ERC721Upgradeable() {
__ERC721_init(Name, Symbol);
  }

}
