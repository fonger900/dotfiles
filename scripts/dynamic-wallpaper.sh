#!/usr/bin/env bash
# Script to change Sway wallpaper based on the time of day

WALLPAPER_DIR="$HOME/.config/sway/wallpapers"

while true; do
    HOUR=$(date +%H)
    WP_FILE="$WALLPAPER_DIR/morning-wallpaper.jpg"
    
    if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 12 ]; then
        WP_FILE="$WALLPAPER_DIR/morning-wallpaper.jpg"

    elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 18 ]; then
        WP_FILE="$WALLPAPER_DIR/noon-wallpaper.png"

    elif [ "$HOUR" -ge 18 ] && [ "$HOUR" -lt 21 ]; then
        WP_FILE="$WALLPAPER_DIR/night-wallpaper.png"

    fi

    swaymsg "output * bg \"$WP_FILE\" fill"

    # Wait for 30 minutes before checking again
    sleep 1800
done
