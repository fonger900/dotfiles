# ==========================================
# Environment Variables
# ==========================================
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# FZF Configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

# History Configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ZSH Options
setopt AUTO_CD
setopt CORRECT
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
