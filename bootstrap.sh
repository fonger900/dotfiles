#!/usr/bin/env bash
set -euo pipefail

# Set locale for Ansible and Stow
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo "╔═══════════════════════════════════════════════╗"
echo "║   🚀 Fullstack Dev Dotfiles Bootstrap (Ansible) ║"
echo "╚═══════════════════════════════════════════════╝"
echo ""

# 1. Ensure Ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "▶ Installing Ansible..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v brew &> /dev/null; then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install ansible
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y ansible
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm ansible
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y ansible
    else
        echo "✗ Could not determine package manager to install Ansible."
        echo "  Please install Ansible manually and run this script again."
        exit 1
    fi
fi

echo "✓ Ansible is installed."
echo ""
echo "▶ Running Dotfiles Playbook..."
cd "$DOTFILES_DIR"

# Run the playbook. -K will prompt for the sudo password which is needed for system packages
# If the user has passwordless sudo, they can just press enter or omit -K.
ansible-playbook -i ansible/inventory ansible/playbook.yml -K

echo ""
echo "✓ Installation Complete!"
echo "Next Steps:"
echo "  1. Restart your terminal (exec zsh)"
echo "  2. Run 'mise install' inside your projects"
echo "  3. Open Tmux and press Prefix + I to install plugins"
