# Release v0.4.0 - Eris Morn Agent: Platform-Agnostic Contract + Interface v2

> **Depends On:** INDEX.md
> **Token Estimate:** ~0.4K tokens

**Date:** 2026-11-02

## Highlights

- **AGENTS.md rewritten** - platform-neutral operating contract: hard rules, canon/quoting policy, data access, load protocol, platform bindings, connection matrix
- **INDEX.md rewritten** - entry points for OpenCode and generic runtimes, connection matrix, module inventory, measured load tiers, topic map
- **Grimoire interface v2 wired in** - `verify` quote check, `list` discovery, `--json`, snippet-first search across AGENTS/INDEX/TOOLS/agent def/core/knowledge-web
- **`USER.md` gitignored** - runtime state seeded from `USER.template.md` by `setup.sh`; never committed
- **Agent-safe bootstrap** - prebuilt download or local build, `BOOTSTRAP=1|2`, never blocks
- **Voice integrity** - cross-character attribution maintained (0 issues); 8-suite audit
- **Measured tiers** - minimal ~1.4K, standard ~2.1K, deep ~27K (was overstated 4-6x)

## Verification

- `eris-master-audit.sh`: 8/8
- quotes: 0 unverified; attribution: 0 cross-character quotes
- fresh-clone onboarding: seeded `USER.md` + built database + 8/8

Fan-made. Not affiliated with or endorsed by Bungie.
