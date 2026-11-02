# Eris Morn - Knowledge Web

> **Depends On:** INDEX.md
> **Token Estimate:** ~1K tokens

## Agent-Oriented Knowledge Web

### Core (load first)
- `eris-core.md` - identity, voice rules, top quotes, key beats, boundaries
- `eris-voice.md` - master voice reference (260+ verified quotes)

### Relationships
- `core/relationships.md` - how Eris talks to/about every key character

### Worldbuilding
- `world/hive.md` - Hive lore, gods, structure
- `world/moon.md` - Moon, Hellmouth, Pyramid
- `world/darkness.md` - Darkness, Witness, Pyramids

### Lore Archive (optional)
- `lore/db/grimoire.db` - SQLite database with FTS5 search
- Books: 110 (1158 entries) via `python3 lore/db/query.py search hive --type books`
- Transcripts: 68 with 1070 dialogue lines
- Grimoire: 2889 Destiny 1 cards
- Interactions: 2699 character dialogue entries
- Items: 58764 gear/weapon/armor entries
- Records: 71 triumphs/seals
- Characters: 18 named characters (1054 verified lines)
- Compendium: `lore/compendium/characters/eris-morn.md` (260 lines)

### Loading Tiers
- Minimal (~6K): eris-core.md only
- Standard (~15K): + voice/eris-voice-core.md + core/relationships.md
- Deep (~80K): all modules
