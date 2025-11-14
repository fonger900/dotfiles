# ==========================================
# ZSH Configuration for Fullstack Development
# Author: fonger
# Updated: 2025-11-14
# ==========================================

# ==========================================
# Performance: Enable profiling (uncomment to debug slow startup)
# ==========================================
# zmodload zsh/zprof

# ==========================================
# Oh-My-Zsh Configuration
# ==========================================
export ZSH="$HOME/.oh-my-zsh"

# Disable Oh-My-Zsh auto-update prompts (update manually)
zstyle ':omz:update' mode disabled

# Plugins - optimized for fullstack development
plugins=(
  # Git integration
  git
  git-flow
  github
  
  # Docker & Kubernetes
  docker
  docker-compose
  kubectl
  helm
  
  # Node.js ecosystem
  node
  npm
  yarn
  nvm
  
  # Python ecosystem
  python
  pip
  pipenv
  virtualenv
  
  # Database tools
  postgres
  redis-cli
  
  # Cloud providers
  aws
  gcloud
  
  # Infrastructure as Code
  terraform
  ansible
  
  # Development tools
  tmux
  vscode
  web-search
  colored-man-pages
  command-not-found
  jsontools
  
  # Productivity
  z                           # Jump to frequently used directories
  extract                     # Universal archive extractor
  sudo                        # Press ESC twice to prefix with sudo
  
  # Enhanced plugins (install separately if needed)
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
export LC_ALL=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# ==========================================
# Path Configuration - Organized by Priority
# ==========================================
# Initialize path array for clean management
typeset -U path  # Keep unique entries

# Local binaries (highest priority)
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  $path
)

# Homebrew (macOS specific)
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Apple Silicon
  if [[ -d "/opt/homebrew" ]]; then
    path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  # Intel
  if [[ -d "/usr/local/opt" ]]; then
    path=("/usr/local/opt/openssl/bin" $path)
  fi
fi

# System paths
path=($path "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin")

export PATH

# ==========================================
# Node.js / NVM Configuration
# ==========================================
export NVM_DIR="$HOME/.nvm"

