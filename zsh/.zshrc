# Start timer
zmodload zsh/datetime
typeset -F _zsh_start_time=$EPOCHREALTIME

# Load zsh-defer (Fast startup)
if [ -f "$HOME/zsh-defer/zsh-defer.plugin.zsh" ]; then
  source "$HOME/zsh-defer/zsh-defer.plugin.zsh"
else
  # Polyfill if missing
  zsh-defer() { "$@"; }
fi


# ==========================================
# Performance-Optimized ZSH Configuration
# ==========================================
export DOTFILES="$HOME/dotfiles"

# 1. Path Configuration (Load first)
[ -f "$DOTFILES/zsh/path.zsh" ] && source "$DOTFILES/zsh/path.zsh"

# 2. Manual Oh-My-Zsh Setup (Optimized)
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled

# Define Cache Dir (Required by some OMZ libs)
: ${ZSH_CACHE_DIR:=$ZSH/cache}

# Stub compdef to capture calls before compinit loads
typeset -a _comp_def_queue
compdef() {
  _comp_def_queue+=("$*")
}

# Load OMZ Libs (Manual source to bypass synchronous compinit)
for config_file ($ZSH/lib/*.zsh); do
  source "$config_file"
done

# Load Plugins explicitly
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ -f "$ZSH/plugins/git/git.plugin.zsh" ]; then
  source "$ZSH/plugins/git/git.plugin.zsh"
fi
if [ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh"
fi

# 3. Exports & Options
[ -f "$DOTFILES/zsh/exports.zsh" ] && source "$DOTFILES/zsh/exports.zsh"

# 4. Aliases
[ -f "$DOTFILES/zsh/aliases.zsh" ] && source "$DOTFILES/zsh/aliases.zsh"

# 5. Lazy-loaded Tool Initializations

# Zoxide (smart cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Defer syntax highlighting to end
_load_syntax_highlighting() {
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
zsh-defer _load_syntax_highlighting

# Optimized completion (Deferred)
_init_completion() {
  # Restore original compdef
  unfunction compdef
  autoload -Uz compinit
  
  # Only regenerate compdump once per day
  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
  
  # Replay captured compdef calls
  for cmd in "${_comp_def_queue[@]}"; do
    # split command into words safely
    eval "compdef $cmd"
  done
  unset _comp_def_queue
}
zsh-defer _init_completion

# Mise (Version Manager)
eval "$(~/.local/bin/mise activate zsh)"

# 6. Local Customizations
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Fastfetch
if command -v fastfetch &> /dev/null; then
  fastfetch
fi

# Display startup time
typeset -F _zsh_duration=$(( EPOCHREALTIME - _zsh_start_time ))
printf "\n\033[1;90mStartup: %.3fs\033[0m\n" $_zsh_duration

# Drain any terminal responses (like Device Attributes) that leaked into the buffer
while read -sk -t 0.01; do :; done

PATH="$PATH:/opt/nvim-linux-x86_64/bin"
