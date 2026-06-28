#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

if [[ -f ~/.tmux.conf && ! -L ~/.tmux.conf ]]; then
  cp ~/.tmux.conf ~/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)
  echo "  Backed up .tmux.conf"
fi

ln -sf "$REPO_DIR/configs/.tmux.conf" ~/.tmux.conf
echo "  Linked ~/.tmux.conf"

# TPM — Tmux Plugin Manager
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "  TPM installed"
else
  echo "  TPM already present"
fi

echo "Tmux configured."
echo "  → Open tmux, then press Ctrl+a I to install plugins"
