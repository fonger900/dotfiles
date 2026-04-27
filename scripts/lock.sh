#!/usr/bin/env bash
# Robust lock script — blurs a screenshot of the current screen

LOCKFILE="/tmp/.swaylock.lock"

# 1. Bail out if swaylock is already running or starting up
if [ -f "$LOCKFILE" ] || pgrep -x swaylock > /dev/null; then
    exit 0
fi

# 2. Claim this instance
touch "$LOCKFILE"

# 3. Lock KeePassXC database for security
keepassxc --lock 2>/dev/null &

# Premium Blurred Lock Script
# Depends: grim, imagemagick, swaylock

LOCK_IMAGE="/tmp/swaylock-blur.png"

# Take screenshot
grim "$LOCK_IMAGE"

# Blur image
# -scale 10% -scale 1000% is a very fast way to blur
magick "$LOCK_IMAGE" -scale 15% -scale 1000% "$LOCK_IMAGE"

# 5. Lock screen with blurred screenshot (blocking — prevents double-suspend)
swaylock -i "$LOCK_IMAGE"

# 6. Cleanup
rm -f "$LOCKFILE" "$LOCK_IMAGE"