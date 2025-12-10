# ==========================================
# Optimized Zsh Profile (Login Shell)
# ==========================================

# 1. Homebrew (Static load is faster than 'eval brew shellenv')
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"

# 2. OrbStack (Keep as is, usually fast enough, or check if lazy loadable)
[ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# 3. Swiftly
[ -f "$HOME/.swiftly/env.sh" ] && . "$HOME/.swiftly/env.sh"

# 4. NVM (Lazy Load)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
lazy_load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  "$0" "$@"
}
# Define aliases to trigger the load
alias nvm="lazy_load_nvm nvm"
alias node="lazy_load_nvm node"
alias npm="lazy_load_nvm npm"
alias npx="lazy_load_nvm npx"

# 5. rbenv (Lazy Load)
lazy_load_rbenv() {
  eval "$(rbenv init - --no-rehash zsh)"
  # Restore the function mapping to the command
  unfunction rbenv
  rbenv "$@"
}
# Only alias if rbenv is available
if command -v rbenv > /dev/null; then
  alias rbenv="lazy_load_rbenv"
fi

# Kiro CLI (Keep these preserved)
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
