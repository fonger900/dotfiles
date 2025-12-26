#!/usr/bin/env bash
set -e

# Default URL (replace with your actual hosted URL)
DOWNLOAD_URL="${1:-https://example.com/nvim-config.tar.gz}"
CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

echo "🚀 Installing Neovim configuration..."

# 1. Check for required tools
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim is not installed. Please install it first."
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed (required for plugins). Please install it first."
    exit 1
fi

# 2. Backup existing config
if [ -d "$CONFIG_DIR" ]; then
    echo "📦 Backing up existing config to $BACKUP_DIR..."
    mv "$CONFIG_DIR" "$BACKUP_DIR"
fi

# 3. Create directory and download
echo "📥 Downloading and extracting configuration..."
mkdir -p "$CONFIG_DIR"
curl -L "$DOWNLOAD_URL" | tar -xz -C "$CONFIG_DIR"

echo "✨ Done! Open Neovim ('nvim') to start plugin installation."
