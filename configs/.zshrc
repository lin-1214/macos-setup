# ─────────────────────────────────────────────────────────────────────────────
# Homebrew
# ─────────────────────────────────────────────────────────────────────────────
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"      # Intel
fi

BREW_PREFIX="$(brew --prefix 2>/dev/null || echo /opt/homebrew)"
export PATH="$HOME/.local/bin:$PATH"

# Cursor — add CLI to PATH
[[ -d "/Applications/Cursor.app/Contents/Resources/app/bin" ]] && \
  export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"

# ─────────────────────────────────────────────────────────────────────────────
# History
# ─────────────────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS   # deduplicate; keep newest
setopt HIST_IGNORE_SPACE      # exclude commands prefixed with space
setopt HIST_FIND_NO_DUPS      # no dupes when searching history
setopt SHARE_HISTORY          # share history across all open shells
setopt EXTENDED_HISTORY       # record timestamp for each command

# ─────────────────────────────────────────────────────────────────────────────
# Shell Options
# ─────────────────────────────────────────────────────────────────────────────
setopt AUTO_CD          # type a dir name to cd into it
setopt AUTO_PUSHD       # cd pushes to stack (use `dirs` / `popd`)
setopt PUSHD_IGNORE_DUPS
setopt CORRECT          # suggest corrections for mistyped commands
setopt NO_BEEP

# ─────────────────────────────────────────────────────────────────────────────
# Completions
# ─────────────────────────────────────────────────────────────────────────────
FPATH="$BREW_PREFIX/share/zsh-completions:$BREW_PREFIX/share/zsh/site-functions:$FPATH"
autoload -Uz compinit
compinit -i -C   # -C skips security check on cached dump for faster startup

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings'     format '%F{red}no matches%f'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zsh/cache"

