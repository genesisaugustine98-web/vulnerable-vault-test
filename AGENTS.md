# vulnerable-vault-test — agent contract

## Maintainer

- **Developer:** Genesis Koodanga Augustine
- **Email:** agkoodanga@bugcrowdninja.com
- **WhatsApp:** +2349124352286

This repository is developed and maintained by Genesis Koodanga Augustine.
Do not misattribute authorship or add third-party maintainers without confirmation.

Read `docs/agent/START_HERE.md` first, then `docs/agent/STATUS.md`.

## What this repository is

A small, deliberately vulnerable Solidity contract used as a known-bad target for Web3Guard. It contains an intentional reentrancy flaw and must never hold real funds.

## Before work

1. Run `agent-pickup --brief` (environment tool; if absent, read this file).
2. Read `docs/agent/START_HERE.md` and `docs/agent/STATUS.md`; verify STATUS against the tree.
3. Check `git status --short` and the last verification recorded in `STATUS.md`.

## Entry points

- `VulnerableVault.sol` — the fixture
- `README.md` — vulnerability and usage

## Verify

- `solc --bin VulnerableVault.sol` — compiles under solc 0.8.24+

## During work

- Keep changes scoped; do not touch unrelated dirty files.
- Record only checks you actually ran, with their real results.
- Never write secrets, credentials, customer data, or raw vendor responses to memory.
- Keep the vulnerability; a clean scan means the scanner is broken, not the contract.
- Never deploy with real money.

## Before finishing

- Overwrite `docs/agent/STATUS.md` with the new state and next safe action.
- Prepend one entry to `docs/agent/LOG.md`.
- Add to `DECISIONS.md` or `GOTCHAS.md` only when warranted.
- Report exactly what you ran and what you did not run.

## Layout

- `docs/agent/START_HERE.md` — orientation and entry points
- `docs/agent/STATUS.md` — current state (overwrite)
- `docs/agent/LOG.md` — session log (append-only, newest first)
- `docs/agent/DECISIONS.md` — durable decisions
- `docs/agent/GOTCHAS.md` — real traps and fixes
