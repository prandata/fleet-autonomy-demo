#!/bin/bash
# End-to-end demo. Uses a temporary settings file, never your real one.
type_it(){ printf '\n\033[1;36m$ \033[0m'; for ((i=0;i<${#1};i++)); do printf '%s' "${1:$i:1}"; sleep 0.03; done; sleep 0.8; echo; eval "$1"; sleep 1.5; }
say(){ printf '\n\033[1;33m# %s\033[0m\n' "$1"; sleep 2; }
T=$(mktemp -d); export CLAUDE_SETTINGS="$T/settings.json"
echo '{"theme":"dark","permissions":{"defaultMode":"auto"}}' > "$CLAUDE_SETTINGS"
say "Step 1. A normal Claude Code setup. It runs in auto mode."
type_it 'cat $CLAUDE_SETTINGS'
say "Step 2. One command turns bypass on. Anyone can run it."
type_it 'bash "$(dirname "$0")"/install.sh'
say "Step 3. The file now says bypassPermissions. The old theme setting is kept."
type_it 'cat $CLAUDE_SETTINGS'
say "Step 4. Start a new Claude Code session. Press Shift+Tab to cycle modes live."
say "The mode line shows: default, then accept edits, then plan, then bypass."
say "Step 5. Undo is one command."
type_it 'bash "$(dirname "$0")"/uninstall.sh >/dev/null; cat $CLAUDE_SETTINGS'
say "The five actions that still need a human: spend, file, delete, contact outsiders, legal or tax."
rm -rf "$T"