# ─────────────────────────────────────────────────────────────────────────────
# Plugins
# ─────────────────────────────────────────────────────────────────────────────
# Gray-text suggestions based on history (→ or Ctrl+Space to accept)
[[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Color-code commands, flags, and strings as you type
# Must be sourced LAST among plugins
[[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ─────────────────────────────────────────────────────────────────────────────
# Key Bindings
# ─────────────────────────────────────────────────────────────────────────────
bindkey -e                          # emacs key map (default for most terminals)
bindkey '^[[A' history-search-backward   # ↑ — search history with current prefix
bindkey '^[[B' history-search-forward    # ↓
bindkey '^ '   autosuggest-accept        # Ctrl+Space — accept full suggestion
bindkey '^f'   forward-word              # Ctrl+f — accept one word of suggestion

# ─────────────────────────────────────────────────────────────────────────────
# FZF  (Ctrl+r history · Ctrl+t files · Alt+c dirs)
# ─────────────────────────────────────────────────────────────────────────────
if command -v fzf &>/dev/null; then
  source <(fzf --zsh) 2>/dev/null

  # Catppuccin Mocha color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --height 50% --layout reverse --border rounded --info inline
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  "
  export FZF_CTRL_R_OPTS="--sort --exact"

  # Use fd (fast, .gitignore-aware) for fzf file browsing
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
fi

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Navigation
# ─────────────────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — eza (modern ls)
# ─────────────────────────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -la --icons --git --time-style=relative'
  alias la='eza -la --icons'
  alias lt='eza --tree --icons --level=2'
  alias l='eza -l --icons --git'
fi

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — bat (modern cat)
# ─────────────────────────────────────────────────────────────────────────────
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'     # with paging
fi

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Git
# ─────────────────────────────────────────────────────────────────────────────
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch --all --prune'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gm='git merge'
alias grh='git reset HEAD~1 --soft'   # undo last commit, keep changes staged

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Tmux
# ─────────────────────────────────────────────────────────────────────────────
alias ta='tmux attach -t'
alias td='tmux detach'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tn='tmux new-session -s'

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Cursor
# ─────────────────────────────────────────────────────────────────────────────
if command -v cursor &>/dev/null; then
  alias c.='cursor .'           # open current dir in Cursor
  alias c='cursor'              # open file(s) in Cursor
fi

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Claude Code
# ─────────────────────────────────────────────────────────────────────────────
alias cc='claude'
alias ccc='claude --continue'
alias ccr='claude --resume'

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Development
# ─────────────────────────────────────────────────────────────────────────────
alias py='python3'
alias pip='pip3'
alias k='kubectl'
alias d='docker'
alias dc='docker compose'

# ─────────────────────────────────────────────────────────────────────────────
# Aliases — Utilities
# ─────────────────────────────────────────────────────────────────────────────
alias reload='source ~/.zshrc && echo "zshrc reloaded"'
alias zshconfig='${EDITOR:-vim} ~/.zshrc'
alias ports='lsof -iTCP -sTCP:LISTEN -P'
alias myip='curl -s https://api.ipify.org && echo'
alias localip='ipconfig getifaddr en0'
alias path='echo $PATH | tr ":" "\n"'        # print PATH one entry per line

# ─────────────────────────────────────────────────────────────────────────────
# Functions
# ─────────────────────────────────────────────────────────────────────────────

# mkdir + cd in one step
mkcd() { mkdir -p "$1" && cd "$1"; }

# Kill whatever is listening on a port
killport() {
  local pids
  pids="$(lsof -ti:"$1")"
  [[ -n "$pids" ]] && echo "$pids" | xargs kill -9 && echo "Killed process on :$1" || echo "Nothing on :$1"
}

# Stage everything and commit
qc() { git add -A && git commit -m "$*"; }

# Show a tree of the current git repo, ignoring untracked files
gtree() { git ls-files | tree --fromfile -C "${@:-.}"; }

# Pretty print json from clipboard or stdin
jpp() { [[ -p /dev/stdin ]] && jq '.' || pbpaste | jq '.'; }

# ─────────────────────────────────────────────────────────────────────────────
# cw — Claude Workspace
# Opens (or attaches to) a named tmux session with three windows pre-configured
# for a Claude Code workflow: claude / shell / editor
# Usage: cw [session-name]  (defaults to current directory name)
# ─────────────────────────────────────────────────────────────────────────────
cw() {
  local name="${1:-$(basename "$PWD" | tr '[:upper:]. ' '[:lower:]--')}"

  # If the session already exists, just switch to / attach it
  if tmux has-session -t "$name" 2>/dev/null; then
    if [[ -n "${TMUX:-}" ]]; then
      tmux switch-client -t "$name"
    else
      tmux attach-session -t "$name"
    fi
    return
  fi

  # Create detached session rooted at current directory
  tmux new-session -d -s "$name" -c "$PWD"

  # Window 1 — claude: launch Claude Code immediately
  tmux rename-window -t "${name}:1" "claude"
  tmux send-keys -t "${name}:claude" "claude" Enter

  # Window 2 — shell: for running tests, git, misc commands
  tmux new-window -t "$name" -n "shell" -c "$PWD"

  # Window 3 — build: shell for tests, build output, logs
  tmux new-window -t "$name" -n "build" -c "$PWD"

  # Open Cursor for the project (GUI, runs outside tmux)
  if command -v cursor &>/dev/null; then
    cursor . &>/dev/null &
    disown
  fi

  # Land on the claude window
  tmux select-window -t "${name}:claude"

  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$name"
  else
    tmux attach-session -t "$name"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Tool integrations (order matters: zoxide aliases cd, so source after aliases)
# ─────────────────────────────────────────────────────────────────────────────

# Zoxide — type `z foo` to jump to a frequently-used directory containing "foo"
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# pyenv
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# nvm
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
fi

# Starship prompt (must be last)
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Source machine-local overrides (not committed to git)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

cd ~/Desktop/yyl/GitHub
