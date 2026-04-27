#!/usr/bin/env bash
# lock.sh — Used for idle timeout (blocking, allows subsequent timers to run)
# Also used for: before-sleep, manual lock ($mod+Escape)

LOCKFILE="/tmp/.swaylock.lock"
LOCK_IMAGE="/tmp/.swaylock-blur.png"

# 1. Bail out if swaylock is already running or starting up
if [ -f "$LOCKFILE" ] || pgrep -x swaylock > /dev/null; then
    exit 0
fi

# 2. Claim this instance
touch "$LOCKFILE"

# 3. Lock KeePassXC database
keepassxc --lock 2>/dev/null &

# 4. Capture screen & blur it
grim "$LOCK_IMAGE"
magick "$LOCK_IMAGE" -scale 15% -scale 1000% "$LOCK_IMAGE"

# 5. Lock screen
# --daemonize: forks once the surface is ready so the caller (swayidle) can proceed
# This is critical for before-sleep: swayidle must be unblocked to allow suspend
swaylock --daemonize -i "$LOCK_IMAGE"

# 6. Wait for swaylock to actually exit (user unlocked), then cleanup
while pgrep -x swaylock > /dev/null; do
    sleep 1
done
rm -f "$LOCKFILE" "$LOCK_IMAGE"