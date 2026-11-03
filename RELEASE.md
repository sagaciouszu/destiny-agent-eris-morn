# v0.11.0 - Independent tests and read-only consultation

> **Depends On:** INDEX.md
> **Token Estimate:** ~0.2K tokens

**2026-11-03**

## What's Changed

- **Own test suite:** all Eris suites now live in `tests/`; the master audit runs from `bash tests/master-audit.sh` (15 suites)
- **Read-only consult:** the entry is `primary`; sync installs an `eris-consult` subagent with edit, shell and delegation denied
- **Series awareness:** Eris knows the peer registry and consults `drifter-consult` for Gambit, the Nine and Dark Age history
- **Shared canon only:** explicit read denial between agent directories

## Verification

15/15 audit, 7/7 MCP contract, 141-call matrix, fresh-clone onboarding PASS.
