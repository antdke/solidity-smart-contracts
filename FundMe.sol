// SPDX-License-Identifier: MIT

// What it does: It accepts payments

/* What I learned:
* 1. How to use Chainlink to bring off-chain data into a contract
* 2. How to work with interfaces
* 3. 
*/

pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    // used to prevent overflow issue when doing math in solidity. however, version .8 and onwards makes this useless
    using SafeMathChainlink for uint256;
    
    // to keep track of who funded us (storing addresses and total amount they've sent)
    mapping (address => uint256) public addressToAmountFunded;
    
    // a function that accepts payments
    function fund() public payable {
        // make $50 the min amount that someone can send this contract
        uint256 minimumUSD = 0 * 10 ** 18;
        // if person doesn't send the min required $ then tx is cancelled and they get their money back
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        // if tx meets the min required amount then record who send it
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
        return uint256(answer * 10000000000); // converts to wei amount
    }
    
    // convert wei we've been given into USD
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountToUSD = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountToUSD;
    }
    
    // withdraws all of this contract's funds to whoever requests it
    function withdraw() public payable {
        msg.sender.transfer(address(this).balance);
    }
    
    // see the amount of eth in the contract
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
    
}
