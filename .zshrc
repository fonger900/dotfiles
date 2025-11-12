# ==========================================
# ZSH Configuration for Fullstack Development
# ==========================================

# Enable Powerlevel10k instant prompt (optional, if using p10k)
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# ==========================================
# Oh-My-Zsh Configuration
# ==========================================
export ZSH="$HOME/.oh-my-zsh"

# Theme
# ZSH_THEME="robbyrussell"  # Change to "agnoster" or install powerlevel10k for better visuals

# Plugins
plugins=(
  git
  docker
  docker-compose
  node
  npm
  yarn
  python
  pip
  postgres
  redis-cli
  aws
  kubectl
  terraform
  tmux
  vscode
  web-search
  colored-man-pages
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
  z
)

source $ZSH/oh-my-zsh.sh

# ==========================================
# Environment Variables
# ==========================================
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# ==========================================
# Path Configuration
# ==========================================
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"  # Homebrew on Apple Silicon
export PATH="/usr/local/opt/openssl/bin:$PATH"

# ==========================================
# Node.js / NVM Configuration
# ==========================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Yarn global
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# ==========================================
# Python / pyenv Configuration
# ==========================================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# pipx
export PATH="$HOME/.local/bin:$PATH"

# ==========================================
# Go Configuration
# ==========================================
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# ==========================================
# Rust Configuration
# ==========================================
export PATH="$HOME/.cargo/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ==========================================
# Docker Configuration
# ==========================================
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# ==========================================
# Database Configuration
# ==========================================
# PostgreSQL
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"
export PGDATA="$HOME/.postgres/data"

# ==========================================
# Cloud Provider CLI
# ==========================================
# AWS
export AWS_PAGER=""

# ==========================================
# Development Aliases - Git
# ==========================================
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gbd='git branch -d'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit -v -a'
alias gcam='git commit -a -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git pull'
alias glg='git log --graph --oneline --decorate --all'
alias glo='git log --oneline'
alias gm='git merge'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gr='git remote'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grs='git restore'
alias grst='git restore --staged'
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gw='git worktree'

# ==========================================
# Development Aliases - Docker
# ==========================================
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dce='docker-compose exec'
alias dcb='docker-compose build'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -a --volumes'
alias dstop='docker stop $(docker ps -q)'
alias dlogs='docker logs -f'

# ==========================================
# Development Aliases - Node.js
# ==========================================
alias ni='npm install'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
alias ns='npm start'
alias nt='npm test'
alias nls='npm list --depth=0'

alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yag='yarn global add'
alias yr='yarn run'
alias ys='yarn start'
alias yd='yarn dev'
alias yb='yarn build'
alias yt='yarn test'

alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pr='pnpm run'
alias ps='pnpm start'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'

# ==========================================
# Development Aliases - Python
# ==========================================
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'
alias deactivate='deactivate'
alias pipi='pip install'
alias pipr='pip install -r requirements.txt'
alias pipf='pip freeze > requirements.txt'
alias dj='python manage.py'
alias djr='python manage.py runserver'
alias djm='python manage.py migrate'
alias djmm='python manage.py makemigrations'
alias djs='python manage.py shell'
alias djt='python manage.py test'
alias djsu='python manage.py createsuperuser'

# ==========================================
# Development Aliases - General
# ==========================================
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias c='clear'
alias h='history'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Directory shortcuts
alias dev='cd ~/Developer'
alias proj='cd ~/Projects'
alias dots='cd ~/dotfiles'

# Process management
alias psa='ps aux | grep'
alias kp='killall -9'

# Network
alias ports='lsof -i -P -n | grep LISTEN'
alias myip='curl -s http://ipecho.net/plain; echo'
alias localip='ipconfig getifaddr en0'

# System
alias brewup='brew update && brew upgrade && brew cleanup'
alias zshconfig='nvim ~/.zshrc'
alias reload='source ~/.zshrc'

# ==========================================
# Custom Functions
# ==========================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find file by name
ff() {
  find . -type f -iname "*$1*"
}

# Find directory by name
fdir() {
  find . -type d -iname "*$1*"
}

# Git clone and cd
gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Create React App with TypeScript
cra() {
  npx create-react-app "$1" --template typescript && cd "$1"
}

# Create Next.js App
cnext() {
  npx create-next-app@latest "$1" && cd "$1"
}

# Create Vite App
cvite() {
  npm create vite@latest "$1" && cd "$1"
}

# Django start project
djstart() {
  django-admin startproject "$1" && cd "$1"
}

# Quick server
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Docker cleanup
dclean() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
  docker rmi $(docker images -q)
  docker volume rm $(docker volume ls -q)
  docker network prune -f
}

# Kill process on port
killport() {
  lsof -ti:"$1" | xargs kill -9
}

# Git commit with timestamp
gct() {
  git add -A && git commit -m "$1 [$(date +'%Y-%m-%d %H:%M:%S')]"
}

# Quick git push
qpush() {
  git add -A && git commit -m "${1:-quick update}" && git push
}

# Create and checkout new branch from main
gnew() {
  git checkout main && git pull && git checkout -b "$1"
}

# ==========================================
# FZF Configuration
# ==========================================
if command -v fzf &> /dev/null; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# ==========================================
# Starship Prompt (if installed)
# ==========================================
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ==========================================
# Additional Plugin Sources
# ==========================================
# zsh-autosuggestions
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting (must be last)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ==========================================
# Welcome Message
# ==========================================
echo "🚀 Fullstack Dev Environment Loaded"
if command -v node &> /dev/null; then
  echo "📦 Node: $(node --version)"
fi
if command -v python3 &> /dev/null; then
  echo "🐍 Python: $(python3 --version | cut -d' ' -f2)"
fi
if command -v docker &> /dev/null; then
  echo "🐳 Docker: $(docker --version | cut -d' ' -f3 | tr -d ',')"
fi

# ==========================================
# Local Customizations
# ==========================================
# Source local zshrc if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
