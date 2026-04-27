#!/usr/bin/env bash
LOCKFILE="/tmp/.swaylock.lock"
LOCK_IMAGE="/tmp/.swaylock-blur.png"

# 1. Bail nếu đang chạy
if [ -f "$LOCKFILE" ] || pgrep -x swaylock > /dev/null; then
  exit 0
fi

# 2. Claim + trap cleanup
touch "$LOCKFILE"
trap 'rm -f "$LOCKFILE" "$LOCK_IMAGE"' EXIT INT TERM

# 3. Lock KeePassXC
dbus-send --session --dest=org.keepassxc.KeePassXC \
  /keepassxc org.keepassxc.MainWindow.lockAllDatabases \
  2>/dev/null &

# 4. Capture + blur
grim "$LOCK_IMAGE"
if command -v magick &>/dev/null; then
  magick "$LOCK_IMAGE" -filter Gaussian -blur 0x8 "$LOCK_IMAGE"
else
  convert "$LOCK_IMAGE" -scale 15% -scale 1000% "$LOCK_IMAGE"
fi

# 5. Lock screen
swaylock --daemonize -i "$LOCK_IMAGE"

# 6. Chờ unlock rồi cleanup
while pgrep -x swaylock > /dev/null; do
  sleep 1
done