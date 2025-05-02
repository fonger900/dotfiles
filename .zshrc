export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git z)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
export PATH="$HOME/.local/bin:$PATH"
alias vim="nvim"
alias ll="exa -l --git"

