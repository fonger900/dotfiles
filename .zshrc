
setopt PATH_DIRS         # let zsh find binaries in $path
setopt AUTO_PARAM_KEYS   # nicer completions
typeset -U path          # UNIQUE the $path array automatically

## 1. Oh‑My‑Zsh core
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git z fzf sudo colored-man-pages extract zsh-autosuggestions zsh-syntax-highlighting npm yarn docker docker-compose node)
source "$ZSH/oh-my-zsh.sh"

## 2. PATH helpers
pathprepend() { [[ :$PATH: != *:"$1":* ]] && PATH="$1:$PATH"; }

pathprepend "$HOME/system/bin"
pathprepend "$HOME/.local/bin"

## Node.js Version Management -----------------------------------
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

## Yarn global bin -----------------------------------------------
pathprepend "$HOME/.yarn/bin"
pathprepend "$HOME/.config/yarn/global/node_modules/.bin"

## Bun runtime ----------------------------------------------------
export BUN_INSTALL="$HOME/.bun"
pathprepend "$BUN_INSTALL/bin"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

## 3. Aliases -----------------------------------------------------
# Basic system
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"

alias ..="cd .."
alias ...="cd ../.."

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit -v"
alias gp="git push"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"
alias gb="git branch"
alias gf="git fetch"
alias gpl="git pull"
alias gcb="git checkout -b"
alias gst="git stash"
alias gstp="git stash pop"

# Safety nets
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Editor and tools
alias vim="nvim"
alias cat="bat --theme Dracula"

# Docker shortcuts
alias d="docker"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcb="docker-compose build"
alias dps="docker ps"
alias di="docker images"
alias dex="docker exec -it"
alias dlogs="docker logs -f"
alias dprune="docker system prune -af"

# NPM/Yarn shortcuts
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
alias nd="npm run dev"
alias nw="npm run watch"

alias yi="yarn install"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yag="yarn global add"
alias yr="yarn run"
alias ys="yarn start"
alias yt="yarn test"
alias yb="yarn build"
alias yd="yarn dev"
alias yw="yarn watch"

# pnpm shortcuts
alias pi="pnpm install"
alias pa="pnpm add"
alias pad="pnpm add -D"
alias pag="pnpm add -g"
alias pr="pnpm run"
alias ps="pnpm start"
alias pt="pnpm test"
alias pb="pnpm build"
alias pd="pnpm dev"
alias pw="pnpm watch"

# Development servers
alias serve="python3 -m http.server"
alias ports="lsof -i -P -n | grep LISTEN"

# Project navigation
alias gtree="cd ~/garden/trees"
alias wnote="cd ~/work/notes"
alias proj="cd ~/projects"
alias work="cd ~/work"

## 4. Prompt ------------------------------------------------------
eval "$(starship init zsh)"

## 5. FZF ---------------------------------------------------------
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

## 6. Environment -------------------------------------------------
export EDITOR="nvim"
export LESS="-R"
export LANG="en_US.UTF-8"

# Development environment variables
export NODE_ENV="development"
export BROWSER="open"
export TERM="xterm-256color"

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Performance
export NODE_OPTIONS="--max-old-space-size=8192"

## 7. Functions ---------------------------------------------------
# Directory creation and navigation
mkcd() { mkdir -p "$1" && cd "$1"; }

# Archive extraction
extract() {
  case "$1" in
    *.tar.bz2) tar xjf "$1";;
    *.tar.gz)  tar xzf "$1";;
    *.zip)     unzip "$1";;
    *.rar)     unrar x "$1";;
    *)         echo "Cannot extract '$1'";;
  esac }

# Development project functions
newreact() {
  if [[ -z "$1" ]]; then
    echo "Usage: newreact <project-name>"
    return 1
  fi
  npx create-react-app "$1" && cd "$1"
}

newnext() {
  if [[ -z "$1" ]]; then
    echo "Usage: newnext <project-name>"
    return 1
  fi
  npx create-next-app@latest "$1" && cd "$1"
}

newvite() {
  if [[ -z "$1" ]]; then
    echo "Usage: newvite <project-name>"
    return 1
  fi
  npm create vite@latest "$1" && cd "$1"
}

# Git branch cleanup
gitclean() {
  git branch --merged | grep -v "\*\|main\|master\|develop" | xargs -n 1 git branch -d
}

# Find process using port
port() {
  if [[ -z "$1" ]]; then
    echo "Usage: port <port-number>"
    return 1
  fi
  lsof -ti:"$1"
}

# Kill process on port
killport() {
  if [[ -z "$1" ]]; then
    echo "Usage: killport <port-number>"
    return 1
  fi
  lsof -ti:"$1" | xargs kill -9
}

# Quick project setup
setupnode() {
  npm init -y
  echo "node_modules\n.env\n.DS_Store" > .gitignore
  git init
  echo "# ${PWD##*/}" > README.md
}

# Docker utilities
dcleanup() {
  docker container prune -f
  docker image prune -f
  docker volume prune -f
  docker network prune -f
}

# Search in files
search() {
  if [[ -z "$1" ]]; then
    echo "Usage: search <pattern> [directory]"
    return 1
  fi
  grep -r "$1" "${2:-.}" --exclude-dir=node_modules --exclude-dir=.git
}

## 8. Local overrides --------------------------------------------
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

#---------------------------------------------------------
# End of .zshrc v6 - Fullstack Development Edition
#---------------------------------------------------------

# pnpm
export PNPM_HOME="/Users/fonger/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Auto-switch node versions with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# FZF improvements for development
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always --style=numbers --line-range=:500 {}"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
