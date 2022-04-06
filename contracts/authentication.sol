// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract Authentication {
    uint256 public nbOfUsers;

    struct User {
        string signatureHash;
        string email;
        string username;
        string password;
        string repeatPassword;
        address userAddress;
    }

    mapping(address => User) private user;

    constructor() {
        nbOfUsers = 0;
    }

    function register(string memory _signature, string memory email, string memory username, string memory password, string memory repeatPassword) public returns(string memory) {
        require(
            user[msg.sender].userAddress ==
                address(0x0000000000000000000000000000000000000000),
            "already registered"
        );

        user[msg.sender].signatureHash = _signature;
        user[msg.sender].email = email;
        user[msg.sender].userAddress = msg.sender;
        user[msg.sender].username = username;
        user[msg.sender].password = password;
        user[msg.sender].repeatPassword = repeatPassword;
        nbOfUsers++;

        return "Successfully Registered";
    }

    function getSignatureHash() public view returns (string memory) {
        require(msg.sender == user[msg.sender].userAddress, "Not allowed");

        return user[msg.sender].signatureHash;
    }

    function getUserAddress() public view returns (address) {
        return user[msg.sender].userAddress;
    }

    function getUsername() public view returns (string memory) {
        return user[msg.sender].username;
    }
}
