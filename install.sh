#!/usr/bin/env bash
# Main entry point — run this on a fresh Mac to get everything set up.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export REPO_DIR

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}[warn]${NC} $1"; }
err()  { echo -e "${RED}[error]${NC} $1"; exit 1; }

[[ "$(uname)" == "Darwin" ]] || err "This script is macOS only."

log "Starting macOS developer setup from $REPO_DIR"
echo ""

SCRIPTS=(
  "01_homebrew.sh"
  "02_zsh.sh"
  "03_tmux.sh"
  "04_git.sh"
  "05_claude.sh"
  "06_macos_defaults.sh"
)

for script in "${SCRIPTS[@]}"; do
  log "[$script]"
  bash "$REPO_DIR/scripts/$script"
  echo ""
done

log "All done! Restart your terminal."
echo ""
echo "Manual steps remaining:"
echo "  1. Set ANTHROPIC_API_KEY in ~/.zshenv"
echo "  2. git config --global user.name  'Your Name'"
echo "  3. git config --global user.email 'your@email.com'"
echo "  4. In your terminal app, set the font to 'JetBrainsMono Nerd Font'"
echo "  5. Open tmux and press prefix+I (Ctrl+a then I) to install tmux plugins"
