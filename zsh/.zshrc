# Start timer
zmodload zsh/datetime
typeset -F _zsh_start_time=$EPOCHREALTIME

# Optional: Enable profiling (uncomment to debug slow startup)
# zmodload zsh/zprof

# 1. Fastfetch (Only on interactive shell startup)
if [[ -o interactive ]] && command -v fastfetch &> /dev/null; then
  fastfetch
fi

# Load zsh-defer (Fast startup)
if [ -f "$HOME/zsh-defer/zsh-defer.plugin.zsh" ]; then
  source "$HOME/zsh-defer/zsh-defer.plugin.zsh"
else
  zsh-defer() { "$@"; }
fi

# ==========================================
# Performance-Optimized ZSH Configuration
# ==========================================
# Determine Dotfiles location (default to current if not set)
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# 1. Path Configuration
[ -f "$DOTFILES/zsh/path.zsh" ] && source "$DOTFILES/zsh/path.zsh"

# 2. Manual Oh-My-Zsh Setup
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled
: ${ZSH_CACHE_DIR:=$ZSH/cache}

# Completion Initialization (Required before plugins)
_init_completion() {
  autoload -Uz compinit
  if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}
_init_completion

# Load OMZ Libs
for config_file ($ZSH/lib/*.zsh); do
  source "$config_file"
done

# Plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -f "$ZSH/plugins/git/git.plugin.zsh" ] && source "$ZSH/plugins/git/git.plugin.zsh"

# Async Autosuggestions
if [ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  export ZSH_AUTOSUGGEST_USE_ASYNC=1
  export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
  source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# 3. Tool Initializations (Optimized)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Mise (Fast activation using shims)
if [ -f "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate zsh --shims)"
fi

# 4. Deferred Loading (Non-critical)
zsh-defer source "$DOTFILES/zsh/exports.zsh"
zsh-defer source "$DOTFILES/zsh/aliases.zsh"

_load_plugins_deferred() {
  [ -f "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh" ] && \
    source "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh"
    
  local SH_PATHS=(
    "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  )
  for sh_path in "${SH_PATHS[@]}"; do
    if [ -f "$sh_path" ]; then
      source "$sh_path"
      break
    fi
  done
}
zsh-defer _load_plugins_deferred

# 6. Local Customizations
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Display startup time
typeset -F _zsh_duration=$(( EPOCHREALTIME - _zsh_start_time ))
printf "\n\033[1;90mStartup: %.3fs\033[0m\n" $_zsh_duration

# Drain terminal responses
while read -sk -t 0.01; do :; done

# End profiling if enabled
# zprof
