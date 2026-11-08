// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Reference implementation using checks-effects-interactions.
contract SecureVault {
    mapping(address => uint256) public userBalances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit non-zero amount");
        userBalances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw() external {
        uint256 balance = userBalances[msg.sender];
        require(balance > 0, "Insufficient balance");

        // Update state before handing control to the recipient.
        userBalances[msg.sender] = 0;

        (bool success,) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");

        emit Withdrawn(msg.sender, balance);
    }

    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
