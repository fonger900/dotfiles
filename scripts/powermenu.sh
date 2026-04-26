#!/usr/bin/env bash
# Power menu using wofi

# Toggle: if wofi is already running, kill it and exit
if pgrep -x "wofi" > /dev/null; then
    pkill -x "wofi"
    exit 0
fi

entries="󰌾 Lock\n󰒲 Suspend\n󰑓 Reboot\n󰐥 Shutdown\n󰍃 Logout"

chosen=$(printf "$entries" | wofi \
    --dmenu \
    --prompt "" \
    --width 200 \
    --height 240 \
    --cache-file /dev/null \
    --hide-scroll \
    --no-actions \
    --style "$HOME/.config/wofi/power.css" \
    --define=line_wrap=off \
    --define=dynamic_lines=false)

case "$chosen" in
    "󰌾 Lock")     exec swaylock -f -c 1a1b26 ;;
    "󰒲 Suspend")  systemctl suspend ;;
    "󰑓 Reboot")   systemctl reboot ;;
    "󰐥 Shutdown") systemctl poweroff ;;
    "󰍃 Logout")   swaymsg exit ;;
esac
