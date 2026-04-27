#!/usr/bin/env bash
# Script to change Sway wallpaper based on the time of day

WALLPAPER_DIR="$HOME/.config/sway/wallpapers"
DEFAULT_WALLPAPER="$HOME/.config/sway/wallpaper.jpg"
PROCESSED_WALLPAPER="/tmp/sway-wallpaper-processed.jpg"

# Ensure directory exists
mkdir -p "$WALLPAPER_DIR"

while true; do
    HOUR=$(date +%H)
    
    if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 12 ]; then
        MODE="morning"
        # Cool, fresh lighting
        PARAMS="-brightness-contrast 0x5 -modulate 100,110,105"
    elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 18 ]; then
        MODE="afternoon"
        # Bright, warm lighting
        PARAMS="-brightness-contrast 5x10 -modulate 110,120,95"
    elif [ "$HOUR" -ge 18 ] && [ "$HOUR" -lt 21 ]; then
        MODE="evening"
        # Golden hour, orange tint
        PARAMS="-brightness-contrast -5x20 -modulate 90,130,85 -fill '#ff9e64' -colorize 10%"
    else
        MODE="night"
        # Dim, cold blue tint
        PARAMS="-brightness-contrast -40x-10 -modulate 60,80,120 -fill '#1a1b26' -colorize 20%"
    fi

    # Check if a specific image exists, otherwise use the default and adjust lighting
    WP_FILE="$WALLPAPER_DIR/$MODE.jpg"

    if [ -f "$WP_FILE" ]; then
        # Use the specific file as is
        swaymsg "output * bg $WP_FILE fill"
    elif [ -f "$DEFAULT_WALLPAPER" ]; then
        # Generate adjusted lighting version of the default wallpaper
        convert "$DEFAULT_WALLPAPER" $PARAMS "$PROCESSED_WALLPAPER"
        swaymsg "output * bg $PROCESSED_WALLPAPER fill"
    fi

    # Wait for 30 minutes before checking again
    sleep 1800
done