# Lazy load NVM for faster shell startup
load_nvm() {
  if [ -z "$NVM_LOADED" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
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

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
path=("$PNPM_HOME" $path)

# Yarn
path=("$HOME/.yarn/bin" "$HOME/.config/yarn/global/node_modules/.bin" $path)

# Bun (fast JS runtime)
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# ==========================================
# Python Configuration
# ==========================================
# uv (fast Python package installer and resolver)
if command -v uv &> /dev/null; then
  # uv is installed, no special setup needed
  alias pip='uv pip'
  alias pipi='uv pip install'
  alias pipir='uv pip install -r requirements.txt'
  alias pipf='uv pip freeze > requirements.txt'
fi

# pyenv (if installed)
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  path=("$PYENV_ROOT/bin" $path)
  if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    # pyenv-virtualenv
    if command -v pyenv-virtualenv-init &> /dev/null; then
      eval "$(pyenv virtualenv-init -)"
    fi
  fi
fi

# Poetry
export POETRY_HOME="$HOME/.poetry"
if [ -d "$POETRY_HOME" ]; then
  path=("$POETRY_HOME/bin" $path)
fi

# PDM (modern Python package manager)
export PDM_HOME="$HOME/.local/share/pdm"
if [ -d "$PDM_HOME" ]; then
  path=("$PDM_HOME/bin" $path)
fi

# ==========================================
# Go Configuration
# ==========================================
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
path=("$GOBIN" "/usr/local/go/bin" $path)

# ==========================================
# Rust Configuration
# ==========================================
path=("$HOME/.cargo/bin" $path)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ==========================================
# Deno Configuration
# ==========================================
export DENO_INSTALL="$HOME/.deno"
path=("$DENO_INSTALL/bin" $path)

# ==========================================
# Docker Configuration (OrbStack / Docker Desktop)
# ==========================================
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_DEFAULT_PLATFORM="linux/amd64"  # Useful for M1/M2 Macs

# OrbStack specific
if [ -d "$HOME/.orbstack" ]; then
  # OrbStack is installed
  export ORBSTACK_HOME="$HOME/.orbstack"
fi

# ==========================================
# Database Configuration
# ==========================================
# PostgreSQL
if [[ -d "/usr/local/opt/postgresql@15/bin" ]]; then
  path=("/usr/local/opt/postgresql@15/bin" $path)
fi
if [[ -d "/opt/homebrew/opt/postgresql@15/bin" ]]; then
  path=("/opt/homebrew/opt/postgresql@15/bin" $path)
fi
export PGDATA="$HOME/.postgres/data"

# MySQL
if [[ -d "/usr/local/opt/mysql/bin" ]]; then
  path=("/usr/local/opt/mysql/bin" $path)
fi

# Redis
export REDIS_HOST="localhost"
export REDIS_PORT="6379"

# ==========================================
# Cloud Provider CLI
# ==========================================
# AWS
export AWS_PAGER=""
export SAM_CLI_TELEMETRY=0

# Google Cloud
if [[ -d "$HOME/google-cloud-sdk" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# ==========================================
# Development Environment Variables
# ==========================================
# Enable color output
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS='di=1;36:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34;43'

# Less configuration (better paging)
export LESS='-R -F -X -i -M -w'
export LESSHISTFILE='-'

# FZF default options
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border=rounded
  --preview-window=right:60%:wrap
  --bind=ctrl-u:preview-page-up,ctrl-d:preview-page-down
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
'

# Ripgrep configuration
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Bat (better cat) theme
export BAT_THEME="Catppuccin-mocha"

# ==========================================
# History Configuration
# ==========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY          # Record timestamp of command
setopt HIST_EXPIRE_DUPS_FIRST    # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS          # Ignore duplicated commands history list
setopt HIST_IGNORE_SPACE         # Ignore commands that start with space
setopt HIST_VERIFY               # Show command with history expansion before running it
setopt SHARE_HISTORY             # Share command history data
setopt INC_APPEND_HISTORY        # Add commands immediately

# ==========================================
# ZSH Options
# ==========================================
setopt AUTO_CD                   # Change directory without cd
setopt AUTO_PUSHD                # Push old directory onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates
setopt PUSHD_MINUS               # Swap + and - for directory stack
setopt CORRECT                   # Spelling correction for commands
setopt GLOB_DOTS                 # Include dotfiles in globbing
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive mode

# ==========================================
# Development Aliases - Git
# ==========================================
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit -v -a'
alias gcam='git commit -a -m'
alias gcan='git commit --amend --no-edit'
alias gcaa='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout main 2>/dev/null || git checkout master'
alias gcd='git checkout develop'
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gl='git pull'
alias glr='git pull --rebase'
alias glg='git log --graph --oneline --decorate --all'
alias glo='git log --oneline'
alias glp='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gm='git merge'
alias gma='git merge --abort'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpu='git push -u origin HEAD'
alias gr='git remote'
alias grv='git remote -v'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grs='git restore'
alias grst='git restore --staged'
alias gs='git status'
alias gss='git status -s'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show'
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias gclean='git clean -fd'
alias greset='git reset --hard'
alias gundo='git reset --soft HEAD~1'

# ==========================================
# Development Aliases - Docker
# ==========================================
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcdv='docker-compose down -v'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dce='docker-compose exec'
alias dcb='docker-compose build'
alias dcbn='docker-compose build --no-cache'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dii='docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"'
alias drm='docker rm'
alias drmi='docker rmi'
alias drmf='docker rm -f'
alias dex='docker exec -it'
alias din='docker inspect'
alias dlog='docker logs'
alias dlogf='docker logs -f'
alias dprune='docker system prune -a --volumes -f'
alias dstop='docker stop $(docker ps -q)'
alias dkill='docker kill $(docker ps -q)'
alias dvol='docker volume ls'
alias dnet='docker network ls'
alias dstat='docker stats --no-stream'

# Docker build with BuildKit enhancements
alias dbuild='DOCKER_BUILDKIT=1 docker build'
alias dbuildnc='DOCKER_BUILDKIT=1 docker build --no-cache'

# Docker-compose v2 (new version)
alias dco='docker compose'
alias dcou='docker compose up'
alias dcoud='docker compose up -d'
alias dcod='docker compose down'

# ==========================================
# Development Aliases - Node.js & Package Managers
# ==========================================
# NPM
alias ni='npm install'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
alias nrl='npm run lint'
alias nrw='npm run watch'
alias ns='npm start'
alias nt='npm test'
alias nls='npm list --depth=0'
alias nout='npm outdated'
alias nup='npm update'
alias nci='npm ci'  # Clean install from package-lock.json
alias ncache='npm cache clean --force'

# Yarn
alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yag='yarn global add'
alias yr='yarn run'
alias ys='yarn start'
alias yd='yarn dev'
alias yb='yarn build'
alias yt='yarn test'
alias yl='yarn lint'
alias yw='yarn watch'
alias yout='yarn outdated'
alias yup='yarn upgrade'
alias yupint='yarn upgrade-interactive'

# pnpm
alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pag='pnpm add -g'
alias pr='pnpm run'
alias ps='pnpm start'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'
alias pl='pnpm lint'
alias pup='pnpm update'
alias pout='pnpm outdated'

# Bun
alias bi='bun install'
alias ba='bun add'
alias bad='bun add -d'
alias br='bun run'
alias bx='bunx'
alias bt='bun test'

# Node version management
alias nv='node -v'
alias nvuse='nvm use'
alias nvls='nvm ls'
alias nvlsr='nvm ls-remote'

# ==========================================
# Development Aliases - Python & Django
# ==========================================
alias py='python3'
alias py2='python2'
alias ipy='ipython'

# Virtual environments
alias venv='python3 -m venv'
alias vact='source venv/bin/activate'
alias vdeact='deactivate'
alias venvnew='python3 -m venv venv && source venv/bin/activate'

# uv (if not aliased in Python config section)
if command -v uv &> /dev/null && ! alias pip &> /dev/null; then
  alias pip='uv pip'
fi

# pip commands (work with both pip3 and uv pip)
alias pipi='pip install'
alias pipir='pip install -r requirements.txt'
alias pipf='pip freeze > requirements.txt'
alias pipu='pip install --upgrade'
alias pipup='pip list --outdated'
alias pipun='pip uninstall'

# Django
alias dj='python manage.py'
alias djr='python manage.py runserver'
alias djr0='python manage.py runserver 0.0.0.0:8000'
alias djm='python manage.py migrate'
alias djmm='python manage.py makemigrations'
alias djmmm='python manage.py makemigrations && python manage.py migrate'
alias djs='python manage.py shell'
alias djsp='python manage.py shell_plus'
alias djt='python manage.py test'
alias djc='python manage.py collectstatic --noinput'
alias djsu='python manage.py createsuperuser'
alias djshow='python manage.py showmigrations'
alias djsql='python manage.py sqlmigrate'
alias djcheck='python manage.py check'
alias djflush='python manage.py flush'

# Flask
alias fr='flask run'
alias frd='flask run --debug'
alias fs='flask shell'

# Poetry
alias po='poetry'
alias poi='poetry install'
alias poa='poetry add'
alias poad='poetry add --group dev'
alias por='poetry remove'
alias pou='poetry update'
alias pos='poetry shell'
alias porun='poetry run'
alias poshow='poetry show'

# pytest
alias pyt='pytest'
alias pytv='pytest -v'
alias pytc='pytest --cov'
alias pytw='pytest --watch'

# ==========================================
# Development Aliases - General & System
# ==========================================
# Editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias nv='nvim'
alias code='code .'

# Navigation
alias c='clear'
alias h='history'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -ltrh'  # Sort by time
alias lsize='ls -lSrh'  # Sort by size
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Directory shortcuts
alias dev='cd ~/Developer'
alias proj='cd ~/Projects'
alias dots='cd ~/dotfiles'
alias dl='cd ~/Downloads'
alias doc='cd ~/Documents'

# File operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias rmdir='rm -rf'

# Search
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rg='rg --smart-case --hidden'

# Process management
alias psa='ps aux | grep'
alias k9='kill -9'
alias kp='killall -9'

# Network
alias ports='lsof -i -P -n | grep LISTEN'
alias myip='curl -s http://ipecho.net/plain; echo'
alias localip='ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1'
alias openports='sudo lsof -i -P | grep LISTEN'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# System
alias update='brew update && brew upgrade && brew cleanup'
alias brewup='brew update && brew upgrade && brew cleanup && brew doctor'
alias zshconfig='nvim ~/.zshrc'
alias reload='source ~/.zshrc && echo "✅ Zsh config reloaded"'
alias path='echo -e ${PATH//:/\\n}'
alias envs='printenv | sort'

# Disk usage
alias df='df -h'
alias du='du -h -d 1'
alias ducks='du -cks * | sort -rn | head'

# Git repos quick status
alias gstall='find . -maxdepth 1 -type d -exec sh -c "(cd {} && git status -s 2>/dev/null && echo {})" \;'

# JSON/YAML tools
alias json='python3 -m json.tool'
alias yaml2json='python3 -c "import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout, indent=2)"'

# HTTP requests
alias weather='curl wttr.in'
alias ipinfo='curl ipinfo.io'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kex='kubectl exec -it'
alias kctx='kubectl config current-context'
alias kns='kubectl config set-context --current --namespace'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'

# ==========================================
# Custom Functions for Fullstack Development
# ==========================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive type
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
  find . -type f -iname "*$1*" 2>/dev/null
}

# Find directory by name
fdir() {
  find . -type d -iname "*$1*" 2>/dev/null
}

# Git clone and cd
gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Quick project initialization
# Create React App with TypeScript
cra() {
  npx create-react-app "$1" --template typescript && cd "$1"
}

# Create Next.js App
cnext() {
  npx create-next-app@latest "$1" --typescript --tailwind --app && cd "$1"
}

# Create Vite App
cvite() {
  npm create vite@latest "$1" && cd "$1"
}

# Create T3 App (Next.js + tRPC + Prisma + Tailwind)
ct3() {
  npm create t3-app@latest "$1" && cd "$1"
}

# Django start project
djstart() {
  django-admin startproject "$1" && cd "$1"
  python manage.py startapp core
}

# FastAPI project starter
fapistart() {
  mkdir -p "$1" && cd "$1"
  python3 -m venv venv
  source venv/bin/activate
  pip install fastapi uvicorn[standard] python-dotenv
  cat > main.py << 'EOF'
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}
EOF
  echo "✅ FastAPI project created! Run: uvicorn main:app --reload"
}

# Quick HTTP server
serve() {
  local port="${1:-8000}"
  echo "🌐 Starting HTTP server on port $port..."
  python3 -m http.server "$port"
}

# Docker cleanup functions
dclean() {
  echo "🧹 Cleaning up Docker resources..."
  docker stop $(docker ps -aq) 2>/dev/null
  docker rm $(docker ps -aq) 2>/dev/null
  docker rmi $(docker images -q) 2>/dev/null
  docker volume rm $(docker volume ls -q) 2>/dev/null
  docker network prune -f
  echo "✅ Docker cleanup complete"
}

# Clean unused Docker images only
dcleanimg() {
  docker image prune -a -f
}

# Kill process on specific port
killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port>"
    return 1
  fi
  local pid=$(lsof -ti:"$1")
  if [ -n "$pid" ]; then
    kill -9 "$pid"
    echo "✅ Killed process on port $1 (PID: $pid)"
  else
    echo "❌ No process found on port $1"
  fi
}

# Git commit with timestamp
gct() {
  git add -A && git commit -m "$1 [$(date +'%Y-%m-%d %H:%M:%S')]"
}

# Quick git push
qpush() {
  git add -A && git commit -m "${1:-quick update}" && git push
}

# Create and checkout new branch from main/master
gnew() {
  local main_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  [ -z "$main_branch" ] && main_branch="main"
  git checkout "$main_branch" && git pull && git checkout -b "$1"
}

# Project structure viewer
tree() {
  if command -v tree &> /dev/null; then
    command tree -I 'node_modules|venv|__pycache__|.git|dist|build' "$@"
  else
    find . -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/venv/*' | sed 's|[^/]*/| |g'
  fi
}

# Database connection helpers
pgconnect() {
  psql postgresql://localhost:5432/$1
}

mongoconnect() {
  mongosh "mongodb://localhost:27017/$1"
}

redisconnect() {
  redis-cli
}

# Docker shell shortcuts
dsh() {
  docker exec -it "$1" /bin/bash 2>/dev/null || docker exec -it "$1" /bin/sh
}

dcsh() {
  docker-compose exec "$1" /bin/bash 2>/dev/null || docker-compose exec "$1" /bin/sh
}

# Development environment setup
devsetup() {
  echo "🚀 Checking development environment..."
  echo ""
  
  # Check and show versions for tools
  echo "Core Tools:"
  if command -v git &> /dev/null; then
    echo "  ✅ Git: $(git --version | cut -d' ' -f3)"
  else
    echo "  ❌ Git: not installed"
  fi
  
  if command -v nvim &> /dev/null; then
    echo "  ✅ Neovim: $(nvim --version 2>/dev/null | head -n1 | cut -d' ' -f2)"
  else
    echo "  ❌ Neovim: not installed"
  fi
  
  echo ""
  echo "JavaScript/Node.js:"
  # Load nvm if not loaded
  if [ -z "$NVM_LOADED" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    load_nvm
  fi
  
  if command -v node &> /dev/null; then
    echo "  ✅ Node.js: $(node --version)"
    echo "  ✅ npm: $(npm --version)"
  else
    echo "  ❌ Node.js: not installed (install via nvm)"
  fi
  
  if command -v bun &> /dev/null; then
    echo "  ✅ Bun: $(bun --version)"
  fi
  
  echo ""
  echo "Python:"
  if command -v python3 &> /dev/null; then
    echo "  ✅ Python: $(python3 --version | cut -d' ' -f2)"
  else
    echo "  ❌ Python: not installed"
  fi
  
  if command -v uv &> /dev/null; then
    echo "  ✅ uv: $(uv --version | cut -d' ' -f2)"
  fi
  
  if command -v pip3 &> /dev/null; then
    echo "  ✅ pip: $(pip3 --version | cut -d' ' -f2)"
  fi
  
  echo ""
  echo "Containers:"
  if command -v docker &> /dev/null; then
    local docker_version=$(docker --version 2>/dev/null | cut -d' ' -f3 | tr -d ',')
    if [ -d "$HOME/.orbstack" ]; then
      echo "  ✅ Docker (OrbStack): $docker_version"
    else
      echo "  ✅ Docker: $docker_version"
    fi
  else
    echo "  ❌ Docker: not installed"
  fi
  
  if command -v kubectl &> /dev/null; then
    echo "  ✅ kubectl: $(kubectl version --client -o json 2>/dev/null | grep -o '"gitVersion":"[^"]*' | cut -d'"' -f4)"
  fi
  
  echo ""
  echo "💡 All checks complete!"
}

# Quick package.json script viewer
npmscripts() {
  if [ -f package.json ]; then
    cat package.json | jq -r '.scripts | to_entries[] | "\(.key): \(.value)"'
  else
    echo "❌ No package.json found in current directory"
  fi
}

# Quick requirements.txt generator from imports
pyrequirements() {
  pip freeze | grep -v "^-e" | sort > requirements.txt
  echo "✅ requirements.txt generated"
}

# ==========================================
# FZF Configuration (Fuzzy Finder)
# ==========================================
if command -v fzf &> /dev/null; then
  # Load FZF
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
  
  # Enhanced file preview with bat
  if command -v bat &> /dev/null; then
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
  else
    export FZF_CTRL_T_OPTS="--preview 'head -100 {}'"
  fi
  
  # Enhanced directory preview with tree or exa
  if command -v exa &> /dev/null; then
    export FZF_ALT_C_OPTS="--preview 'exa --tree --level=2 --color=always {}'"
  elif command -v tree &> /dev/null; then
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
  fi
fi

# ==========================================
# Zoxide (Better cd)
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
# Additional Plugin Sources
# ==========================================
# zsh-autosuggestions
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Configure autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c7086'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# zsh-syntax-highlighting (must be last)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ==========================================
# Completion System
# ==========================================
# Load and initialize completion system
autoload -Uz compinit
# Only update compinit once a day for faster startup
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# ==========================================
# Welcome Message & System Info
# ==========================================
echo ""
echo "╔═══════════════════════════════════════════════╗"
echo "║   🚀 Fullstack Development Environment       ║"
echo "╚═══════════════════════════════════════════════╝"
echo ""

# Display version info for key tools (safe version)
_print_version() {
  local tool=$1
  local display_name=$2
  if command -v "$tool" &> /dev/null; then
    printf "  ✓ %-12s installed\n" "$display_name"
  fi
}

_print_version "node" "Node.js"
_print_version "npm" "npm"
_print_version "python3" "Python"
_print_version "uv" "uv"
_print_version "docker" "Docker/OrbStack"
_print_version "kubectl" "kubectl"
_print_version "nvim" "Neovim"

echo ""
echo "💡 Type 'devsetup' to check versions and details"
echo "📖 Config: ~/.zshrc | Reload: 'reload'"
echo ""

# ==========================================
# Local Customizations
# ==========================================
# Source local zshrc for machine-specific settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ==========================================
# Performance Profiling (uncomment to debug)
# ==========================================
# zprof
