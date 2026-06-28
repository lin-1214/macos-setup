# .zshenv — loaded for every shell (interactive, non-interactive, scripts)
# Keep this minimal: only variables that MUST be available everywhere.

export EDITOR="vim"
export VISUAL="$EDITOR"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Bat theme
export BAT_THEME="Dracula"

# Less — pass color codes, quit if output fits on screen
export LESS="-R -F -X"
export PAGER="less"

# Man pages through bat for syntax highlighting
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Homebrew: silence env hint
export HOMEBREW_NO_ENV_HINTS=1

# ─── API Keys ──────────────────────────────────────────────────────────────────
# Set your Anthropic key here (or export it in a private file sourced below).
# export ANTHROPIC_API_KEY=""

# Source a private env file if it exists (not committed to git)
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
