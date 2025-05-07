export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git z)

source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias ll="ls -la"
alias gs="git status"
alias vim="nvim"
alias cat="bat"

# bun completions
[ -s "/Users/fonger/.bun/_bun" ] && source "/Users/fonger/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init zsh)"
export PATH=$HOME/system/bin:$PATH
