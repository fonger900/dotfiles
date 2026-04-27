#!/usr/bin/env bash
LOCK_IMAGE="/tmp/.swaylock-blur.png"

# Lock KeePassXC
dbus-send --session --dest=org.keepassxc.KeePassXC \
  /keepassxc org.keepassxc.MainWindow.lockAllDatabases \
  2>/dev/null &

# Capture + Blur
# Note: 'magick' can be slow. If you want instant locking, 
# consider a solid color or 'swaylock-effects'.
grim "$LOCK_IMAGE"
magick "$LOCK_IMAGE" -scale 5% -scale 2000% "$LOCK_IMAGE"

# Lock - DO NOT use --daemonize here
swaylock -i "$LOCK_IMAGE"

# Cleanup runs ONLY after unlock
rm -f "$LOCK_IMAGE"