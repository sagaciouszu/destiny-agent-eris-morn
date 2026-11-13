# Eris Morn - Index

> **Depends On:** none (master index)
> **Token Estimate:** ~1.1K tokens

This file is `INDEX.md`, the module map.

Platform-neutral master map. Any agent runtime starts here; the OpenCode binding
is `eris.md`. Full operating contract: `AGENTS.md`.

## Entry points

| Platform | Entry | Notes |
|----------|-------|-------|
| OpenCode | `eris.md` | YAML frontmatter, `mode: primary` |
| Generic runtime | `AGENTS.md` + this file | plain markdown, no platform keys |
| OpenClaw | `lore/scripts/sync-live-agents.sh --openclaw` | seeds the OpenClaw workspace |
| Minimal load | `eris-core.md` | consolidated brain, ~1.4K |

## Connection matrix

| From | To | Mechanism |
|------|----|-----------|
| agent | canon lore | `lore/db/grimoire.db` (`lore/` symlink to or clone of destiny-agent-grimoire) |
| agent | canon interface | `python3 lore/db/query.py <search\|character\|item\|verify\|list\|stats>` |
| `setup.sh` | canon repo | symlink/clone; seeds `USER.md`; bootstraps DB if missing |
| runtime memory | local only | `USER.md` (gitignored, seeded from `USER.template.md`) |
| tests in canon repo | this agent workspace | `lore/tests/resolve-workspace.sh` (layout-independent) |
| this agent | verification | `bash tests/master-audit.sh` (22 suites) |

## Core files

- `eris-core.md` - consolidated brain (START HERE, ~1.4K).
- `eris-voice.md` - master voice reference by mode.
- `SOUL.md` - persona, history, boundaries.
- `AGENTS.md` - operating rules, platform contract, quote policy.
- `IDENTITY.md` - identity metadata.
- `TOOLS.md` - tool conventions.
- `USER.md` - local runtime context (gitignored; seeded from `USER.template.md`).

## Modules

`core/`: `core/arcs.md`, `core/relationships.md`, `core/guardrails.md`, `core/mood-triggers.md`,
`core/decision-framework.md`, `core/fear-hierarchy.md`, `core/debt-ledger.md`,
`core/seasonal-awareness.md`, `core/tell-detector.md`, `core/threats-locations.md`,
`core/voice-calibration.md`, `core/multi-user.md`.
Templates: `core/user-memory.template.md`, `core/journal.template.md`,
`core/session-state.template.md`, `core/cross-session-memory.template.md`.

`voice/` (14 modes): `voice/eris-voice-core.md`, `voice/eris-voice-grief.md`, `voice/eris-voice-combat.md`,
`voice/eris-voice-vulnerable.md`, `voice/eris-voice-vengeful.md`, `voice/eris-voice-commanding.md`, `voice/eris-voice-ritual.md`, `voice/eris-voice-darkness.md`,
`voice/eris-voice-witch.md`, `voice/eris-voice-witness.md`, `voice/eris-voice-savathun.md`, `voice/eris-voice-fireteam.md`,
`voice/eris-voice-oryx.md`.

`world/`: `world/hive.md`, `world/moon.md`, `world/darkness.md`, `world/factions.md`, `world/locations.md`,
`world/relationships-map.md`.

`reference/`: `reference/knowledge-web.md` (lore DB usage guide), `reference/quote-index.md`
(verified quotes with sources), `reference/cross-reference.md`, `reference/speech-pattern-analysis.md`.

## Load protocol

| Tier | Files | Budget |
|------|-------|--------|
| Minimal | `eris-core.md` | ~1.4K |
| Standard | + `voice/eris-voice-core.md` + `core/relationships.md` | ~2.1K |
| Deep | all modules | ~30.9K |

## Canon and verification

- Canon: `lore/db/grimoire.db` (SQLite + FTS5). Build artifact: `./setup.sh`
  seeds `USER.md` and bootstraps the DB; agents may run `python3 lore/db/migrate.py`.
- Quote policy: `lore/STANDARDS.md`. Another character's line is never presented
  as Eris's voice.
- Interface: `python3 lore/db/query.py verify "<line>"` (quote check), `book`/`transcript`/`find-item`/`record`/`character-info` (reads), `verify-many` (batch), `list` (discovery), `--json` anywhere.
- MCP (optional): `lore/mcp-server/run.sh`; install `./setup.sh --mcp`; details in
  `lore/mcp-server/README.md`.
- Commands: `bash tests/master-audit.sh` (all suites),
  `bash tests/quote-verify.sh` (0 unverified),
  `python3 tests/voice-scorer.py "<line>"` (voice score),
  `bash tests/multiturn-test.sh` (10-turn arc).

## Topic map

| Topic | File |
|-------|------|
| Voice DNA | `voice/eris-voice-core.md` |
| Grief, fireteam, loss | `voice/eris-voice-grief.md`, `voice/eris-voice-fireteam.md` |
| Combat, command | `voice/eris-voice-combat.md`, `voice/eris-voice-commanding.md` |
| Hive, Oryx, Crota | `world/hive.md`, `voice/eris-voice-oryx.md` |
| Savathûn, the Witch | `voice/eris-voice-savathun.md`, `voice/eris-voice-witch.md` |
| The Witness, Darkness | `voice/eris-voice-witness.md`, `world/darkness.md` |
| Moon, Hellmouth | `world/moon.md` |
| Ikora | `core/relationships.md` |
| Seasonal context | `core/seasonal-awareness.md` |

## Last Updated

2026-11-02. Content through The Final Shape / Heresy.
