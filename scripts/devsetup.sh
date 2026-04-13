#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Checking Development Environment...${NC}\n"

check_tool() {
    local name=$1
    local cmd=$2
    local install_hint=$3

    # Detect OS to adjust install hint
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            install_hint="sudo apt install ${cmd}"
        elif command -v pacman &> /dev/null; then
            install_hint="sudo pacman -S ${cmd}"
        fi
    fi

    printf "% -20s " "$name"

    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✅ Installed${NC} ($(command -v "$cmd"))"
    else
        echo -e "${RED}❌ Missing${NC}"
        echo -e "   ${YELLOW}➜ Install: $install_hint${NC}"
        MISSING_TOOLS=1
    fi
}

MISSING_TOOLS=0

# Core
echo -e "${BLUE}--- Core Utilities ---${NC}"
check_tool "Zsh" "zsh" "brew install zsh"
check_tool "Git" "git" "brew install git"
check_tool "Stow" "stow" "brew install stow"
check_tool "Curl" "curl" "brew install curl"

# Shell Enhancements
echo -e "\n${BLUE}--- Shell Enhancements ---${NC}"
check_tool "Starship" "starship" "brew install starship"
check_tool "Zoxide" "zoxide" "brew install zoxide"
check_tool "Fastfetch" "fastfetch" "brew install fastfetch"

# Modern Replacements
echo -e "\n${BLUE}--- Modern Tools ---${NC}"
check_tool "Bat (cat)" "bat" "brew install bat"
check_tool "Eza (ls)" "eza" "brew install eza"
check_tool "FZF" "fzf" "brew install fzf"
check_tool "Fd (find)" "fd" "brew install fd"
check_tool "Ripgrep (grep)" "rg" "brew install ripgrep"

# Editors & Multiplexers
echo -e "\n${BLUE}--- Editors & Terminals ---${NC}"
check_tool "Neovim" "nvim" "brew install neovim"
check_tool "Tmux" "tmux" "brew install tmux"
check_tool "Helix" "hx" "brew install helix"
check_tool "Ghostty" "ghostty" "brew install ghostty"

# Languages (Basic)
echo -e "\n${BLUE}--- Runtimes ---${NC}"
check_tool "Node.js" "node" "brew install node"
check_tool "Python" "python3" "brew install python3"
check_tool "Go" "go" "brew install go"
check_tool "Rust" "cargo" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
check_tool "Container" "container" "brew install container"

# GTK & UI (Linux Only)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo -e "\n${BLUE}--- GTK & UI ---${NC}"
  check_tool "GDK Pixbuf bin" "gdk-pixbuf-query-loaders" "sudo apt install libgdk-pixbuf-2.0-bin"
fi

echo ""
if [[ "${MISSING_TOOLS}" -eq 1 ]]; then
    echo -e "${YELLOW}⚠  Some tools are missing. Run the installation commands above to fix.${NC}"
else
    echo -e "${GREEN}✨ All systems operational! Happy coding.${NC}"
fi
