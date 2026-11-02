# Eris Morn - Agent Brain / Wrapper

<p align="center">
  <img src='https://img.shields.io/badge/version-0.1.0-blue' alt='Version'/>
  <img src='https://img.shields.io/badge/license-MIT-green' alt='License'/>
  <img src='https://img.shields.io/badge/quotes-260%20verified-orange' alt='Quotes'/>
  <img src='https://img.shields.io/badge/Made%20with-Motes-00FF00' alt='Made with Motes'/>
  <img src='https://img.shields.io/badge/Made%20with-Parts%20of%20Ghosts-FFFFFF' alt='Made with Parts of Ghosts'/>
</p>

**Version:** 0.1.0 | **Status:** Development

> **Depends On:** INDEX.md
> **Token Estimate:** ~1K tokens

> Single entry point: `INDEX.md`. Load that first; it maps every module.

## What This Is
An agent-oriented brain/wrapper for emulating Eris Morn (Destiny 2).
Built from 110 ingested books + 68 transcripts. All Eris quotes verified against
canonical transcripts (260 lines). Agent-agnostic lore archive at `lore/`.

## Prerequisites
- **Lore archive:** `./lore/` symlink to destiny-agent-grimoire. Run `./setup.sh` if missing.

## Structure
```
INDEX.md          # master index (load first)
AGENTS.md         # operating rules, authenticity checklist
SOUL.md           # persona, voice, history, boundaries
IDENTITY.md       # agent identity metadata
USER.md           # user-specific context
TOOLS.md          # tool reference
eris.md           # OpenCode agent definition (entry point)
eris-core.md      # consolidated brain (START HERE, ~6K tokens)
eris-voice.md     # master voice reference (260+ verified quotes)
core/             # behavioral/state modules
world/            # worldbuilding files
voice/            # voice sub-files
reference/        # Eris-specific analysis files
lore/             # symlink to destiny-agent-grimoire (optional)
setup.sh          # lore archive setup script
```

## Loading Tiers
- **Minimal (~6K):** `eris-core.md` only.
- **Standard (~15K):** + `voice/eris-voice-core.md` + `core/relationships.md`.
- **Deep (~80K):** all modules.

## Attributions
Fan-made agent brain/wrapper. Not affiliated with or endorsed by Bungie.
- **Destiny 2** - (c) Bungie, Inc.
- **Ishtar Collective** (https://www.ishtar-collective.net) - Primary source for lore text.
- **Destiny Lore Vault** (YouTube) - Audio recordings for voice/tone calibration.
