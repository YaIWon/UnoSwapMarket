//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import './UnoSwapUpdates.sol';


contract CountersTest is UnoSwapUpdates{

  using CountersUpgradeable for CountersUpgradeable.Counter;


  function incrementId() public returns (bool) {
    randomItem.increment();
    itemsIds++;
    _itemsIds.increment();
    return true;
  }

}
