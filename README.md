# Running an AI agent fleet without constant permission prompts

A small open-source demo of how one founder runs about 20 AI agents on a single machine. It shows the three Claude Code permission modes and the one rule that keeps the fleet safe.

## The three modes

| Mode | Who approves each action | Speed | Risk |
|---|---|---|---|
| `default` | The human, every time | Slow | Lowest |
| `auto` | A safety classifier. It drops broad rules such as `Bash(*)`. You teach it what to trust in `autoMode.environment`. | Medium | Low |
| `bypassPermissions` | Nobody. No check runs. | Fast | High. Anthropic documents it for containers and virtual machines. |

## Turn bypass mode on (one command)

```bash
git clone https://github.com/prandata/fleet-autonomy-demo && bash fleet-autonomy-demo/install.sh
```

The script backs up your `settings.json`, keeps your other settings, and sets `defaultMode` to `bypassPermissions`. Run `bash fleet-autonomy-demo/uninstall.sh` to restore the backup. Use it only on a machine you trust.

## Turn bypass mode on (by hand)

1. Edit `~/.claude/settings.json` yourself. Use `examples/settings.bypass.json` as the pattern.
2. Start a new session. A running session keeps its old mode.
3. Or press Shift+Tab (not Shift+Enter) in a running session until the mode line shows bypass.

## The fleet rule

Agents run anything, except five actions that need the owner's explicit words for that exact action:
1. Spending money.
2. Signing or submitting filings and applications.
3. Deleting live content.
4. Contacting outsiders in the owner's name.
5. Legal or tax actions.

Bypass mode removes the technical block. The rule is the only guard left. Write it into every agent's instructions.

## How the fleet runs

- Every task lives in a ticket. The ticket links to a pull request.
- An hourly routine finds stale tickets and wakes the owning agent.
- Agents decide their own approvals. If a choice is a toss-up, they pick one and move on.
- A second agent reviews high-stakes work.

## Try the demo

```bash
./bypass-demo.sh          # writes only to a temporary folder
asciinema rec -c ./bypass-demo.sh demo.cast
```

`bypass-demo.mp4` and `full-demo.mp4` are recordings of the demos. `full-demo.sh` shows the install, the result, and the undo end to end. The demo never touches your real `~/.claude`.

## Licence

MIT.
