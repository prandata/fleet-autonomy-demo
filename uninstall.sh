#!/bin/bash
# Restores the newest backup made by install.sh.
SETTINGS="${CLAUDE_SETTINGS:-$HOME/.claude/settings.json}"
B=$(ls -t "$SETTINGS".bak-* 2>/dev/null | head -1)
[ -n "$B" ] && cp "$B" "$SETTINGS" && echo "Restored $B" || echo "No backup found"
