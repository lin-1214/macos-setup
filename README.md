# macOS Developer Setup

Reproducible terminal setup for a new Mac. Clone this repo and run one script.

## What's included

| Area | Tools |
|---|---|
| Shell | zsh + autosuggestions + syntax-highlighting + completions |
| History search | fzf (Ctrl+r), with fd integration |
| Prompt | Starship (Catppuccin Mocha) |
| `ls` / `cat` / `grep` / `find` | eza / bat / ripgrep / fd |
| Git diffs | delta (side-by-side, syntax colors) |
| Smart `cd` | zoxide (`z foo` jumps to frequently-used dirs) |
| Terminal multiplexer | tmux + Catppuccin theme + session persistence |
| Claude Code | CLI + global settings + `cw` workspace launcher |
| macOS defaults | key repeat, Finder, Dock, screenshots |

## First-time setup

```bash
# 1. Clone
git clone <this-repo> ~/macos-setup
cd ~/macos-setup

# 2. Allow the scripts to run
chmod +x install.sh scripts/*.sh

# 3. Run (installs Homebrew if missing, then everything else)
./install.sh
```

## Manual steps after running install.sh

1. **API key** — add to `~/.zshenv.local` (this file is not committed):
   ```bash
   export ANTHROPIC_API_KEY="sk-ant-..."
   ```

2. **Git identity**:
   ```bash
   git config --global user.name  "Your Name"
   git config --global user.email "your@email.com"
   ```

3. **Terminal font** — set your terminal app to use `JetBrainsMono Nerd Font`
   (needed for icons in eza / starship). The font is installed by the script.

4. **tmux plugins** — open tmux, then press `Ctrl+a` then `I` to install plugins.

## Key shortcuts

### Zsh
| Shortcut | Action |
|---|---|
| `Ctrl+r` | Fuzzy-search command history |
| `Ctrl+t` | Fuzzy-search files |
| `Alt+c` | Fuzzy cd into a directory |
| `→` or `Ctrl+Space` | Accept full autosuggestion |
| `Ctrl+f` | Accept one word of suggestion |
| `↑ / ↓` | History search with current prefix |

### Tmux (prefix = `Ctrl+a`)
| Shortcut | Action |
|---|---|
| `prefix \|` | Split pane vertically |
| `prefix -` | Split pane horizontally |
| `prefix h/j/k/l` | Navigate panes (vim-style) |
| `prefix [` / `prefix ]` | Previous / next window |
| `prefix z` | Zoom pane toggle |
| `prefix r` | Reload tmux config |
| `prefix I` | Install plugins (TPM) |

### Claude Code workspace
```bash
cw          # creates tmux session named after current dir
cw myproj   # creates/attaches session named "myproj"
cc          # alias for `claude`
ccc         # alias for `claude --continue`
```

The `cw` session has three windows:
- **claude** — Claude Code running immediately
- **shell** — for git, tests, misc commands
- **editor** — nvim if installed, otherwise a shell

## Useful aliases

```bash
# Navigation
ll          # eza long list with git status
lt          # eza tree view
z foo       # jump to a dir you've visited that matches "foo"

# Git
gs / gd / gl / gp / gpl
qc "msg"    # git add -A && git commit -m "msg"

# Utilities
mkcd dir    # mkdir + cd
killport 3000
jpp         # pretty-print JSON from stdin or clipboard
ports       # show listening ports
reload      # re-source .zshrc
```

## Customization

- **Machine-local zsh**: add to `~/.zshrc.local` (sourced at end of `.zshrc`, not committed)
- **API keys / secrets**: put in `~/.zshenv.local` (sourced at end of `.zshenv`, not committed)
- **Claude instructions**: `configs/claude/CLAUDE.md` is copied to `~/.claude/CLAUDE.md` on first install; edit either place
- **Claude permissions**: `configs/claude/settings.json` → `~/.claude/settings.json`

## Updating after changes

Since all configs are symlinked into this repo, edits take effect immediately.
To pull updates on an existing machine:

```bash
cd ~/macos-setup
git pull
# re-run individual scripts if new packages were added
bash scripts/01_homebrew.sh
```
