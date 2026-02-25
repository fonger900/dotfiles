# ==========================================
# Core Aliases
# ==========================================

# General
alias devsetup='devsetup.sh'
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

# Docker & Containers
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps -a'
alias di='docker images'

# Apple Native Container
alias c='container'
alias cr='container run'
alias cl='container ls'
alias cp='container image pull'
alias cb='container build'
alias cs='container system'

# Apps
alias bt='Budget_Tracker'
