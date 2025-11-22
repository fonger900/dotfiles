# ==========================================
# Simplified ZSH Configuration
# Author: fonger
# Updated: 2025-11-22
# ==========================================

# ==========================================
# Oh-My-Zsh Configuration
# ==========================================
export ZSH="$HOME/.oh-my-zsh"

# Disable Oh-My-Zsh auto-update prompts (update manually when you're ready)
zstyle ':omz:update' mode disabled

# Essential plugins
plugins=(
  git
  docker
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# ==========================================
# Environment Variables
# ==========================================
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# ==========================================
# Path Configuration
# ==========================================
# Use typeset to ensure unique paths
typeset -U path

# Local and Homebrew binaries first
path=(
  "$HOME/.local/bin"
  "/opt/homebrew/bin"
  $path
)

# Language toolchains
path=(
  "$HOME/.cargo/bin"      # Rust
  "$HOME/.bun/bin"        # Bun
  "$GOPATH/bin"           # Go
  $path
)

export PATH

# ==========================================
# Node.js / NVM Configuration
# ==========================================
export NVM_DIR="$HOME/.nvm"

# Lazy load NVM for faster shell startup
load_nvm() {
  if [ -z "$NVM_LOADED" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    export NVM_LOADED=1
  fi
}

# Auto-load nvm when these commands are called
nvm() {
  unset -f nvm node npm npx
  load_nvm
  nvm "$@"
}
node() {
  unset -f nvm node npm npx
  load_nvm
  node "$@"
}
npm() {
  unset -f nvm node npm npx
  load_nvm
  npm "$@"
}
npx() {
  unset -f nvm node npm npx
  load_nvm
  npx "$@"
}

# ==========================================
# Go, Rust, Python
# ==========================================
export GOPATH="$HOME/go"

# Rust Cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Pyenv (if installed)
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi

# ==========================================
# FZF (Fuzzy Finder) Configuration
# ==========================================
# Use fd for faster file finding
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# Use fd for faster directory finding
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
# Use bat for previewing files
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

# ==========================================
# History Configuration
# ==========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ==========================================
# ZSH Options
# ==========================================
setopt AUTO_CD
setopt CORRECT
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS

# ==========================================
# Core Aliases
# ==========================================
# General
alias c='clear'
alias h='history'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias reload='source ~/.zshrc && echo "✅ Zsh config reloaded"'
alias zshconfig='nvim ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'

# System
alias sudo='sudo ' # a space at the end allows alias expansion
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias rg='rg --smart-case'

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias glg='git log --graph --oneline --decorate --all'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps -a'
alias di='docker images'

# ==========================================
# Zoxide (Better `cd`)
# ==========================================
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# ==========================================
# Starship Prompt
# ==========================================
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ==========================================
# zsh-syntax-highlighting (must be last)
# ==========================================
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ==========================================
# Completion System
# ==========================================
autoload -Uz compinit
compinit

# ==========================================
# Local Customizations (Keep at the end)
# ==========================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Added by Antigravity
export PATH="/Users/fonger/.antigravity/antigravity/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/fonger/.lmstudio/bin"
# End of LM Studio CLI section

