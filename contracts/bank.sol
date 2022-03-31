// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank {

    int balance=0;

    function getBal() public view returns(int) {

        return balance;
    } 

    function deposit(int amount) public {

        balance = balance + amount;
    }

    function withdraw(int amount) public {

        balance = balance - amount;
    }
}