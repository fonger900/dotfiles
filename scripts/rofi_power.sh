#!/usr/bin/env bash

# Toggle: if rofi is already running, kill it and exit
if pgrep -x "rofi" > /dev/null; then
    pkill -x "rofi"
    exit 0
fi

# Options
lock="󰌾 Lock"
suspend="󰒲 Suspend"
logout="󰍃 Logout"
reboot="󰑓 Reboot"
shutdown="󰐥 Shutdown"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme-str 'window {width: 250px; height: 320px;} listview {columns: 1; lines: 5;}')"

case $chosen in
    $lock)
        swaylock -f -c 1a1b26
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        swaymsg exit
        ;;
    $reboot)
        systemctl reboot
        ;;
    $shutdown)
        systemctl poweroff
        ;;
esac
