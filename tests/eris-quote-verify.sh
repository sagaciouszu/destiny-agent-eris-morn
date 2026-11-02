#!/bin/bash
# Eris Quote Verifier (SQLite-backed, fast)
# Checks all quoted strings in agent files against the grimoire database.
# All checks use the DB's normalized text columns. Runs in <5 seconds.

DB="${DB:-$(cd "$(dirname "$0")/../lore" 2>/dev/null && pwd)/db/grimoire.db}"
[ -f "$DB" ] || DB="$(cd "$(dirname "$0")/.." && pwd)/lore/db/grimoire.db"
WORKSPACE="${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
[ -f "$DB" ] || { echo "FAIL: database not found"; exit 1; }

python3 - "$DB" "$WORKSPACE" << 'PYEOF'
import re, os, sys, sqlite3
db, ws = sys.argv[1], sys.argv[2]

def norm(s):
    s = s.lower().replace('\u2026','...').replace('\u2019',"'").replace('\u2014','-').replace('\u2013','-')
    s = re.sub(r'[^a-z0-9 ]+',' ',s); s = re.sub(r'\s+',' ',s).strip()
    return s

conn = sqlite3.connect(db)
# Canonical Eris transcript lines (speaker variants: Eris, Eris Morn, Eris Morn (communion))
canon_norm = set()
for r in conn.execute("SELECT line FROM transcript_lines WHERE speaker LIKE '%Eris%'"):
    if r[0]:
        cn = norm(r[0])
        if len(cn) >= 15:
            canon_norm.add(cn)
        for sentence in re.split(r'(?<=[.!?])\s+', cn):
            if len(sentence) >= 15:
                canon_norm.add(sentence)

tables = [
    ('book_entries', 'norm_text'),
    ('transcript_lines', 'norm_line'),
    ('grimoire_cards', 'norm_body'),
    ('interactions', 'norm_text'),
    ('items', 'norm_text'),
    ('records', 'norm_body'),
]
corpus_parts = []
title_norms = set()
for r in conn.execute("SELECT title FROM transcripts"):
    if r[0]:
        title_norms.add(norm(r[0]))
for r in conn.execute("SELECT title FROM books"):
    if r[0]:
        title_norms.add(norm(r[0]))
for tbl, col in tables:
    for r in conn.execute(f"SELECT {col} FROM {tbl} WHERE {col} != ''"):
        corpus_parts.append(r[0])
big_corpus = norm(' '.join(corpus_parts))
conn.close()

files = []
for root, _, fs in os.walk(ws):
    if '/lore' in root or '/.git' in root:
        continue
    for f in fs:
        if f.endswith('.md'):
            files.append(os.path.join(root, f))

def extract_quotes(path):
    """Yield quoted strings from prose lines, skipping fenced/inline code."""
    in_fence = False
    for line in open(path, encoding='utf-8', errors='ignore'):
        stripped = line.strip()
        if stripped.startswith('```') or stripped.startswith('~~~'):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        # drop inline code spans so SQL/CLI examples are not treated as quotes
        prose = re.sub(r'`[^`]*`', '', line)
        for m in re.finditer(r'"([^"]{7,})"', prose):
            yield m.group(1).strip()

unv = []
total = 0
for f in files:
    for q in extract_quotes(f):
        if not q:
            continue
        total += 1
        nq = norm(q)
        if not nq:
            continue
        # 1. Exact canon substring match
        if any(nq in cn or cn in nq for cn in canon_norm):
            continue
        # 2. Transcript/book title reference
        if any(nq in tn or tn in nq for tn in title_norms):
            continue
        # 2b. Corpus substring match via big combined corpus
        if nq in big_corpus:
            continue
        # 2c. Sentence-level match (handles dropped attributions like
        #     "Trust," Eris said at length, "is always a risk").
        #     Split the RAW quote first: norm() strips periods.
        raw_sents = [s for s in re.split(r'(?<=[.!?])\s+', q) if len(s.strip()) >= 10]
        if raw_sents:
            norm_sents = [norm(s) for s in raw_sents]
            norm_sents = [s for s in norm_sents if len(s) >= 15]
            if norm_sents:
                s_hits = sum(1 for s in norm_sents if s in big_corpus)
                if s_hits / len(norm_sents) >= 0.6:
                    continue
        # 2d. Word-bigram coverage: only for long quotes (>= 15 words) where
        #     dropped attributions fragment sentences. Short quotes must match
        #     exactly or by sentence - common word-pairs would false-positive.
        words = nq.split()
        if len(words) >= 15:
            bigrams = [' '.join(words[i:i+2]) for i in range(len(words)-1)]
            hits = sum(1 for b in bigrams if (' ' + b + ' ') in (' ' + big_corpus + ' '))
            if bigrams and hits / len(bigrams) >= 0.8:
                continue
        # 3. Corpus word-level substring per-table
        if any(nq in cp for cp in corpus_parts):
            continue
        unv.append((os.path.relpath(f, ws), q))

print("Files scanned:", len(files))
print("Quotes checked:", total)
print("Unverified quotes:", len(unv))
for f, q in unv[:20]:
    print(f"  {f}: {q[:60]}")
if unv:
    sys.exit(1)
else:
    print("PASS: All quotes verified.")
    sys.exit(0)
PYEOF
