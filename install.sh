#!/bin/bash
echo "🧬 Setting up dotfiles..."

ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
# ln -s $PWD/.config/nvim ~/.config/nvim
ln -s $PWD/.config/wezterm ~/.config/wezterm
ln -s $PWD/.config/starship.toml ~/.config/starship.toml

echo "✅ Done. Restart terminal to see changes."
