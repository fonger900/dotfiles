#!/usr/bin/env bash
# ============================================================================
# 🚀 Fullstack Dev Dotfiles - Enhanced Installation Script
# ============================================================================
# This script automates the setup of the development environment using GNU Stow.
# It handles backups, prerequisites, and optional component installation.

set -euo pipefail

# ==========================================
# Configuration & Globals
# ==========================================

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false

STOW_PACKAGES=(
  "zsh"
  "tmux"
  "nvim"
  "wezterm"
  "ghostty"
  "starship"
  "ripgrep"
  "newsboat"
  "helix"
  "fastfetch"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# ==========================================
# UI Helpers
# ==========================================

print_header() {
  echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║   🚀 Fullstack Dev Dotfiles Installation     ║${NC}"
  echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
  echo ""
}

log_step() { echo -e "${BLUE}▶ $1${NC}"; }
log_success() { echo -e "${GREEN}✓ $1${NC}"; }
log_info() { echo -e "${PURPLE}ℹ $1${NC}"; }
log_warn() { echo -e "${YELLOW}⚠ $1${NC}"; }
log_error() { echo -e "${RED}✗ $1${NC}"; }

confirm() {
  read -p "$1 (y/n) " -n 1 -r
  echo ""
  [[ $REPLY =~ ^[Yy]$ ]]
}

# ==========================================
# Core Logic
# ==========================================

get_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif [[ -f /etc/os-release ]]; then
    echo "linux"
  else
    echo "unknown"
  fi
}

install_tool() {
  local tool=$1
  local os=$(get_os)

  if [[ "$os" == "macos" ]]; then
    brew install "$tool"
  elif [[ "$os" == "linux" ]]; then
    if command -v apt-get &>/dev/null; then
      sudo apt-get update && sudo apt-get install -y "$tool"
    elif command -v pacman &>/dev/null; then
      sudo pacman -Sy --noconfirm "$tool"
    elif command -v dnf &>/dev/null; then
      sudo dnf install -y "$tool"
    else
      log_error "Unsupported package manager. Please install $tool manually."
      return 1
    fi
  fi
}

check_prerequisites() {
  local os=$(get_os)
  log_step "Checking prerequisites for $os..."

  # Homebrew Check (Universal, but optional on Linux)
  if ! command -v brew &>/dev/null; then
    if [[ "$os" == "macos" ]]; then
      log_warn "Homebrew not found."
      if confirm "Install Homebrew?"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
    else
      log_info "Homebrew not found. Using system package manager instead."
    fi
  fi

  # Core tools
  local missing=()
  for tool in git stow zsh curl; do
    if ! command -v "$tool" &>/dev/null; then
      missing+=("$tool")
    fi
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    log_info "Installing missing core tools: ${missing[*]}"
    for tool in "${missing[@]}"; do
      install_tool "$tool"
    done
  fi
}

backup_conflicts() {
  local package=$1
  log_step "Backing up conflicts for $package..."

  # Run stow in simulation mode to find conflicts
  local conflicts
  conflicts=$(stow -nv -t "$HOME" -d "$DOTFILES_DIR" "$package" 2>&1 | grep "existing target is not owned by stow" | awk '{print $NF}' || true)

  if [[ -n "$conflicts" ]]; then
    mkdir -p "$BACKUP_DIR"
    while read -r file; do
      local target="$HOME/$file"
      if [[ -e "$target" || -L "$target" ]]; then
        log_info "Moving $target to $BACKUP_DIR/$file"
        mkdir -p "$(dirname "$BACKUP_DIR/$file")"
        mv "$target" "$BACKUP_DIR/$file"
      fi
    done <<< "$conflicts"
  fi
}

stow_packages() {
  log_step "Stowing configuration packages..."

  for pkg in "${STOW_PACKAGES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
      backup_conflicts "$pkg"
      if $DRY_RUN; then
        stow -nv -t "$HOME" -d "$DOTFILES_DIR" "$pkg"
        log_success "Simulated stow for $pkg"
      else
        stow -R -t "$HOME" -d "$DOTFILES_DIR" "$pkg"
        log_success "Stowed $pkg"
      fi
    else
      log_warn "Package directory $pkg not found, skipping."
    fi
  done
}

install_optional() {
  log_step "Checking optional components..."

  # Oh-My-Zsh
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    if confirm "Install Oh-My-Zsh?"; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
  fi

  # Zsh Plugins
  local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  local plugins=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "zsh-users/zsh-completions"
  )

  for plugin in "${plugins[@]}"; do
    local name=$(basename "$plugin")
    if [[ ! -d "$ZSH_CUSTOM/plugins/$name" ]]; then
      log_info "Installing $name..."
      git clone "https://github.com/$plugin" "$ZSH_CUSTOM/plugins/$name"
    fi
  done

  # zsh-defer (standalone)
  if [[ ! -d "$HOME/zsh-defer" ]]; then
    log_info "Installing zsh-defer..."
    git clone https://github.com/romkatv/zsh-defer "$HOME/zsh-defer"
  fi

  # Starship
  if ! command -v starship &>/dev/null; then
    if confirm "Install Starship prompt?"; then
      curl -sS https://starship.rs/install.sh | sh -s -- --yes
    fi
  fi

  # TPM
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    if confirm "Install Tmux Plugin Manager?"; then
      git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
  fi
}

# ==========================================
# Main Execution
# ==========================================

main() {
  # Parse flags
  while [[ $# -gt 0 ]]; do
    case $1 in
      --dry-run) DRY_RUN=true; shift ;;
      *) log_error "Unknown option: $1"; exit 1 ;;
    esac
  done

  print_header
  check_prerequisites
  stow_packages
  install_optional

  echo ""
  log_success "Installation Complete!"
  if [[ -d "$BACKUP_DIR" ]]; then
    log_info "Conflicts backed up to: $BACKUP_DIR"
  fi
  echo ""
  echo -e "${YELLOW}Next Steps:${NC}"
  echo "  1. Restart your terminal (exec zsh)"
  echo "  2. Open Tmux and press Prefix + I to install plugins"
  echo "  3. Explore documentation in the docs/ folder"
}

main "$@"
