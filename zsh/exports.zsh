# ==========================================
# Environment Variables
# ==========================================
# Only set TERM if it's not set by the terminal emulator
export TERM="${TERM:-xterm-256color}"
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DOTFILES="$HOME/.dotfiles"

# FZF Configuration
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if command -v bat &> /dev/null; then
  export BAT_THEME="Catppuccin Mocha"
  export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
fi

# FZF Catppuccin Mocha Colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# History Configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
# shellcheck disable=SC2034
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

# Forces Chrome and Electron apps to use the Secret Service (provided by KeePassXC) for password storage
# Note: Ensure KeePassXC -> Settings -> Browser Integration -> Enable Secret Service is checked.
export CHROME_CONFIG_FLAGS="--password-store=gnome"
export ELECTRON_PASSWORD_STORE="gnome"
export MOZ_ENABLE_WAYLAND=1

# Scaling — increase if UI elements appear too small
export GDK_SCALE=1
export GDK_DPI_SCALE=1.25
export QT_SCALE_FACTOR=1.25
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export XCURSOR_SIZE=28

# XDG Data Directories — include system defaults first, then Flatpak
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:/usr/local/share:/usr/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share"
