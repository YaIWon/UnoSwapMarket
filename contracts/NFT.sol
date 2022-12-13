//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";
import "./UnoSwapUpdates.sol";
import "./UnoSwapConnector.sol";

contract NFT is UnoSwapConnector {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter public _tokenId;
    address owner;
    address marketContractAddress;

      constructor(address marketAddress) UnoSwapConnector("Uno Swap","WAP")  {
        owner = payable(msg.sender);
        marketContractAddress = marketAddress;

      }
    function Owner() public view returns(address){
      return owner;
    }


    function mintTokens(string memory tokenURI) public returns (uint256) {
        _tokenId.increment();
        uint256 newNFTId = _tokenId.current();
        _safeMint(_msgSender(),newNFTId);
        _setTokenURI(newNFTId, tokenURI);
        //setApprovalForAll(marketContractAddress, true);
        IERC721Upgradeable(address(this)).approve(address(this), newNFTId);

        return newNFTId;
    }
    function incrementId() public {
      _itemsIds.increment();
       itemsIds++;
      _itemsIds.increment();
    }
    function returnId() public view returns(uint256) {
      return _itemsIds.current();
    }
}
