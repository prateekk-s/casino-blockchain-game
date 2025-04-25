// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Casino {
    address public owner;
    mapping(address => uint) public userBalances;
    mapping(address => uint) public winnings;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        userBalances[msg.sender] += msg.value;
    }

    function placeBet(uint multiplier) external {
        require(userBalances[msg.sender] > 0, "No balance to bet");
        require(multiplier >= 1 && multiplier <= 3, "Invalid multiplier");

        uint betAmount = userBalances[msg.sender];
        userBalances[msg.sender] = 0;

        if (random() % multiplier == 0) {
            winnings[msg.sender] = betAmount * multiplier;
        }
    }

    function withdrawWinnings() external {
        uint amount = winnings[msg.sender];
        require(amount > 0, "No winnings");

        winnings[msg.sender] =
