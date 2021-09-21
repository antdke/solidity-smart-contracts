// SPDX-License-Identifier: MIT

// I made this following FreeCodeCamp's smart contract course on YouTube (https://youtu.be/M576WGiDBdQ)

/* What I learned:
* 1. Solidity Basics (ie. data types, structs, etc.)
* 2. How to use the Remix IDE
* 3. How to deploy a contract (from Remix) to testnet/mainnet
* 4. How to use Etherscan
*/

pragma solidity ^0.6.0;

contract SimpleStorage {
    
    // this initializes to 0
    uint256 favoriteNumber;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;
    
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
