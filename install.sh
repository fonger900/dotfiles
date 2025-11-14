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

backup_file() {
    local file=$1
    if [[ -e "$file" ]] && [[ ! -L "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$file" "$BACKUP_DIR/"
        print_warning "Backed up $file to $BACKUP_DIR"
    fi
}

link_file() {
    local src=$1
    local dest=$2
    local dest_dir
    dest_dir=$(dirname "$dest")
    
    # Create destination directory if it doesn't exist
    mkdir -p "$dest_dir"
    
    # Backup existing file if it's not a symlink
    if [[ -e "$dest" ]] && [[ ! -L "$dest" ]]; then
        backup_file "$dest"
        rm -rf "$dest"
    fi
    
    # Create symlink
    ln -sfn "$src" "$dest"
    print_success "Linked: $dest → $src"
}

link_if_exists() {
    local relative=$1
    local target=$DOTFILES_DIR/$relative
    local destination=$2
    
    if [[ -e $target ]]; then
        link_file "$target" "$destination"
    else
        print_warning "Skipping $relative (not found)"
    fi
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

print_step "Creating symlinks for configuration files..."
echo ""

# Zsh configuration
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Tmux configuration
link_if_exists ".tmux.conf" "$HOME/.tmux.conf"

# Neovim configuration
if [[ -d "$DOTFILES_DIR/nvim" ]]; then
    link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
fi

# Wezterm configuration
if [[ -f "$DOTFILES_DIR/wezterm.lua" ]]; then
    link_file "$DOTFILES_DIR/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
fi

# Ghostty configuration (if exists)
if [[ -f "$DOTFILES_DIR/ghostty.conf" ]]; then
    link_file "$DOTFILES_DIR/ghostty.conf" "$HOME/.config/ghostty/config"
fi

# Starship prompt configuration
if [[ -f "$DOTFILES_DIR/starship.toml" ]]; then
    link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
fi

# Ripgrep configuration
if [[ -f "$DOTFILES_DIR/.ripgreprc" ]]; then
    link_file "$DOTFILES_DIR/.ripgreprc" "$HOME/.ripgreprc"
fi

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
    "exa:better ls"
    "zoxide:smart cd"
    "starship:shell prompt"
    "tmux:terminal multiplexer"
    "nvim:neovim editor"
    "node:Node.js runtime"
    "python3:Python interpreter"
    "docker:containerization"
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
    print_info "Install with: brew install fzf ripgrep fd bat exa zoxide starship tmux neovim"
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
echo "  2. If using tmux, start it and press: Ctrl+A then Shift+I"
echo "  3. Read the setup guide: cat SETUP_GUIDE.md"
echo "  4. Run 'devsetup' to check your development tools"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"

