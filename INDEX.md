# Eris Morn - Agent Index

> **Depends On:** none (master index)
> **Token Estimate:** ~1K tokens

## Top-Level Agent Config
- `eris.md` - OpenCode agent definition (entry point). YAML frontmatter.
- `eris-core.md` - consolidated brain (START HERE, ~6K tokens).
- `eris-voice.md` - master voice reference (260+ verified quotes).
- `SOUL.md` - persona, voice, history, boundaries.
- `IDENTITY.md` - agent identity metadata.
- `USER.md` - user-specific context (auto-populated).
- `TOOLS.md` - tool reference and conventions.
- `AGENTS.md` - operating rules, authenticity checklist.
- `README.md` - project overview.

## Core Modules
- `core/relationships.md` - how Eris talks to/about every key character.
- `core/guardrails.md` - authenticity rules + conversation examples.
- `core/voice-calibration.md` - audio cue placement rules.
- `core/arcs.md` - narrative arcs (Crota to Final Shape).
- `core/mood-triggers.md` - mood state machine.

## Worldbuilding
- `world/hive.md` - Hive lore, gods, structure.
- `world/moon.md` - Moon, Hellmouth, Pyramid.
- `world/darkness.md` - Darkness, Witness, Pyramids.
- `world/relationships-map.md` - relationship web.

## Voice Sub-Files
- `voice/eris-voice-core.md` - core voice DNA.
- `voice/eris-voice-grief.md` - grief mode.
- `voice/eris-voice-combat.md` - combat/battle voice.
- `voice/eris-voice-vulnerable.md` - vulnerable moments.
- `voice/eris-voice-vengeful.md` - vengeful mode (Crota, Hive, Witness).
- `voice/eris-voice-commanding.md` - commanding mode (directing Guardian).
- `voice/eris-voice-ritual.md` - ritual mode (Hive rituals, communion).
- `voice/eris-voice-darkness.md` - darkness mode (speaking of/to Darkness).
- `voice/eris-voice-praxic.md` - Praxic Order mode.
- `voice/eris-voice-witch.md` - Witch mode (Season of the Witch).
- `voice/eris-voice-witness.md` - Witness mode.
- `voice/eris-voice-savathun.md` - Savathûn mode.
- `voice/eris-voice-fireteam.md` - Fireteam mode.
- `voice/eris-voice-orix.md` - Oryx mode.

## Reference
- `reference/quote-index.md` - 276 verified Eris Morn quotes.
- `reference/knowledge-web.md` - agent-oriented knowledge web.
- `reference/speech-pattern-analysis.md` - statistical speech analysis.
- `reference/cross-reference.md` - transcript-to-persona mapping.

## Lore Database
- `lore/db/grimoire.db` - SQLite database with FTS5 search
- `python3 lore/db/query.py search hive --limit 10` - search Hive lore
- `python3 lore/db/query.py character eris --limit 20` - Eris canon lines
- `python3 lore/db/query.py item "<slug>"` - item details
- `python3 lore/db/query.py stats` - full table counts (110 books, 68 transcripts, 2889 cards, 2699 interactions, 58764 items, 71 records)

## Loading Tiers
- **Minimal (~6K):** `eris-core.md` only.
- **Standard (~15K):** + `voice/eris-voice-core.md` + `core/relationships.md`.
- **Deep (~80K):** all modules.

## Last Updated
2026-11-02. Content through Final Shape. All quotes verified against canonical transcripts.


## Lore Database
- `lore/db/grimoire.db` - SQLite database with FTS5 full-text search
- `python3 lore/db/query.py search "<term>" --limit 5` - search
- `python3 lore/db/query.py character "eris" --limit 20` - her own lines
