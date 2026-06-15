// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title VulnerableVault
 * @notice A deliberately vulnerable smart contract to test the Web3Guard Exploit Hunter.
 * @dev Contains a classic Reentrancy vulnerability.
 */
contract VulnerableVault {
    mapping(address => uint256) public userBalances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Allow users to deposit Ether
    function deposit() external payable {
        require(msg.value > 0, "Must deposit non-zero amount");
        userBalances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // VULNERABILITY: Reentrancy
    // The state (userBalances) is updated AFTER the external call (msg.sender.call).
    // This allows an attacker to re-enter the withdraw function before the balance is zeroed out.
    function withdraw() external {
        uint256 balance = userBalances[msg.sender];
        require(balance > 0, "Insufficient balance");

        // External call happens here
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");

        // State update happens too late!
        userBalances[msg.sender] = 0;
        
        emit Withdrawn(msg.sender, balance);
    }

    // Helper function to check the vault's total Ether balance
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
