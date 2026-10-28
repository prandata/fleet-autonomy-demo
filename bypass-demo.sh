#!/bin/bash
# Safe demo: uses a temporary settings folder. Your real ~/.claude is never touched.
type_it(){ printf '\n\033[1;36m$ \033[0m'; for ((i=0;i<${#1};i++)); do printf '%s' "${1:$i:1}"; sleep 0.03; done; sleep 0.8; echo; eval "$1"; sleep 1.5; }
say(){ printf '\n\033[1;33m# %s\033[0m\n' "$1"; sleep 2; }
export DEMO=$(mktemp -d)
say "Claude Code has three permission styles. Default asks every time."
type_it 'echo "{\"permissions\":{\"defaultMode\":\"default\"}}" > $DEMO/settings.json && cat $DEMO/settings.json'
say "Auto mode: a safety classifier approves or blocks each action for you."
type_it 'echo "{\"permissions\":{\"defaultMode\":\"auto\"},\"autoMode\":{\"environment\":[\"Trusted GitHub org: github.com/prandata\"]}}" > $DEMO/settings.json && cat $DEMO/settings.json'
say "Bypass mode: no check at all. One line turns it on."
type_it 'echo "{\"permissions\":{\"defaultMode\":\"bypassPermissions\"},\"skipDangerousModePermissionPrompt\":true}" > $DEMO/settings.json && cat $DEMO/settings.json'
say "Shortcut for one session: press Shift+Tab until the mode line says bypass."
say "Our rule: bots may run anything, except spend, file, delete, contact outsiders, or give legal and tax advice."
rm -rf "$DEMO"
