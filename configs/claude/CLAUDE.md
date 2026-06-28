# Global Claude Code Instructions

## Response style
- Be concise. Skip preamble and trailing summaries.
- No emojis unless I ask for them.
- When referencing code, include `file:line` so I can jump directly.

## Code preferences
- Prefer editing existing files over creating new ones.
- No unnecessary comments — only when the WHY is non-obvious.
- No backwards-compatibility shims for code I'm actively changing.
- Trust internal APIs; only validate at system boundaries.

## Workflow
- For exploratory questions, give a 2–3 sentence recommendation with the main tradeoff.
- Don't implement until I agree on the approach.
- Before risky actions (destructive git, pushing, external API calls), confirm first.

## My environment
- macOS, Apple Silicon
- Shell: zsh with starship prompt, zsh-autosuggestions, fzf
- Editor: Cursor (AI code editor)
- Terminal multiplexer: tmux (prefix: Ctrl+a)
- Key aliases: `ll` (eza), `cat` (bat), `c.` (cursor .), `cw` (tmux workspace launcher)
- Git diff viewer: delta
- Setup repo: ~/Desktop/yyl/github/macos-setup (source of truth for all dotfiles)

## Terminal commands I prefer
- Use `rg` over `grep`, `fd` over `find`, `eza` over `ls`
- Use `gh` for GitHub operations
- Use `bat` for displaying file contents
