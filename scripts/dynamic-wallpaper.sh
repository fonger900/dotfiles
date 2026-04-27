#!/usr/bin/env bash
# Set wallpaper based on current time of day — run once, not in a loop
# Called by: sway/config exec_always OR systemd user timer

WALLPAPER_DIR="$HOME/.config/sway/wallpapers"
HOUR=$(date +%H)

if   [ "$HOUR" -ge 6  ] && [ "$HOUR" -lt 12 ]; then
    WP="$WALLPAPER_DIR/morning-wallpaper.jpg"
elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 18 ]; then
    WP="$WALLPAPER_DIR/noon-wallpaper.png"
elif [ "$HOUR" -ge 18 ] && [ "$HOUR" -lt 21 ]; then
    WP="$WALLPAPER_DIR/night-wallpaper.png"
else
    WP="$WALLPAPER_DIR/night-wallpaper.png"
fi

# Fallback to default if file doesn't exist
[ -f "$WP" ] || WP="$HOME/.config/sway/wallpaper.jpg"

swaymsg "output * bg \"$WP\" fill"
