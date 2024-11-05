// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BIT2024blockchain {
    string public name = "BIT2024blockchain";
    address public owner;

    struct User {
        address userAddress;
        uint256 count;
    }

    mapping(address => User) public users;
    address[] public userAddresses;

    event UserAdded(address indexed userAddress, uint256 count);
    event CountIncremented(address indexed userAddress, uint256 newCount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    function addUser(address _userAddress) public onlyOwner {
        require(users[_userAddress].userAddress == address(0), "User already exists.");
        users[_userAddress] = User({userAddress: _userAddress, count: 0});
        userAddresses.push(_userAddress);
        emit UserAdded(_userAddress, 0);
    }

    function incrementCount(address _userAddress) public {
        require(users[_userAddress].userAddress != address(0), "User does not exist.");
        users[_userAddress].count += 1;
        emit CountIncremented(_userAddress, users[_userAddress].count);
    }

    function getUserCount(address _userAddress) public view returns (uint256) {
        require(users[_userAddress].userAddress != address(0), "User does not exist.");
        return users[_userAddress].count;
    }

    function getAllUsers() public view returns (address[] memory) {
        return userAddresses;
    }
}
