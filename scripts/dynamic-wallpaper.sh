#!/usr/bin/env bash
# Script to change Sway wallpaper based on the time of day

WALLPAPER_DIR="$HOME/.config/sway/wallpapers"
DEFAULT_WALLPAPER="$HOME/.config/sway/wallpaper.jpg"

# Ensure directory exists
mkdir -p "$WALLPAPER_DIR"

while true; do
    HOUR=$(date +%H)
    
    if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 12 ]; then
        MODE="morning"
    elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 18 ]; then
        MODE="afternoon"
    elif [ "$HOUR" -ge 18 ] && [ "$HOUR" -lt 21 ]; then
        MODE="evening"
    else
        MODE="night"
    fi

    WP_FILE="$WALLPAPER_DIR/$MODE.jpg"

    if [ ! -f "$WP_FILE" ]; then
        WP_FILE="$DEFAULT_WALLPAPER"
    fi

    if [ -f "$WP_FILE" ]; then
        swaymsg "output * bg $WP_FILE fill"
    fi

    # Wait for 30 minutes before checking again
    sleep 1800
done
