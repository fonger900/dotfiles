zmodload zsh/datetime

echo "Starting profile..."

t1=$EPOCHREALTIME
source ~/dotfiles/zsh/path.zsh
t2=$EPOCHREALTIME
printf "Path: %.3fs\n" $(( t2 - t1 ))

export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled
plugins=(git)
command -v docker &> /dev/null && plugins+=(docker)
source "$ZSH/oh-my-zsh.sh"
t3=$EPOCHREALTIME
printf "OMZ: %.3fs\n" $(( t3 - t2 ))

source ~/dotfiles/zsh/exports.zsh
t4=$EPOCHREALTIME
printf "Exports: %.3fs\n" $(( t4 - t3 ))

source ~/dotfiles/zsh/aliases.zsh
t5=$EPOCHREALTIME
printf "Aliases: %.3fs\n" $(( t5 - t4 ))

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
t6=$EPOCHREALTIME
printf "Starship: %.3fs\n" $(( t6 - t5 ))

if command -v fastfetch &> /dev/null; then
  fastfetch > /dev/null
fi
t7=$EPOCHREALTIME
printf "Fastfetch: %.3fs\n" $(( t7 - t6 ))
