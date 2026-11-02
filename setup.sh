#!/bin/bash
# Setup script for the Eris Morn agent brain/wrapper.
set -e
WORKSPACE="$(cd "$(dirname "$0")" && pwd)"
LORE_URL="${LORE_URL:-https://github.com/sagaciouszu/destiny-agent-grimoire.git}"
LORE_PATH="${1:-}"

echo "=== Eris Morn Agent Setup ==="
echo "Workspace: $WORKSPACE"

if [ -L "$WORKSPACE/lore" ]; then
    echo "lore symlink already exists -> $(readlink "$WORKSPACE/lore")"
elif [ -d "$WORKSPACE/lore" ]; then
    echo "lore/ directory already exists (not a symlink). Skipping."
else
    if [ -n "$LORE_PATH" ] && [ -d "$LORE_PATH" ]; then
        ln -s "$LORE_PATH" "$WORKSPACE/lore"
        echo "Created lore symlink -> $LORE_PATH"
    elif [ -n "$LORE_URL" ]; then
        echo "Cloning lore archive from $LORE_URL ..."
        git clone "$LORE_URL" "$WORKSPACE/lore"
        echo "Lore archive cloned."
    else
        echo "WARNING: Lore archive not available. Agent will work in degraded mode."
        exit 0
    fi
fi

if [ -L "$WORKSPACE/lore" ] || [ -d "$WORKSPACE/lore" ]; then
    TRANSCRIPT_COUNT=$(ls "$WORKSPACE/lore/transcripts/" 2>/dev/null | wc -l)
    if [ "$TRANSCRIPT_COUNT" -gt 0 ]; then
        echo "Lore archive: OK ($TRANSCRIPT_COUNT transcripts)"
    else
        echo "WARNING: Lore archive found but no transcripts."
    fi
else
    echo "WARNING: Lore archive not available."
fi
echo ""
echo "Setup complete. Load INDEX.md first, then eris-core.md."
