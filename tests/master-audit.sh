#!/bin/bash
# Eris master audit: every Eris-specific suite plus the shared gates.
# Agent-local tests live here; shared gates live in the grimoire at lore/tests.
# Usage: bash tests/master-audit.sh
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(dirname "$HERE")"
LORE="${LORE:-$REPO/lore}"
WORKSPACE="${WORKSPACE:-$REPO}"
export WORKSPACE

if [ ! -f "$LORE/db/grimoire.db" ]; then
    echo "FATAL: grimoire database missing at $LORE/db/grimoire.db"
    echo "       bootstrap: ./setup.sh (or python3 lore/db/migrate.py)"
    exit 1
fi

PASS=0; FAIL=0; TOTAL=0
run() {
    TOTAL=$((TOTAL+1))
    if eval "$2" > /dev/null 2>&1; then
        echo "  ✓ [$1] PASS"; PASS=$((PASS+1))
    else
        echo "  ✗ [$1] FAIL"; FAIL=$((FAIL+1))
    fi
}

SUITES=(
    "Module Completeness (16 checks)|bash $HERE/module-test.sh | grep -q 'Failed: 0'"
    "Quote Verification (0 unverified)|bash $HERE/quote-verify.sh | grep -q 'PASS: All quotes verified'"
    "Voice Validator|bash $HERE/validate-response.sh 'I am Eris Morn. The Darkness changes its environment as the Traveler did. Guardian, you are not alone.' | grep -q 'PASS: Sounds like Eris Morn'"
    "Voice Consistency|bash $HERE/voice-consistency.sh | grep -q 'VOICE CONSISTENCY CHECK COMPLETE'"
    "10-Turn Emotional Arc|bash $HERE/multiturn-test.sh | grep -q '10/10'"
    "Voice Scorer|python3 $HERE/voice-scorer.py 'I am Eris Morn. The Hive are a doctrine made flesh, Guardian.' >/dev/null"
    "Voice Scorer Negative|! python3 $HERE/voice-scorer.py 'Heh. Nah, kid. Yeah, we gonna bank those motes, brother.' >/dev/null 2>&1"
    "Scenario Simulator|bash $HERE/scenario-simulator.sh 'Tell me about the Hive' | grep -q 'Sounds like Eris Morn'"
    "Conversation (SQLite)|bash $HERE/conversation-test.sh"
    "Sample Conversation|python3 $HERE/sample-conversation-test.py"
    "Golden Voice Snapshots|bash $HERE/golden-voice-test.sh | grep -q 'Failed: 0'"
    "Suite Manifest|python3 $HERE/suite-manifest-test.py | grep -q 'manifest matches audit'"
    "Shared Helpers|bash $HERE/shared-helpers-test.sh | grep -q 'Passed:.*Failed: 0'"
    "Connection|bash $HERE/connection-test.sh | grep -q 'Failed: 0'"
    "Memory Isolation|python3 $HERE/memory-test.py | grep -q 'memory isolation'"
    "Multi-User Isolation|grep -q 'Never quote or summarize one user' $WORKSPACE/core/multi-user.md && grep -q 'memory.py' $WORKSPACE/core/multi-user.md"
    "Persona Freshness|python3 $HERE/persona-freshness.py"
    "Depends On Coverage|python3 $LORE/tests/check-agent-structure.py deps $WORKSPACE"
    "Token Estimate Coverage|python3 $LORE/tests/check-agent-structure.py tokens $WORKSPACE"
    "No Em-Dashes|python3 $LORE/tests/check-agent-structure.py dashes $WORKSPACE"
    "INDEX Completeness|python3 $LORE/tests/check-agent-structure.py index $WORKSPACE"
    "No Personal Paths|python3 $LORE/tests/check-agent-structure.py paths $WORKSPACE"
)

echo "============================================================"
echo "  ERIS MORN - MASTER AUDIT (ALL CHECKS)"
echo "============================================================"
echo ""
for entry in "${SUITES[@]}"; do
    run "${entry%%|*}" "${entry#*|}"
done

echo ""
echo "============================================================"
echo "  SCORECARD: $PASS / $TOTAL SUITES PASSED ($FAIL failed)"
echo "============================================================"
[ "$FAIL" -eq 0 ]
