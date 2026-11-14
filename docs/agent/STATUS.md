# STATUS — current session handoff

Last updated: 2026-11-14
Commit: ef5c898
Branch: main
Working tree: clean at scaffold time (verify with `git status --short`)
Updated by: opencode — agent memory scaffold bootstrap
Review rule: read this first, then verify it against the tree. Overwrite it before you finish.

## One-line state

The agent memory scaffold was added on top of `ef5c898`. No product code
changed in this bootstrap; any claim below is a pointer, not a fresh test result.

## What is true now

- Repository purpose: A small, deliberately vulnerable Solidity contract used as a known-bad target for Web3Guard. It contains an intentional reentrancy flaw and must never hold real funds.
- Entry points: `VulnerableVault.sol` — the fixture; `README.md` — vulnerability and usage.
- Current state authority: this file.

## In-flight work

None. The working tree was clean when the scaffold was committed.

## Verification recorded

- Scaffold is documentation only; no product tests were run during bootstrap.
- `solc --bin VulnerableVault.sol` — not run (compiles under solc 0.8.24+).

## Open risks / blockers

- This contract is intentionally vulnerable. Do not 'fix' it or deploy it with funds.

## Next safe action

1. Run the verify command(s) in `START_HERE.md` and confirm they pass on this commit.
2. Then make the scoped change and record the real result here.
