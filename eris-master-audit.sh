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
echo ""
echo "============================================================"
echo "  SCORECARD: $PASS / $((PASS+FAIL)) SUITES PASSED ($FAIL failed)"
echo "============================================================"
[ "$FAIL" -eq 0 ]
