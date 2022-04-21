// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

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

      struct Project {
        string projectName;
        string description;
        string deadline;
        string amount;
        address userAddress;
    }

    mapping(address => Project) private project;

    Project[] public projects;
    // mapping(address => Project[]) private allProjects;


    constructor() {
        nbOfUsers = 0;
    }

    function register(string memory _signature, string memory email, string memory username, string memory password, string memory repeatPassword) public returns(string memory) {
        require(
            user[msg.sender].userAddress ==
                getUserAddress(),
            "Account already used please try with new account!!"
        );

        user[msg.sender].signatureHash = _signature;
        user[msg.sender].email = email;
        user[msg.sender].userAddress = msg.sender;
        user[msg.sender].username = username;
        user[msg.sender].password = password;
        user[msg.sender].repeatPassword = repeatPassword;
        nbOfUsers++;
        // require( nbOfUsers == 1,
        //     "Successfully Registered"
        // );
        // emit message("Successfully Registered");
        return "Successfully Registered";
    }

    function getSignatureHash() public view returns (string memory) {
        require(msg.sender == user[msg.sender].userAddress, "Not allowed");

        return user[msg.sender].signatureHash;
    }

    function getUserAddress() public view returns (address) {

        return user[msg.sender].userAddress;
    }

    // function getMessage() public view returns () {

    //     return "User doesnot exist !! Register and try again !!";
    // }

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
       // save project 
    function saveProject(string memory projectName, string memory description, string memory deadline, string memory amount) public returns(string memory) {
     
     if(bytes(getUsername()).length!=0) {
        project[msg.sender].projectName = projectName;
        project[msg.sender].description = description;
        project[msg.sender].deadline = deadline;
        project[msg.sender].amount = amount;
        project[msg.sender].userAddress= msg.sender;
        projects.push( project[msg.sender]);

        return "Project Saved Successfully";
     } else {
         return "Error Saving Project";
     }

    }

    function getProjectDetails(string memory userName) public view returns(Project[] memory) {

        string memory _username= getUsername();
       if (keccak256(bytes(_username)) == keccak256(bytes(userName))) {
                    return projects;

       }
       
    }

    // fund transfer
    contract SafeMath {
    /**
    * @dev Multiplies two numbers, reverts on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
    * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        // Solidity only automatically asserts when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
    * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
    * @dev Adds two numbers, reverts on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
    * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

contract TestContract is SafeMath {
    uint public transactionCount = 0;
    uint public transactionAmount = 0;

    function payBill(address payable account) payable public {
        transactionCount = add(transactionCount, 1);
        transactionAmount = add(transactionAmount, msg.value);

        address(account).transfer(msg.value);
    }
}
       
}
