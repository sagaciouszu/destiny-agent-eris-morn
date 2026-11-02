#!/bin/bash
# Eris Module Completeness Test
ARCHIVE="${ARCHIVE:-$(cd "$(dirname "$0")/../lore" && pwd)}"
WORKSPACE="${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
echo "=== ERIS MODULE TEST ==="
PASS=0; FAIL=0
check() { if eval "$1" >/dev/null 2>&1; then echo "  ✓ $2"; PASS=$((PASS+1)); else echo "  ✗ $2"; FAIL=$((FAIL+1)); fi; }
for f in INDEX.md eris-core.md eris-voice.md SOUL.md IDENTITY.md AGENTS.md TOOLS.md README.md; do
    check "[ -f $WORKSPACE/$f ]" "$f exists"
done
for d in core world voice reference; do
    check "[ -d $WORKSPACE/$d ]" "$d/ exists"
done
# headers
MISSING=$(python3 - "$WORKSPACE" << 'PY'
import os,sys
ws=sys.argv[1]
n=0
for root,_,fs in os.walk(ws):
    if '/.git' in root: continue
    for f in fs:
        if not f.endswith('.md'): continue
        p=os.path.join(root,f)
        s=open(p,encoding='utf-8',errors='ignore').read()
        if '**Depends On:**' not in s or 'Token Estimate:' not in s:
            n+=1
print(n)
PY
)
check "[ $MISSING -eq 0 ]" "All md files have headers (missing: $MISSING)"
# em-dashes
EM=$(grep -rl '—\|–' "$WORKSPACE" --include='*.md' 2>/dev/null | grep -v .git | wc -l)
check "[ $EM -eq 0 ]" "No em/en-dashes (found: $EM)"
# personal paths
PER=$(grep -rl '/home/sredshaw' "$WORKSPACE" --include='*.md' 2>/dev/null | grep -v .git | wc -l)
check "[ $PER -eq 0 ]" "No personal paths (found: $PER)"
# lore symlink
check "[ -L $WORKSPACE/lore ]" "lore symlink exists"
echo ""
echo "Passed: $PASS | Failed: $FAIL"
[ "$FAIL" -eq 0 ]
