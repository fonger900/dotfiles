# ==========================================
# Path Configuration
# ==========================================
# Use typeset to ensure unique paths
typeset -U path

# Base paths (Prepend)
path=(
  "$DOTFILES/scripts"
  "$HOME/.local/bin"
  $path
)

# Language toolchains
export GOPATH="$HOME/go"

path=(
  "$HOME/.cargo/bin"      # Rust
  "$HOME/.bun/bin"        # Bun
  "$GOPATH/bin"           # Go
  $path
)

# App Specific (Append via $path inclusion or just add to list)
# Note: In zsh, assigning to path array automatically updates PATH env var
path=(
  $path
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/.lmstudio/bin"
  "$HOME/Library/Android/sdk/platform-tools"
  "$HOME/Library/Android/sdk/tools"
  "$HOME/.local/share/pnpm"
  "$HOME/Library/Application Support/Herd/bin/"
)

export PNPM_HOME="$HOME/.local/share/pnpm"
export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"

export PATH
