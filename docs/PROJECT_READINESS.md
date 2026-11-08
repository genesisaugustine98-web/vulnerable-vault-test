# Vulnerable Vault test fixture readiness

Review date: 8 November 2026.

## Purpose

A deliberately vulnerable, self-contained Solidity target for scanner regression tests. It must never hold real assets.

## Included evidence

- The original contract has an external call before clearing the caller's balance.
- The new Foundry test includes a re-entrant attacker contract.
- The test asserts that the vulnerable vault loses both the attacker's and victim's deposits.
- A separate checks-effects-interactions reference contract is tested against the same attacker pattern and must preserve the victim's deposit.
- CI runs formatting and Foundry tests.

## Boundaries

- The test is local EVM execution only.
- This is not an independent security audit or a complete test suite for reentrancy variants.
- The reference contract is an educational example, not an audited production vault.
- No mainnet, public chain, third-party contract or wallet is involved.
- The Solidity compiler version is pinned to 0.8.24 in Foundry configuration.

## Good next additions

- Add a second exploit case for cross-function reentrancy if the scanner claims to detect it.
- Add a test with a reverting recipient and verify expected balance/state semantics.
- Preserve compiler version, command, commit SHA and test output in each benchmark report.
- Add the fixture to a disclosed benchmark set without leaking hidden holdout cases.
