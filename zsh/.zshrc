# ==========================================
# Main ZSH Configuration
# ==========================================
# Define Dotfiles location for easy sourcing
export DOTFILES="$HOME/dotfiles"

# 1. Path Configuration (Load first)
[ -f "$DOTFILES/zsh/path.zsh" ] && source "$DOTFILES/zsh/path.zsh"

# 2. Oh-My-Zsh Setup
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled
plugins=(
  git
  docker
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

# Load OMZ
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# 3. Exports & Options
[ -f "$DOTFILES/zsh/exports.zsh" ] && source "$DOTFILES/zsh/exports.zsh"

# 4. Aliases
[ -f "$DOTFILES/zsh/aliases.zsh" ] && source "$DOTFILES/zsh/aliases.zsh"

# 5. Tool Initializations
# Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Zoxide (Better cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# Starship Prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Syntax Highlighting (Homebrew Fallback/Override)
# Often needed at the very end to work correctly
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Completion
autoload -Uz compinit
compinit

# 6. Local Customizations
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Mise
eval "$(~/.local/bin/mise activate zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/fonger/.lmstudio/bin"
# End of LM Studio CLI section


# pnpm
export PNPM_HOME="/Users/fonger/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
