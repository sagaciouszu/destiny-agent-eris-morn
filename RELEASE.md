# Release v0.2.0 - Eris Morn Agent with SQLite Lore

> **Depends On:** INDEX.md
> **Token Estimate:** ~1K tokens

**Date:** 2026-11-02

## What this is

Agent brain/wrapper for Eris Morn (Destiny 2). Voice is formal, intense, grave; no slang, no banter, no "heh"/"nah"/"yeah". All quotes verified against canonical transcripts. Zero unverified quotes.

Canon lore is served from the shared SQLite database (`lore/db/grimoire.db` in the destiny-agent-grimoire repository), not from markdown files.

## Structure

- `eris-core.md` - consolidated brain (~6K, START HERE)
- `core/` - 11 modules (relationships, guardrails, arcs, mood-triggers, voice-calibration, fear-hierarchy, decision-framework, threats-locations, tell-detector, seasonal-awareness, debt-ledger)
- `world/` - 6 worldbuilding files (hive, moon, darkness, factions, locations, relationships-map)
- `voice/` - 14 voice sub-files (core, grief, combat, vulnerable, vengeful, commanding, ritual, darkness, praxic, witch, witness, savathun, fireteam, oryx)
- `reference/` - 4 analysis files (quote-index, knowledge-web, speech-pattern-analysis, cross-reference)
- `tests/` - quote verification, module test, response validator
- `lore/` - symlink to destiny-agent-grimoire (SQLite DB)

## Voice modes

`core`, `grief`, `combat`, `vulnerable`, `vengeful`, `commanding`, `ritual`, `darkness`, `praxic`, `witch`, `witness`, `savathun`, `fireteam`, `orix`

Grief is always under the surface; it is never performed. When angry, the voice goes cold, not loud.

## Lore integration

All lore queries route through `lore/db/grimoire.db` (1709 dialogue lines, 110 books, 1158 entries, 2889 grimoire cards, 2699 interactions, 58764 items, 71 records):

- `python3 lore/db/query.py character "eris" --limit 20` - Eris canon lines
- `python3 lore/db/query.py search "hive" --limit 5` - FTS5 search
- `python3 lore/db/query.py item "<slug>"` - item flavor text
- `sqlite3 lore/db/grimoire.db "SELECT ..."` - direct SQL

Do not read `lore/source/*.md` at runtime. The database is the interface.

## Test results

- eris-master-audit.sh: 3/3 PASS
- eris-module-test.sh: 16/16 PASS
- eris-quote-verify.sh: 0 unverified (276 checked)
- eris-validate-response.sh: 4/4 PASS
- eris-conversation-test.sh (grimoire repo): PASS (all queries hit SQLite)

## Installation

```bash
cd ~/Work/eris-morn
./setup.sh /path/to/destiny-agent-grimoire
```

## Attribution

Fan-made agent brain/wrapper. Not affiliated with or endorsed by Bungie.

- **Destiny 2** - © Bungie, Inc. All lore, characters, locations are Bungie's property.
- **Ishtar Collective** (https://www.ishtar-collective.net) - Primary source for all ingested lore text.
- **Destiny Lore Vault** (YouTube) - Audio recordings of key transcripts.
