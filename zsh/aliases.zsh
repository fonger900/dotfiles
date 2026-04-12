# ==========================================
# Core Aliases
# ==========================================

# General
alias devsetup='devsetup.sh'
alias c='clear'
alias h='history'

if command -v eza &>/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -lh --icons'
  alias la='eza -a --icons'
  alias lt='eza --tree --icons'
else
  alias ll='ls -alFh'
  alias la='ls -A'
  alias l='ls -CF'
fi

alias reload='source ~/.zshrc'
alias dots='cd $DOTFILES && ./bootstrap.sh'
alias zshconfig='nvim ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'

# Platform Specific Aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific
  alias ls='eza --icons'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific
  if command -v wl-copy &>/dev/null; then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  elif command -v xclip &>/dev/null; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  fi

  # Debian/Ubuntu specific
  if command -v apt &>/dev/null; then
    alias update='sudo apt update && sudo apt upgrade -y'
    alias install='sudo apt install'
  fi
fi

# System
alias sudo='sudo '

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

# Container & Docker
if command -v docker &>/dev/null; then
  alias d='docker'
  alias dc='docker-compose'
  alias dps='docker ps -a'
  alias di='docker images'
elif command -v container &>/dev/null; then
  alias d='container'
  alias dps='container ls -a'
  alias di='container image ls'
  # Note: container does not have a direct compose equivalent
fi

# Apple Native Container Specific (non-conflicting)
if command -v container &>/dev/null; then
  alias con='container'
  alias cr='container run'
  alias cl='container ls'
  alias cip='container image pull'
  alias cb='container build'
  alias cs='container system'
fi

# Apps
alias bt='Budget_Tracker'
