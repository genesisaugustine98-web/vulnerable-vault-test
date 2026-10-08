# Vulnerable Vault — Test Fixture

**Author: Genesis Koodanga Augustine**

A small, deliberately vulnerable Solidity smart contract used to test the
[Web3Guard Exploit Hunter](https://github.com/genesisaugustine98-web/web3guard-bounty-hunter).
It exists so a scanner has a *known-bad* target to practice on: if your tool
can't find the bug in this file, it won't find it in the wild.

## The vulnerability

`withdraw()` sends Ether to the caller **before** zeroing their recorded balance
(a classic *reentrancy* flaw). An attacker's contract can call `withdraw()` again
from inside its receive function and drain the vault. The fix — update state
*before* the external call — is intentionally left out. This file must never be
deployed with real money.

## Verify it compiles

Requires `solc` 0.8.24 or later (or Foundry):

```bash
solc --bin VulnerableVault.sol
# or
pip install py-solc-x && python -c "import solcx; solcx.install_solc('0.8.24')"
```

Compiles cleanly under 0.8.24 (verified 2026-10-09).

## Use it

Point Web3Guard (or any static analyzer) at `VulnerableVault.sol` and confirm it
flags the reentrancy in `withdraw()`. A clean scan here means the scanner is
broken, not the contract.

## License

MIT — do whatever you want with it, just don't deploy it with real funds.
