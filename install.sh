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

check_prerequisites() {
  log_step "Checking prerequisites..."

  # OS Check
  if [[ "$OSTYPE" != "darwin"* ]]; then
    log_warn "This script is optimized for macOS. Some steps may fail on Linux."
  fi

  # Homebrew Check
  if ! command -v brew &>/dev/null; then
    log_warn "Homebrew not found."
    if confirm "Install Homebrew?"; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      log_error "Homebrew is required for most tools. Proceeding anyway..."
    fi
  fi

  # Core tools
  local missing=()
  for tool in git stow zsh; do
    if ! command -v "$tool" &>/dev/null; then
      missing+=("$tool")
    fi
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    log_info "Installing missing core tools: ${missing[*]}"
    if command -v brew &>/dev/null; then
      brew install "${missing[@]}"
    else
      log_error "Please install ${missing[*]} manually and restart."
      exit 1
    fi
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
