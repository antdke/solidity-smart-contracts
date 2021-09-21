// SPDX-License-Identifier: MIT

// I made this following FreeCodeCamp's smart contract course on YouTube (https://youtu.be/M576WGiDBdQ)

/* What I learned:
* 1. How to deploy a contract from within a contract to testnet/mainnet
* 2. How inheritance works with smart contracts
* 3. How to interact with contract outside of my contract
*/

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage {
    
    SimpleStorage[] public simpleStorageArray;
    
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address 
        // ABI
        
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }
    
    function sfRetrieve(uint256 _simpleStorageIndex) public view returns(uint256){
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
    
}
