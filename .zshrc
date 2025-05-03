export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git z)

source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.local/bin:$PATH"
alias vim="nvim"
alias ll='ls -lAh --color=auto'

# bun completions
[ -s "/Users/fonger/.bun/_bun" ] && source "/Users/fonger/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init zsh)"
