#!/usr/bin/env bash
# Waybar custom module for EasyEffects daemon status

if pgrep -f "com.github.wwmm.easyeffects" > /dev/null; then
    preset=$(gdbus call --session \
        --dest com.github.wwmm.easyeffects \
        --object-path /com/github/wwmm/easyeffects \
        --method com.github.wwmm.easyeffects.GetCurrentPresetName 2>/dev/null \
        | tr -d "()'")

    if [ -n "$preset" ] && [ "$preset" != " " ]; then
        echo "{\"text\": \"󰸶\", \"tooltip\": \"EasyEffects: $preset\", \"class\": \"active\"}"
    else
        echo "{\"text\": \"󰸶\", \"tooltip\": \"EasyEffects: running\", \"class\": \"active\"}"
    fi
else
    echo "{\"text\": \"󰸷\", \"tooltip\": \"EasyEffects: off\", \"class\": \"inactive\"}"
fi
