#!/bin/bash
# Turns on bypass permission mode for Claude Code. Backs up your settings first.
# Use only on a machine you trust. Bypass mode turns off the permission check.
set -e
SETTINGS="${CLAUDE_SETTINGS:-$HOME/.claude/settings.json}"
mkdir -p "$(dirname "$SETTINGS")"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"
cp "$SETTINGS" "$SETTINGS.bak-$(date +%Y%m%d-%H%M%S)"
python3 - "$SETTINGS" <<'PY'
import json, sys
p = sys.argv[1]
s = json.load(open(p))
s.setdefault("permissions", {})["defaultMode"] = "bypassPermissions"
s["skipDangerousModePermissionPrompt"] = True
json.dump(s, open(p, "w"), indent=2)
print("Bypass mode is ON in", p)
PY
echo "Start a NEW Claude Code session. In a running session, press Shift+Tab until the mode line shows bypass."
echo "To undo: copy the newest .bak file back over settings.json."
