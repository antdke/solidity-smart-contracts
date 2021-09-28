// SPDX-License-Identifier: MIT

// What it does: It accepts payments

/* What I learned:
* 1. How to use Chainlink to bring off-chain data into a contract
* 2. How to work with interfaces
* 3. 
*/

pragma solidity >=0.6.6 <0.9.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

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
    
    function description() public view returns (string memory) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.description();
    }
    
}
