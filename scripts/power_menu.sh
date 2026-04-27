#!/usr/bin/env bash

# Toggle: if fuzzel is already running, kill it and exit
if pgrep -x "fuzzel" > /dev/null; then
    pkill -x "fuzzel"
    exit 0
fi

# Options
entries="󰌾 Lock\n󰒲 Suspend\n󰍃 Logout\n󰑓 Reboot\n󰐥 Shutdown"

chosen=$(echo -e "$entries" | fuzzel --dmenu --width 15 --lines 5 --index)

case $chosen in
    0) swaylock -f -c 1a1b26 ;;
    1) systemctl suspend ;;
    2) swaymsg exit ;;
    3) systemctl reboot ;;
    4) systemctl poweroff ;;
esac
