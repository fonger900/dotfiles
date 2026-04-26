#!/usr/bin/env bash

# Premium Blurred Lock Script
# Depends: grim, imagemagick, swaylock

LOCK_IMAGE="/tmp/swaylock-blur.png"

# Take screenshot
grim "$LOCK_IMAGE"

# Blur image
# -scale 10% -scale 1000% is a very fast way to blur
magick "$LOCK_IMAGE" -scale 10% -scale 1000% "$LOCK_IMAGE"

# Lock screen
swaylock -i "$LOCK_IMAGE"

# Cleanup
rm "$LOCK_IMAGE"
