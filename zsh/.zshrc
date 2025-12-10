source ~/zsh-defer/zsh-defer.plugin.zsh


# ==========================================
# Performance-Optimized ZSH Configuration
# ==========================================
export DOTFILES="$HOME/dotfiles"

# Skip global compinit for faster startup
skip_global_compinit=1

# 1. Path Configuration (Load first)
[ -f "$DOTFILES/zsh/path.zsh" ] && source "$DOTFILES/zsh/path.zsh"

# 2. Minimal Oh-My-Zsh Setup
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled
# Reduced plugins for faster startup
plugins=(git docker)

# Load OMZ
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# 3. Exports & Options
[ -f "$DOTFILES/zsh/exports.zsh" ] && source "$DOTFILES/zsh/exports.zsh"

# 4. Aliases
[ -f "$DOTFILES/zsh/aliases.zsh" ] && source "$DOTFILES/zsh/aliases.zsh"

# 5. Lazy-loaded Tool Initializations

# Lazy load zoxide
_zoxide_init() {
  eval "$(zoxide init zsh --cmd cd)"
  unfunction _zoxide_init
}
alias cd='_zoxide_init && cd'

# Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Defer syntax highlighting to end
_load_syntax_highlighting() {
  if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
}
zsh-defer _load_syntax_highlighting

# Optimized completion (Deferred)
_init_completion() {
  autoload -Uz compinit
  # Only regenerate compdump once per day
  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}
zsh-defer _init_completion

# Lazy load mise
_mise_init() {
  eval "$(~/.local/bin/mise activate zsh)"
  unfunction _mise_init
}
alias mise='_mise_init && mise'

# pnpm (optimized)
export PNPM_HOME="/Users/fonger/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# LM Studio
export PATH="$PATH:/Users/fonger/.lmstudio/bin"

# 6. Local Customizations
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Fastfetch
if command -v fastfetch &> /dev/null; then
  fastfetch
fi

