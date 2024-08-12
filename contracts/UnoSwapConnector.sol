//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "./UnoSwapViews.sol";
import "./UnoSwapUpdates.sol";

contract UnoSwapConnector is ERC721URIStorageUpgradeable, UnoSwapUpdates, ReentrancyGuardUpgradeable, UnoSwapViews, UnoSwapMarket {

    constructor(string memory Name, string memory Symbol) initializer ERC721Upgradeable() {
        __ERC721_init(Name, Symbol);
    }

    function swapToken(uint256 itemId1, uint256 itemId2, uint256 priceRatio) public {
        swapTokenERC20(itemId1, itemId2, priceRatio);
    }
}
