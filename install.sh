#!/usr/bin/env bash
# ==========================================
# Dotfiles Installation Script
# Author: fonger
# Updated: 2025-11-14
# ==========================================

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   🚀 Fullstack Dev Dotfiles Installation     ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
echo ""

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# ==========================================
# Helper Functions
# ==========================================

print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${PURPLE}ℹ $1${NC}"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 is installed"
        return 0
    else
        print_error "$1 is not installed"
        return 1
    fi
}

# ==========================================
# Pre-installation Checks
# ==========================================

print_step "Checking prerequisites..."

missing_tools=()

if ! check_command "zsh"; then
    missing_tools+=("zsh")
fi

if ! check_command "git"; then
    missing_tools+=("git")
fi

if ! check_command "stow"; then
    missing_tools+=("stow")
fi

if [[ ${#missing_tools[@]} -gt 0 ]]; then
    print_error "Missing required tools: ${missing_tools[*]}"
    print_info "Please install them first:"
    echo "  brew install ${missing_tools[*]}"
    exit 1
fi

echo ""

# ==========================================
# Main Installation
# ==========================================

print_step "Stowing configuration files..."
echo ""

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

for pkg in "${STOW_PACKAGES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
        stow --restow --target="$HOME" --dir="$DOTFILES_DIR" "$pkg"
        print_success "Stowed $pkg"
    else
        print_warning "Skipping $pkg (directory not found)"
    fi
done

echo ""

# ==========================================
# Optional Components Installation
# ==========================================

print_step "Checking optional components..."
echo ""

# Oh-My-Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_warning "Oh-My-Zsh not found"
    read -p "Install Oh-My-Zsh? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh-My-Zsh installed"
    fi
else
    print_success "Oh-My-Zsh already installed"
fi

# Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    print_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    print_success "zsh-autosuggestions installed"
else
    print_success "zsh-autosuggestions already installed"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    print_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    print_success "zsh-syntax-highlighting installed"
else
    print_success "zsh-syntax-highlighting already installed"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]]; then
    print_info "Installing zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
    print_success "zsh-completions installed"
else
    print_success "zsh-completions already installed"
fi

# Tmux Plugin Manager
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    print_warning "Tmux Plugin Manager (TPM) not found"
    read -p "Install TPM? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        print_success "TPM installed"
        print_info "Start tmux and press Ctrl+A then Shift+I to install plugins"
    fi
else
    print_success "TPM already installed"
fi

echo ""

# ==========================================
# Recommended Tools Check
# ==========================================

print_step "Checking recommended tools..."
echo ""

recommended_tools=(
    "fzf:fuzzy finder"
    "ripgrep:fast search tool"
    "fd:fast find alternative"
    "bat:better cat"
    "eza:better ls"
    "zoxide:smart cd"
    "starship:shell prompt"
    "tmux:terminal multiplexer"
    "nvim:neovim editor"
    "node:Node.js runtime"
    "python3:Python interpreter"
    "docker:containerization (legacy)"
    "container:native macOS containerization"
)

missing_recommended=()

for tool_info in "${recommended_tools[@]}"; do
    IFS=':' read -r tool desc <<< "$tool_info"
    if check_command "$tool"; then
        # Tool exists
        :
    else
        missing_recommended+=("$tool ($desc)")
    fi
done

if [[ ${#missing_recommended[@]} -gt 0 ]]; then
    echo ""
    print_warning "Optional tools not installed:"
    for tool in "${missing_recommended[@]}"; do
        echo "  - $tool"
    done
    echo ""
    print_info "Install with: brew install fzf ripgrep fd bat eza zoxide starship tmux neovim"
fi

echo ""

# ==========================================
# Post-installation Steps
# ==========================================

print_step "Post-installation steps..."
echo ""

# Change default shell to zsh if needed
if [[ "$SHELL" != */zsh ]]; then
    print_warning "Your default shell is not zsh"
    read -p "Change default shell to zsh? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh (restart required)"
    fi
else
    print_success "Default shell is already zsh"
fi

echo ""

# ==========================================
# Summary
# ==========================================

echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   ✨ Installation Complete!                   ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
echo ""

print_success "Dotfiles installed successfully!"
echo ""

if [[ -d "$BACKUP_DIR" ]]; then
    print_info "Backup created at: $BACKUP_DIR"
fi

echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Read the tmux guide: cat TMUX_GUIDE.md (your primary tool!)"
echo "  3. Start tmux and press: Ctrl+A then Shift+I (to install plugins)"
echo "  4. Try a project: tmux new -s test (then Ctrl+A + Alt+F for layout)"
echo "  5. Run 'devsetup' to check your development tools"
echo ""
echo -e "${CYAN}📚 Documentation:${NC}"
echo "  - TMUX_GUIDE.md      → Complete tmux reference (start here!)"
echo "  - QUICK_REFERENCE.md → Essential shortcuts"
echo "  - SETUP_GUIDE.md     → Full setup documentation"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"

