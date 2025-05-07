
#---------------------------------------------------------
#  Shadow Gardener – .zshrc (v5, dedupe fix)
#---------------------------------------------------------

## 0. Avoid duplicate PATH natively (zsh feature)
# this must be placed before we start appending paths
setopt PATH_DIRS         # let zsh find binaries in $path
setopt AUTO_PARAM_KEYS   # nicer completions
typeset -U path          # UNIQUE the $path array automatically

## 1. Oh‑My‑Zsh core
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git z fzf sudo colored-man-pages extract zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

## 2. PATH helpers
pathprepend() { [[ :$PATH: != *:"$1":* ]] && PATH="$1:$PATH"; }

pathprepend "$HOME/system/bin"
pathprepend "$HOME/.local/bin"

## Bun runtime ----------------------------------------------------
export BUN_INSTALL="$HOME/.bun"
pathprepend "$BUN_INSTALL/bin"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

## 3. Aliases -----------------------------------------------------
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"

alias ..="cd .."
alias ...="cd ../.."

alias gs="git status"
alias ga="git add"
alias gc="git commit -v"
alias gp="git push"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias vim="nvim"
alias cat="bat --theme Dracula"

alias gtree="cd ~/garden/trees"
alias wnote="cd ~/work/notes"

## 4. Prompt ------------------------------------------------------
eval "$(starship init zsh)"

## 5. FZF ---------------------------------------------------------
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

## 6. Environment -------------------------------------------------
export EDITOR="nvim"
export LESS="-R"
export LANG="en_US.UTF-8"

## 7. Functions ---------------------------------------------------
mkcd() { mkdir -p "$1" && cd "$1"; }
extract() {
  case "$1" in
    *.tar.bz2) tar xjf "$1";;
    *.tar.gz)  tar xzf "$1";;
    *.zip)     unzip "$1";;
    *.rar)     unrar x "$1";;
    *)         echo "Cannot extract '$1'";;
  esac }

## 8. Local overrides --------------------------------------------
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

#---------------------------------------------------------
# End of .zshrc v5
#---------------------------------------------------------
