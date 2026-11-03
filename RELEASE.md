# v0.6.0 - Verified onboarding and faster quote checks

> **Depends On:** INDEX.md
> **Token Estimate:** ~0.2K tokens

**2026-11-03**

## What's Changed

- **Verified onboarding:** the prebuilt database is checked against release `SHA256SUMS`; a mismatch discards it and builds locally
- **Privacy:** seeded `USER.md` is owner-only (`0600`)
- **MCP:** documentation consolidated into `lore/mcp-server/README.md`; install with `./setup.sh --mcp`
- **Verification:** quote checks accept `--speaker` and `--exact`; database checks are 37

## Verification

13/13 audit, 6/6 MCP contract, 0 unverified quotes, fresh-clone onboarding PASS.
