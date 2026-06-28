#!/usr/bin/env bash
set -euo pipefail

echo "  Applying macOS system preferences..."

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Fastest key repeat (great for vim, terminal navigation)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# ── Typing ────────────────────────────────────────────────────────────────────
# Disable autocorrect / smart substitutions (they break code snippets)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled  -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled   -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# ── Finder ────────────────────────────────────────────────────────────────────
defaults write com.apple.finder AppleShowAllFiles          -bool true   # show hidden files
defaults write NSGlobalDomain   AppleShowAllExtensions     -bool true   # show all extensions
defaults write com.apple.finder ShowStatusBar              -bool true
defaults write com.apple.finder ShowPathbar                -bool true
defaults write com.apple.finder FXDefaultSearchScope       -string "SCcf"  # search current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ── Dock ──────────────────────────────────────────────────────────────────────
defaults write com.apple.dock autohide             -bool true
defaults write com.apple.dock show-recents         -bool false
defaults write com.apple.dock autohide-delay       -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4

# ── Save panels ───────────────────────────────────────────────────────────────
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud  -bool false  # save to disk, not iCloud

# ── Screenshots ───────────────────────────────────────────────────────────────
mkdir -p ~/Desktop/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture type     -string "png"

# ── Restart affected apps ─────────────────────────────────────────────────────
for app in "Finder" "Dock" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

echo "  macOS defaults applied (some need a logout to fully take effect)."
