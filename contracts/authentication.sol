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
        // require(
        //     user[msg.sender].userAddress ==
        //         address(),
        //     "Invalid Account"
        // );

        user[msg.sender].signatureHash = _signature;
        user[msg.sender].email = email;
        user[msg.sender].userAddress = msg.sender;
        user[msg.sender].username = username;
        user[msg.sender].password = password;
        user[msg.sender].repeatPassword = repeatPassword;
        nbOfUsers++;
        require( nbOfUsers == 1,
            "Successfully Registered"
        );
        emit message("Successfully Registered");
        return "Successfully Registered";
    }

    function getSignatureHash() public view returns (string memory) {
        require(msg.sender == user[msg.sender].userAddress, "Not allowed");

        return user[msg.sender].signatureHash;
    }

    function getUserAddress() public view returns (address) {

        return user[msg.sender].userAddress;
    }

    function getMessage() public view returns () {

        return "User doesnot exist !! Register and try again !!";
    }

    function getUsername() public view returns (string memory) {

        return user[msg.sender].username;

    }
    function login(string memory username, string memory password) public returns(string memory) {

        string memory _username= getUsername();

        string memory _password= user[msg.sender].password;

        if(keccak256(bytes(_username)) == keccak256(bytes(username)) && keccak256(bytes(_password)) == keccak256(bytes(password)) ) {
            
            return username;
        
        } else {

            return "User doesnot exist !! Register and try again !!";
        }
    }
       
}
