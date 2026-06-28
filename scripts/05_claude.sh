#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

# Install Claude Code CLI
if ! command -v claude &>/dev/null; then
  echo "  Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
else
  echo "  Claude Code already installed ($(claude --version 2>/dev/null || echo 'unknown version'))"
fi

# Global Claude config directory
mkdir -p ~/.claude

# Link Claude Code global settings
if [[ -f ~/.claude/settings.json && ! -L ~/.claude/settings.json ]]; then
  cp ~/.claude/settings.json ~/.claude/settings.json.backup.$(date +%Y%m%d_%H%M%S)
fi
ln -sf "$REPO_DIR/configs/claude/settings.json" ~/.claude/settings.json
echo "  Linked ~/.claude/settings.json"

# Global CLAUDE.md — instructions that apply to every project
if [[ ! -f ~/.claude/CLAUDE.md ]]; then
  cp "$REPO_DIR/configs/claude/CLAUDE.md" ~/.claude/CLAUDE.md
  echo "  Copied ~/.claude/CLAUDE.md (global instructions)"
else
  echo "  ~/.claude/CLAUDE.md already exists — not overwriting"
fi

echo "Claude Code configured."
echo "  → Set ANTHROPIC_API_KEY in ~/.zshenv"
