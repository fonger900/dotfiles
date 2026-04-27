#!/usr/bin/env bash
# Script to switch Waybar themes

THEME_DIR="$HOME/.dotfiles/waybar/.config/waybar/themes"
WAYBAR_CONFIG_DIR="$HOME/.dotfiles/waybar/.config/waybar"
CURRENT_THEME_LINK="$WAYBAR_CONFIG_DIR/theme.css"

function usage() {
    echo "Usage: $0 [tokyo-night|catppuccin-mocha]"
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.css//g'
}

if [ -z "$1" ]; then
    usage
    exit 1
fi

THEME_FILE="$THEME_DIR/$1.css"

if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme '$1' not found."
    usage
    exit 1
fi

# Update symlink
ln -sf "themes/$1.css" "$CURRENT_THEME_LINK"

# Reload waybar (Sway handles this via exec_always in config, or we trigger it)
if pgrep -x "waybar" > /dev/null; then
    # Sending SIGUSR2 tells waybar to reload its CSS/Config
    pkill -USR2 waybar
    echo "Applied $1 theme and reloaded Waybar."
else
    echo "Applied $1 theme. Start Waybar to see changes."
fi
