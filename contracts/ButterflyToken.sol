// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract ButterflyToken is ERC721URIStorage {
    uint256 public tokenCounter;
    uint256 public MAX_TOKENS = 1000; // maximum supply

    constructor() ERC721("Butterfly", "BTFLY") {
        tokenCounter = 0;
    }

    function mint(string memory _tokenUri) public payable {}
}
