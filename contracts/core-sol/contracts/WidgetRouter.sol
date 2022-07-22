// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IWidget } from "./interfaces/IWidget.sol";

contract WidgetRouter is Ownable {
  mapping(bytes32 => address) private _widgets;

  constructor() {}

  function fetch(bytes32 widgetId, bytes calldata input) external view returns (string memory) {
    return IWidget(_widgets[widgetId]).fetch(input);
  }

  function getWidget(bytes32 widgetId) external view returns (address widget) {
    return _widgets[widgetId];
  }

  function setWidget(bytes32 widgetId, address widget) external onlyOwner {
    _widgets[widgetId] = widget;
  }
}
