#!/bin/bash

# Toggle the microphone using Pipewire/Wireplumber
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Synchronize the hardware LED to reflect the new state immediately
# We do it here directly instead of calling mic-mute-sync.sh to avoid any overhead/delay
status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
if [[ $status == *"[MUTED]"* ]]; then
    # Microphone is muted, turn on the LED
    brightnessctl --device='platform::micmute' set 1 2>/dev/null || true
else
    # Microphone is active, turn off the LED
    brightnessctl --device='platform::micmute' set 0 2>/dev/null || true
fi
