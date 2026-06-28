#!/usr/bin/env bash
set -euo pipefail

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Activate for this session
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew update --quiet

PACKAGES=(
  # Shell plugins
  zsh-autosuggestions       # fish-style inline history suggestions
  zsh-syntax-highlighting   # color commands as you type
  zsh-completions           # extra tab completions

  # Fuzzy finder — ctrl+r history, ctrl+t file pick, alt+c dir jump
  fzf

  # Prompt
  starship

  # Smart cd (learns your most-used directories)
  zoxide

  # Modern CLI replacements
  eza      # ls  → icons, git status, tree
  bat      # cat → syntax highlighting, line numbers
  ripgrep  # grep → fast, respects .gitignore
  fd       # find → ergonomic, fast
  delta    # git diff → side-by-side, syntax colors

  # Data
  jq       # JSON processor
  yq       # YAML processor

  # Git / GitHub
  git
  gh

  # Terminal multiplexer
  tmux

  # Monitoring
  btop     # beautiful top replacement

  # Node (needed for Claude Code CLI)
  node

  # Python version manager
  pyenv
)

for pkg in "${PACKAGES[@]}"; do
  # Skip comment lines
  [[ "$pkg" == \#* ]] && continue
  if brew list "$pkg" &>/dev/null 2>&1; then
    echo "  [skip] $pkg"
  else
    echo "  [install] $pkg"
    brew install "$pkg"
  fi
done

# Nerd Font — needed for icons in eza/starship
if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null 2>&1; then
  echo "  [install] font-jetbrains-mono-nerd-font"
  brew install --cask font-jetbrains-mono-nerd-font
else
  echo "  [skip] font-jetbrains-mono-nerd-font"
fi

echo "Homebrew packages done."
