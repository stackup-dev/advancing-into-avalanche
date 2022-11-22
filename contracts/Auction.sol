// SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Auction {
    using SafeMath for uint256;
    uint256 public endTime; // Timestamp of the end of the auction (in seconds)
    uint256 public startTime; // The block timestamp which marks the start of the auction
    uint public maxBid; // The maximum bid
    address public maxBidder; // The address of the maximum bidder
    address public creator; // The address of the auction creator
    Bid[] public bids; // An array of bids made by the bidders
    uint public tokenId; // The id of the token
    bool public isCancelled; // True if the auction is cancelled
    bool public isDirectBuy; // True if the auction ended due to a direct buy
    uint public minIncrement; // The minimum increment for the bid
    uint public directBuyPrice; // The price for a direct buy
    uint public startPrice; // The starting price of the auction
    address public nftAddress; // The address of the deployed NFT contract
    IERC721 _nft; // The NFT token

    enum AuctionState {
        OPEN,
        CANCELLED,
        ENDED,
        DIRECT_BUY
    }

    struct Bid {
        // A bid on an auction
        address sender;
        uint256 bid;
    }

    // Auction constructor
    constructor(
        address _creator,
        uint _endTime,
        uint _minIncrement,
        uint _directBuyPrice,
        uint _startPrice,
        address _nftAddress,
        uint _tokenId
    ) {
        creator = _creator; // The address of the auction creator
        endTime = block.timestamp + _endTime; // The timestamp which marks the end of the auction (now + 30 days = 30 days from now)
        startTime = block.timestamp; // The timestamp which marks the start of the auction
        minIncrement = _minIncrement; // The minimum increment for the bid
        directBuyPrice = _directBuyPrice; // The price for a direct buy
        startPrice = _startPrice; // The starting price for the auction
        _nft = IERC721(_nftAddress); // The address of the deployed NFT contract
        nftAddress = _nftAddress;
        tokenId = _tokenId; // The id of the token
        maxBidder = _creator; // Setting the maxBidder to the auction creator
    }

    // Returns a list of all bids and addresses
    function allBids()
        external
        view
        returns (address[] memory, uint256[] memory)
    {
        address[] memory addrs = new address[](bids.length);
        uint256[] memory bidPrice = new uint256[](bids.length);
        for (uint256 i = 0; i < bids.length; i++) {
            addrs[i] = bids[i].sender;
            bidPrice[i] = bids[i].bid;
        }
        return (addrs, bidPrice);
    }

    // Place a bid on the auction
    function placeBid() external payable returns (bool) {
        require(bids.length < 5); // Only 5 bidders allowed for 1 auction
        require(msg.sender != creator); // The auction creator can not place a bid
        require(getAuctionState() == AuctionState.OPEN); // The auction must be open
        require(msg.value > startPrice); // The bid must be higher than the starting price
        require(msg.value > maxBid + minIncrement); // The bid must be higher than the current bid + the minimum increment

        address lastHightestBidder = maxBidder; // The address of the last highest bidder
        uint256 lastHighestBid = maxBid; // The last highest bid
        maxBid = msg.value; // The new highest bid
        maxBidder = msg.sender; // The address of the new highest bidder
        if (msg.value >= directBuyPrice) {
            // If the bid is higher than the direct buy price
            isDirectBuy = true; // The auction has ended
        }
        bids.push(Bid(msg.sender, msg.value)); // Add the new bid to the list of bids

        if (lastHighestBid != 0) {
            // if there is a bid
            address(uint160(lastHightestBidder)).transfer(lastHighestBid); // Refund the previous bid to the previous highest bidder
        }

        emit NewBid(msg.sender, msg.value); // Emit a new bid event

        return true; // The bid was placed successfully
    }

    // Withdraw the token after the auction is over
    function withdrawToken() external returns (bool) {
        // 1) The auction must be ended by either a direct buy or timeout

        // 2) The highest bidder can only withdraw the token

        // 3) Transfer the token to the highest bidder

        // 4) Emit a withdraw token event
    }

    // Withdraw the funds after the auction is over
    function withdrawFunds() external returns (bool) {
        require(
            getAuctionState() == AuctionState.ENDED ||
                getAuctionState() == AuctionState.DIRECT_BUY
        ); // The auction must be ended by either a direct buy or timeout
        require(msg.sender == creator); // The auction creator can only withdraw the funds
        address(uint160(creator)).transfer(maxBid); // Transfers funds to the creator
        emit WithdrawFunds(msg.sender, maxBid); // Emit a withdraw funds event
    }

    // Cancel the auction
    function cancelAuction() external returns (bool) {
        // 1) Only the auction creator can cancel the auction

        // 2) The auction must be open

        // 3) The auction must not be cancelled if there is a bid

        // 4) Set auction to cancelled state to true

        // 5) Transfer the NFT token to the auction creator

        // 6) Emit Auction Cancelled event

        return true;
    }

    // Get the auction state
    function getAuctionState() public view returns (AuctionState) {
        // 1) If the auction is cancelled return CANCELLED

        // 2) If the auction is ended by a direct buy return DIRECT_BUY

        // 3) The auction is over if the block timestamp is greater than the end timestamp, return ENDED
        
        // 4) Otherwise return OPEN
    }

    event NewBid(address bidder, uint bid); // A new bid was placed
    event WithdrawToken(address withdrawer); // The auction winner withdrawed the token
    event WithdrawFunds(address withdrawer, uint256 amount); // The auction owner withdrawed the funds
    event AuctionCancelled(); // The auction was cancelled
}
