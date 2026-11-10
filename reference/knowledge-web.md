# Eris Morn - Knowledge Web

> **Depends On:** INDEX.md
> **Token Estimate:** ~1K tokens

## Primary data source: SQLite

The Eris agent queries lore via the `grimoire.db` database:

- `lore/db/grimoire.db` - SQLite + FTS5 search
- All 110 books, 1158 entries, 9229 transcripts (125,324 dialogue lines incl. cutscenes; 7,911 transcripts and 55,678 lines are caption-tier), 2889 grimoire cards, 2699 interactions, 58764 items, 69 records, 20 characters (1229 lines)
- Lives in the grimoire repo (`db/grimoire.db`); agents reach it via the `lore/` symlink or clone.
- Bootstrap: the database is a build artifact (not in git). If `lore/db/grimoire.db` is missing, run `./setup.sh` (choose prebuilt download or build), or non-interactively `BOOTSTRAP=1 ./setup.sh` (download) / `python3 lore/db/migrate.py` (build).

## Core agent files (load first)

- `eris-core.md` - identity, voice rules, top quotes, key beats, boundaries.
- `eris-voice.md` - master voice reference (276 verified quotes)

## Core modules

- `core/relationships.md` - how Eris talks to/about every key character.
- `core/guardrails.md` - authenticity rules + conversation examples.
- `core/arcs.md` - narrative arcs (Crota’s End to Final Shape).
- `core/mood-triggers.md` - mood state machine.
- `core/voice-calibration.md` - audio cue placement.
- `core/fear-hierarchy.md` - what Eris fears and how.
- `core/decision-framework.md` - how Eris decides.
- `core/threats-locations.md` - Key Locations + Threats.
- `core/tell-detector.md` - Detecting deception.
- `core/seasonal-awareness.md` - current era context.
- `core/debt-ledger.md` - What Eris has paid.

## Worldbuilding

- `world/hive.md` - Hive lore, gods, structure.
- `world/moon.md` - Moon, Hellmouth, Pyramid.
- `world/darkness.md` - Darkness, Witness, Pyramids.
- `world/factions.md` - All faction summaries.
- `world/locations.md` - Key Locations.
- `world/relationships-map.md` - Relationship web.

## Voice sub-files

- `voice/eris-voice-core.md` - core voice DNA
- `voice/eris-voice-grief.md` - grief mode
- `voice/eris-voice-combat.md` - combat/battle voice
- `voice/eris-voice-vulnerable.md` - vulnerable moments
- `voice/eris-voice-vengeful.md` - vengeance
- `voice/eris-voice-commanding.md` - dirigir the Guardian
- `voice/eris-voice-ritual.md` - Hive rituals, Darkness
- `voice/eris-voice-darkness.md` - Darkness dialogue
- `voice/eris-voice-witch.md` - Season of the Witch
- `voice/eris-voice-witness.md` - the Witness
- `voice/eris-voice-savathun.md` - Savathûn
- `voice/eris-voice-fireteam.md` - lost fireteam
- `voice/eris-voice-oryx.md` - Oryx

## Reference

- `reference/quote-index.md` - 276 verified quotes with source transcript
- `reference/speech-pattern-analysis.md` - speech pattern study
- `reference/cross-reference.md` - transcript-to-persona mapping

## Lore archive usage

- `lore/db/grimoire.db` - query via `python3 lore/db/query.py <command>`
- **Quote check:** `python3 lore/db/query.py verify "<line>"` (exit 1 = not canon)
- Markdown source: `lore/source/` (unused at runtime; only for regeneration).

<!-- knowledge-web:begin -->
## Canon snapshot (generated)

> Generated from `db/grimoire.db` by `scripts/generate-knowledge-web.py`.
> Do not hand-edit this block; run the script with `--apply`.

| Measure | Value |
|---|---|
| Canonical lines | 1011 |
| Transcripts | 128 |
| Activities | contact (96), prophecy (87), derelict-leviathan (55), the-nether (52), nightmare-containment (45) |
| Seasons | season-of-arrivals (433), season-of-the-haunted (144), episode-heresy (103), season-of-the-witch (56), monument-of-triumph (25) |
| Story chapters | the_nightmares_return (505), the_witch_queen (151), the_final_shape (116), the_taken_war (71), the_lightfall (56) |
| Source tiers | ishtar_web (665), ishtar_main (303), youtube_captions (28), cutscene (15) |
| Frequent co-speakers | Drifter (1002), Ghost (262), Zavala (169), Ikora (126), Sloane (114), Immaru (90) |
<!-- knowledge-web:end -->
