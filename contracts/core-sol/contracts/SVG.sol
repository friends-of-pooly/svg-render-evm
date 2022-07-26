// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { svg } from "./libraries/svg.sol";
import { SVGLibrary } from "./SVG/SVGLibrary.sol";
import { SVGRegistry } from "./SVGRegistry.sol";

contract SVG is Ownable {
  address internal _svgLibrary;
  address internal _svgRegistry;

  bytes32 private immutable COLOR = keccak256("COLOR");
  bytes32 private immutable UTILS = keccak256("UTILS");
  bytes32 private immutable DEFINITIONS = keccak256("DEFINITIONS");

  constructor(address _svgLibrary_, address _svgRegistry_) {
    _svgLibrary = _svgLibrary_;
    _svgRegistry = _svgRegistry_;
  }

  function render() public view returns (string memory) {
    string memory _svgBackgroundDefinition_ = SVGLibrary(_svgLibrary).execute(
      COLOR,
      abi.encodeWithSignature("getDefUrl(string)", "charocoal")
    );
    string memory _defs = SVGRegistry(_svgRegistry).fetch(
      DEFINITIONS,
      bytes(abi.encodePacked("0x"))
    );

    return
      string(
        abi.encodePacked(
          svg.start(),
          _defs,
          svg.rect(
            string.concat(
              svg.prop("fill", _svgBackgroundDefinition_),
              svg.prop("x", "0"),
              svg.prop("y", "0"),
              svg.prop("width", "100%"),
              svg.prop("height", "100%")
            ),
            SVGLibrary(_svgLibrary).execute(UTILS, abi.encodeWithSignature("NULL()"))
          ),
          svg.text(
            string.concat(
              svg.prop("x", "50%"),
              svg.prop("y", "50%"),
              svg.prop("dominant-baseline", "middle"),
              svg.prop("text-anchor", "middle"),
              svg.prop("font-size", "48px"),
              svg.prop("fill", "white")
            ),
            string.concat("SVG")
          ),
          svg.end()
        )
      );
  }
}
