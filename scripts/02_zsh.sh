#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

backup_if_real() {
  local f="$1"
  if [[ -f "$f" && ! -L "$f" ]]; then
    local bak="${f}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$f" "$bak"
    echo "  Backed up $f → $bak"
  fi
}

backup_if_real ~/.zshrc
backup_if_real ~/.zshenv

ln -sf "$REPO_DIR/configs/.zshrc" ~/.zshrc
echo "  Linked ~/.zshrc"

ln -sf "$REPO_DIR/configs/.zshenv" ~/.zshenv
echo "  Linked ~/.zshenv"

# Starship config
mkdir -p ~/.config
ln -sf "$REPO_DIR/configs/starship.toml" ~/.config/starship.toml
echo "  Linked ~/.config/starship.toml"

# FZF shell completions & key bindings (only needs to run once)
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
  "$(brew --prefix)/opt/fzf/install" \
    --key-bindings --completion --no-update-rc --no-bash --no-fish 2>/dev/null || true
fi

echo "Zsh configured."
