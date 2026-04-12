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
# shellcheck disable=SC1090,SC2015
[ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# 3. Swiftly
# shellcheck disable=SC1091
[ -f "$HOME/.swiftly/env.sh" ] && . "$HOME/.swiftly/env.sh"

# 4. Auto-launch Sway on TTY1
# Start Sway automatically after login on TTY1 if not already in a session
if [[ -z $DISPLAY ]] && [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    # Ensure environment is clean for Wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland
    
    # Optional: Start sway with dbus-run-session if needed
    # exec dbus-run-session sway
    exec sway
fi

