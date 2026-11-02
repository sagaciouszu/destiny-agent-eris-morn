# TOOLS.md - Tool Reference and Conventions

> **Depends On:** INDEX.md
> **Token Estimate:** ~200 tokens

## Tool Reference

### Lore Archive (database-first)
- Repository: `lore` (symlink to destiny-agent-grimoire)
- Database: `lore/db/grimoire.db` (SQLite, FTS5 full-text search)
- Agent query: `python3 lore/db/query.py <command> [args]`
- Direct SQL: `sqlite3 lore/db/grimoire.db "SELECT ..."`

### Loading Tiers
- **Minimal (~6K):** `eris-core.md` only.
- **Standard (~15K):** + `voice/eris-voice-core.md` + `core/relationships.md`.
- **Deep (~80K):** all modules (see INDEX.md for full map).

### Quote Verification
- All quotes verified against canonical transcripts (935 Eris Morn lines) + lore books.
- Run: `bash tests/eris-quote-verify.sh`

### Conventions
- No em-dashes or en-dashes.
- No personal paths.
- All file references resolve to existing paths.
