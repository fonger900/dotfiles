#!/usr/bin/env bash
set -euo pipefail

echo "🧬 Setting up dotfiles..."

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

link_file() {
	local src=$1
	local dest=$2
	local dest_dir
	dest_dir=$(dirname "$dest")
	mkdir -p "$dest_dir"
	ln -sfn "$src" "$dest"
	echo "→ Linked $dest -> $src"
}

link_if_exists() {
	local relative=$1
	local target=$DOTFILES_DIR/$relative
	local destination=$2
	if [[ -e $target ]]; then
		link_file "$target" "$destination"
	else
		echo "⚠️  Skipping $relative (not found)"
	fi
}

link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_if_exists ".tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_file "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

echo "✅ Done. Restart terminal to see changes."
