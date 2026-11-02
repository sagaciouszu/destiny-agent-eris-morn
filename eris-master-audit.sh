#!/bin/bash
# Eris Morn - Master Audit (All Checks)
ARCHIVE="${ARCHIVE:-$(cd "$(dirname "$0")/lore" && pwd)}"
WORKSPACE="${WORKSPACE:-$(cd "$(dirname "$0")" && pwd)}"
echo "============================================================"
echo "  ERIS MORN - MASTER AUDIT (ALL CHECKS)"
echo "============================================================"
echo ""
PASS=0; FAIL=0
run() {
    if bash "$1" >/dev/null 2>&1; then echo "  ✓ [$2] PASS"; PASS=$((PASS+1));
    else echo "  ✗ [$2] FAIL"; FAIL=$((FAIL+1)); fi
}
run "$WORKSPACE/tests/eris-module-test.sh" "Module Completeness"
run "$WORKSPACE/tests/eris-quote-verify.sh" "Quote Verification (0 unverified)"
if "$WORKSPACE/tests/eris-validate-response.sh" "I am Eris Morn. The Darkness changes its environment as the Traveler did. Guardian, you are not alone." >/dev/null 2>&1; then echo "  ✓ [Voice Validator] PASS"; PASS=$((PASS+1)); else echo "  ✗ [Voice Validator] FAIL"; FAIL=$((FAIL+1)); fi
run "$WORKSPACE/tests/eris-voice-consistency.sh" "Voice Consistency (no contamination)"
run "$WORKSPACE/tests/eris-multiturn-test.sh" "10-Turn Emotional Arc"
if python3 "$WORKSPACE/tests/eris-voice-scorer.py" "I am Eris Morn. The Hive are a doctrine made flesh, Guardian." >/dev/null 2>&1; then echo "  ✓ [Voice Scorer] PASS"; PASS=$((PASS+1)); else echo "  ✗ [Voice Scorer] FAIL"; FAIL=$((FAIL+1)); fi
if python3 "$WORKSPACE/tests/eris-voice-scorer.py" "Heh. Nah, kid. Yeah, we gonna bank those motes, brother." >/dev/null 2>&1; then echo "  ✗ [Voice Scorer Negative] FAIL (Drifter text accepted)"; FAIL=$((FAIL+1)); else echo "  ✓ [Voice Scorer Negative] PASS (Drifter text rejected)"; PASS=$((PASS+1)); fi
if bash "$WORKSPACE/tests/eris-scenario-simulator.sh" "Tell me about the Hive" 2>/dev/null | grep -q "Sounds like Eris Morn"; then echo "  ✓ [Scenario Simulator] PASS"; PASS=$((PASS+1)); else echo "  ✗ [Scenario Simulator] FAIL"; FAIL=$((FAIL+1)); fi
echo ""
echo "============================================================"
echo "  SCORECARD: $PASS / $((PASS+FAIL)) SUITES PASSED ($FAIL failed)"
echo "============================================================"
[ "$FAIL" -eq 0 ]
