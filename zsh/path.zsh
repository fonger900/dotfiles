# ==========================================
# Path Configuration
# ==========================================
# Use typeset to ensure unique paths
typeset -U path

# Base paths (Prepend)
path=(
  "$DOTFILES/scripts"
  "$HOME/.local/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "${path[@]}"
)

# Language toolchains
export GOPATH="$HOME/go"

path=(
  "$HOME/.cargo/bin"      # Rust
  "$HOME/.bun/bin"        # Bun
  "$GOPATH/bin"           # Go
  "${path[@]}"
)

# App Specific (Append via $path inclusion or just add to list)
# Note: In zsh, assigning to path array automatically updates PATH env var
path=(
  "${path[@]}"
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/.lmstudio/bin"
  "$HOME/.local/share/pnpm"
)

# Platform-specific paths
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  path=(
    "${path[@]}"
    "$HOME/Library/Android/sdk/platform-tools"
    "$HOME/Library/Android/sdk/tools"
    "$HOME/Library/Application Support/Herd/bin/"
  )
  export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  path=(
    "${path[@]}"
    "$HOME/Android/Sdk/platform-tools"
    "$HOME/Android/Sdk/tools"
    "$HOME/.local/bin"
  )
fi

export PNPM_HOME="$HOME/.local/share/pnpm"


# ==========================================
# WSL Path Optimization
# ==========================================
# Filtering Windows paths (excluding critical ones like code, wsl, clip) to fix severe prompt latency
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  new_path=()
  for p in "${path[@]}"; do
    if [[ "$p" != /mnt/c/* ]] || [[ "$p" == *System32* ]] || [[ "$p" == *"VS Code/bin"* ]] || [[ "$p" == *"VSCode"* ]] || [[ "$p" == *WezTerm* ]] || [[ "$p" == *chrome* ]]; then
      new_path+=("$p")
    fi
  done
  path=("${new_path[@]}")
  unset new_path
fi

export PATH
