# Start here — vulnerable-vault-test

1. Run `agent-pickup --brief`.
2. Read `STATUS.md` for current state and the next safe action.
3. Read the entry points below before editing.
4. If memory and code disagree, verify in the tree and fix `STATUS.md`.

## What this is

A small, deliberately vulnerable Solidity contract used as a known-bad target for Web3Guard. It contains an intentional reentrancy flaw and must never hold real funds.

## Entry points

- `VulnerableVault.sol` — the fixture
- `README.md` — vulnerability and usage

## Verify / run

```bash
solc --bin VulnerableVault.sol
```

## Source of truth

`docs/agent/STATUS.md` is the only current-state document. Verify it against the tree.

Keep this file short. It is a router, not a transcript.
