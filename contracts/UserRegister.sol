// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract UserRegister {

    string userName;
    string email;
    string password;
    string confirmPassword;

    function SetUser(string memory _userName, string memory _email, string memory _password, string memory _confirmPassword) public {
     
         userName=_userName;
         email=_email;
         password=_password;
         confirmPassword=_confirmPassword;

    }

    function GetUser() public view returns(string memory,string memory,string memory,string memory){
        return(userName,email,password,confirmPassword);
    }
}