// SPDX-License-Identifier: MIT

// What it does: It accepts payments

/* What I learned:
* 1. How to use Chainlink to bring off-chain data into a contract
* 2. How to work with interfaces
* 3. 
*/

pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    
    // to keep track of who funded us (storing addresses and total amount they've sent)
    mapping (address => uint256) public addressToAmountFunded;
    
    // a function that accepts payments
    function fund() public payable {
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    // get version of the chainlink price feed aggregator
    // makes a contract call to my contract using the AggregatorV3Interface
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    
    // get description of the priceFeed contract -- returns "ETH/USD"
    function getDescription() public view returns (string memory) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.description();
    }
    
    // get current price of ETH/USD according to crypto oracles
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        // latestRoundData returns 5 values, so we deconstruct it into 5 variables
        (, int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer);
    }
    
}
