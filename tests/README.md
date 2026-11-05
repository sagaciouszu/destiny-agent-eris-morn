# Tests

> **Depends On:** INDEX.md
> **Token Estimate:** ~0.9K tokens

Run the full gate first:

```bash
bash tests/master-audit.sh
```

`tests/suites.json` records the 18 suites the audit runs, one entry per suite
with its command and tier.

| Test | Purpose |
|---|---|
| `master-audit.sh` | every Eris-specific suite plus the shared grimoire gates |
| `run-suites.sh` | runs `suites.json` entries through `lore/tests/run-suite-manifest.py` |
| `eris-module-test.sh` | required files, headers, em-dashes, personal paths (16 checks) |
| `eris-quote-verify.sh` | every quoted string is canon (0 unverified) |
| `eris-validate-response.sh` | voice validator for one response |
| `eris-voice-consistency.sh` | Drifter-speech contamination and cross-character attribution |
| `eris-voice-scorer.py` | statistical voice score for one response |
| `eris-multiturn-test.sh` | 10-turn emotional arc (10/10) |
| `eris-scenario-simulator.sh` | scenario response (sounds like Eris Morn) |
| `eris-conversation-test.sh` | SQLite conversation flow |
| `sample-conversation-test.py` | recorded sample conversation |
| `golden-voice-test.sh` | locked voice snapshots from `golden-voice.json` |
| `connection-test.sh` | grimoire database, query interface, lore/seal, MCP |
| `memory-test.py` | per-user memory isolation |
| `persona-freshness.py` | `persona.json` `canon_lines` still matches the database |
| `shared-helpers-test.sh` | shared helpers byte-identical to their `lore/tests/` copies |

## Running

```bash
bash tests/master-audit.sh   # full gate: 18 suites plus the shared grimoire gates
bash tests/run-suites.sh     # suites.json entries only (additive)
```

## Preconditions

- `lore/` symlink (or clone) pointing at the grimoire repo.
- `lore/db/grimoire.db` bootstrapped with `./setup.sh` (or
  `python3 lore/db/migrate.py`); `master-audit.sh` aborts with exit 1 without it.
- `WORKSPACE` resolving to this repo (derived by `lore/tests/resolve-workspace.sh`
  when unset).

## Exit codes

- 0 = pass, 1 = fail for every test script and for `master-audit.sh`.
- Voice scorers exit 2 when the grimoire database is missing
  (`./eris-voice-scorer.py` prints `database not found`); they exit 1 on a
  failing score and 0 on a passing one.
- Suites that wrap another script judge it by an output line (`Failed: 0`,
  `PASS: All quotes verified`) rather than by the wrapped script's exit status.

## Voice scoring methodology

- **Corpus:** canonical speaker lines loaded from `lore/db/grimoire.db`
  (`transcript_lines` where the speaker matches Eris and `is_stage_dir = 0`),
  with `lore/source/transcripts/*.md` as fallback when the database has no
  matching rows. The scorer prints `Corpus size: N canonical lines`.
- **Components:** vocabulary overlap (0-20), n-gram phrasing (0-20), formal
  markers (0-25), Drifter-slang penalty (0-25 deducted), sentence cadence
  (0-15), character n-gram overlap (0-15), signature phrases (0-15), plus
  formality and brevity bonuses (0-5 each).
- **Verdict:** total score of 55 or more = PASS, 40 to 54 = PARTIAL, below 40 =
  FAIL; the process exits 0 only at 55 or above. A negative case (Drifter slang)
  must exit non-zero.
- **Golden snapshots:** each case in `golden-voice.json` pairs an agent, a tool
  (`scorer` or `validator`), sample text and an expected verdict. The test turns
  the tool's exit code into a verdict (0 = pass, non-zero = fail) and compares
  it with the expectation, so a verdict flip fails the suite even when both runs
  exit non-zero or both exit 0.
- **Forbidden and consistency checks:** `eris-voice-consistency.sh` flags
  Drifter speech patterns, laughter outside canon and quotes that belong to
  another speaker in the database (canon-verified quotes are exempt);
  `eris-validate-response.sh` rejects Drifter slang, laughter and responses
  outside the short-sentence length range.
