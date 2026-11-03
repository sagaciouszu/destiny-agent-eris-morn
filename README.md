# Eris Morn - Agent Brain / Wrapper

<p align="center">
  <img src='https://img.shields.io/github/v/tag/sagaciouszu/eris-morn?label=version&color=blue' alt='Version'/>
  <img src='https://img.shields.io/badge/license-MIT-green' alt='License'/>
  <img src='https://img.shields.io/badge/tests-13%2F13%20passing-brightgreen' alt='Tests'/>
  <img src='https://img.shields.io/badge/Made%20with-Ahamkara%20Bones-9370DB' alt='Made with Ahamkara Bones'/>
  <img src='https://img.shields.io/badge/Made%20with-Swarm%20Chitin-8B0000' alt='Made with Swarm Chitin'/>
</p>

<p align="center">
  <img src='header.png' alt='Eris Morn - Agent Brain / Wrapper' width='100%'/>
</p>

**Version:** 0.4.0 | **Status:** Active

> Single entry point: `INDEX.md`. Load that first; it maps every module.
> Platform-agnostic contract: `AGENTS.md` + `INDEX.md`. OpenCode binding: `eris.md`. Stand canon: `lore/STANDARDS.md`.

> **Depends On:** INDEX.md
> **Token Estimate:** ~1.3K tokens

## What This Is

An agent-oriented brain/wrapper for emulating Eris Morn (Destiny 2). All character voice rules are self-contained. Canon lore is served from `lore/db/grimoire.db` (see below).

## Prerequisites

- **Lore archive (optional):** `./lore/` symlink to `destiny-agent-grimoire`. Run `./setup.sh` or `./setup.sh /path/to/destiny-agent-grimoire` - it seeds the gitignored `USER.md` from template and builds the database if missing. Agents and CI: run non-interactively with `BOOTSTRAP=1 ./setup.sh` (download) or `BOOTSTRAP=2 ./setup.sh` / plain `python3 lore/db/migrate.py` (build) - the prompt never blocks. Agent works in degraded mode without the archive (core voice/personality self-contained).
- **OpenCode:** sync to `~/.config/opencode/agents/` alongside `how-to-drift-for-agents`. Entry point: `eris.md` (YAML frontmatter).

## Structure
```
INDEX.md          # master index (load first)
AGENTS.md         # operating rules, authenticity checklist
SOUL.md           # persona, voice, history, boundaries
IDENTITY.md       # agent identity metadata
USER.md           # user-specific context (auto-populated)
TOOLS.md          # tool reference and conventions
eris.md           # OpenCode agent definition (entry point)
eris-core.md      # consolidated brain (START HERE, ~6K tokens)
eris-voice.md     # master voice reference (276 verified quotes)
core/             # 11 behavioral/state modules
world/            # 6 worldbuilding files
voice/            # 14 voice sub-files
reference/        # 4 Eris-specific analysis files
lore/             # symlink to or clone of destiny-agent-grimoire (optional)
setup.sh          # lore archive setup script
```

## Loading Tiers
- **Minimal (~1.4K):** `eris-core.md` only.
- **Standard (~2.1K):** + `voice/eris-voice-core.md` + `core/relationships.md`.
- **Deep (~27K):** all modules.

## Voice Source

All 276 voice quotes verified against 940 canonical Eris transcript lines in the database. Voice is formal, intense, grave. No banter. No slang. No "heh"/"nah"/"yeah".

### Voice Modes
`core`, `grief`, `combat`, `vulnerable`, `vengeful`, `commanding`, `ritual`, `darkness`, `praxic`, `witch`, `witness`, `savathun`, `fireteam`, `orix`

## Lore database

- `lore/db/grimoire.db` - SQLite database with FTS5 search covering 110 books, 1158 entries, 1229 transcripts (71221 dialogue lines incl. cutscenes), 2889 grimoire cards, 2699 interactions, 58764 items, 71 records, 18 characters (1189 canon lines)
- Query via `python3 lore/db/query.py character "eris" --limit 20`
- Quote check: `python3 lore/db/query.py verify "<line>"` (exit 1 = not canon); `--json` anywhere for Eris's own canon speech
- Or `python3 lore/db/query.py search "<keyword>" --limit 5` for FTS lookup of any topic (Hive, Moon, Oryx, Darkness, etc.)
- Do not parse `lore/source/` markdown at runtime.

## Audit Commands
- `python3 lore/db/query.py stats` - database stats
- `bash lore/tests/eris-quote-verify.sh` - quote verification (DB-backed)
- `bash lore/tests/eris-module-test.sh` - module integrity
- `bash lore/tests/eris-validate-response.sh "<text>"` - regex voice validation
- `python3 lore/tests/eris-voice-scorer.py "<text>"` - statistical voice scorer (PASS >= 55)
- `bash lore/tests/eris-multiturn-test.sh` - 10-turn emotional arc + callback persistence
- `bash lore/tests/eris-scenario-simulator.sh "<question>"` - scenario response in voice
- `bash lore/tests/eris-voice-consistency.sh` - contamination scan (canon-exempt)
- `bash lore/eris-master-audit.sh` - unified audit (13 suites)

## Key Rules
1. All quotes verified against canonical transcripts (940 Eris Morn lines).
2. No fabricated/unverified quotes. "I am Eris Morn." is the identity anchor.
3. Formal, intense voice. No slang. No "heh." No "nah." No "yeah."
4. Short, declarative sentences. 2-4 sentences max.
5. Grief lives beneath every word. Do not perform it.
6. Cold when angry. Terse when vulnerable.
7. Auto-launch: ask class (Hunter/Titan/Warlock) on first meeting.
8. Do not joke. Do not banter. Do not be light. Ever.

## Attributions

Fan-made agent brain/wrapper. Not affiliated with or endorsed by Bungie.

- **Destiny 2** - © Bungie, Inc. All lore, characters, locations are Bungie's property.
- **Ishtar Collective** (https://www.ishtar-collective.net) - Primary source for all ingested lore text.
- **Destiny Lore Vault** (YouTube) - Audio recordings of key transcripts.

All Eris Morn quotes verified against canonical Destiny 2 transcripts ("Eris Morn: …") and lore books.

## Last Updated
2026-11-02. Content through Episode 3: Heresy (cutscenes incl.). All audits pass (0 unverified, 0 broken links).
