#!/usr/bin/env bash
LOCK_IMAGE="/tmp/.swaylock-blur.png"

# Lock KeePassXC
dbus-send --session --dest=org.keepassxc.KeePassXC \
  /keepassxc org.keepassxc.MainWindow.lockAllDatabases \
  2>/dev/null &

# Capture + blur
grim "$LOCK_IMAGE"
magick "$LOCK_IMAGE" -scale 5% -scale 2000% "$LOCK_IMAGE"

# Lock
swaylock --daemonize -i "$LOCK_IMAGE"

# Cleanup
while pgrep -x swaylock > /dev/null; do sleep 1; done
rm -f "$LOCK_IMAGE"