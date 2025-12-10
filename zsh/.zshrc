# Start timer & Loading indicator
zmodload zsh/datetime
typeset -F _zsh_start_time=$EPOCHREALTIME
echo -ne " \033[1;33m●\033[0m Loading..."

source ~/zsh-defer/zsh-defer.plugin.zsh


# ==========================================
# Performance-Optimized ZSH Configuration
# ==========================================
export DOTFILES="$HOME/dotfiles"

# 1. Path Configuration (Load first)
[ -f "$DOTFILES/zsh/path.zsh" ] && source "$DOTFILES/zsh/path.zsh"

# 2. Manual Oh-My-Zsh Setup (Optimized)
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled
plugins=(git docker)

# Define Cache Dir (Required by some OMZ libs)
: ${ZSH_CACHE_DIR:=$ZSH/cache}

# Load OMZ Libs (Manual source to bypass synchronous compinit)
for config_file ($ZSH/lib/*.zsh); do
  source "$config_file"
done

# Load Plugins explicitly
if [ -f "$ZSH/plugins/git/git.plugin.zsh" ]; then
  source "$ZSH/plugins/git/git.plugin.zsh"
fi
if [ -f "$ZSH/plugins/docker/docker.plugin.zsh" ]; then
  source "$ZSH/plugins/docker/docker.plugin.zsh"
fi

# 3. Exports & Options
[ -f "$DOTFILES/zsh/exports.zsh" ] && source "$DOTFILES/zsh/exports.zsh"

# 4. Aliases
[ -f "$DOTFILES/zsh/aliases.zsh" ] && source "$DOTFILES/zsh/aliases.zsh"

# 5. Lazy-loaded Tool Initializations

# Lazy load zoxide
_zoxide_init() {
  eval "$(zoxide init zsh --cmd cd)"
  unfunction _zoxide_init
}
alias cd='_zoxide_init && cd'

# Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Defer syntax highlighting to end
_load_syntax_highlighting() {
  if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
}
zsh-defer _load_syntax_highlighting

# Optimized completion (Deferred)
_init_completion() {
  autoload -Uz compinit
  # Only regenerate compdump once per day
  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}
zsh-defer _init_completion

# Lazy load mise
_mise_init() {
  eval "$(~/.local/bin/mise activate zsh)"
  unfunction _mise_init
}
alias mise='_mise_init && mise'

# pnpm (optimized)
export PNPM_HOME="/Users/fonger/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# LM Studio
export PATH="$PATH:/Users/fonger/.lmstudio/bin"

# 6. Local Customizations
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Clear loading indicator
echo -ne "\r\033[K"

# Fastfetch
if command -v fastfetch &> /dev/null; then
  fastfetch
fi

# Display startup time
typeset -F _zsh_duration=$(( EPOCHREALTIME - _zsh_start_time ))
printf "\n\033[1;90mStartup: %.3fs\033[0m\n" $_zsh_duration

