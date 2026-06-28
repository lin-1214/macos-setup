#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

if [[ -f ~/.gitconfig && ! -L ~/.gitconfig ]]; then
  cp ~/.gitconfig ~/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)
  echo "  Backed up .gitconfig"
fi

ln -sf "$REPO_DIR/configs/.gitconfig" ~/.gitconfig
echo "  Linked ~/.gitconfig"

echo "Git configured."
echo "  → Set your identity:"
echo "      git config --global user.name  'Your Name'"
echo "      git config --global user.email 'your@email.com'"
