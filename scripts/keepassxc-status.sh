#!/usr/bin/env bash
# Waybar custom module for KeePassXC status

if pgrep -x "keepassxc" > /dev/null; then
    echo "{\"text\": \"󰟵\", \"tooltip\": \"KeePassXC: Running (Secret Service Active)\", \"class\": \"active\"}"
else
    echo "{\"text\": \"󰟵\", \"tooltip\": \"KeePassXC: Stopped (Secret Service Offline)\", \"class\": \"inactive\"}"
fi
