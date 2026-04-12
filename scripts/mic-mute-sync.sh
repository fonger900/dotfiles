#!/bin/bash

# Give pipewire a second to initialize on startup if needed
sleep 1

status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)
if [[ $status == *"[MUTED]"* ]]; then
    # Microphone is muted, turn on the LED
    brightnessctl --device='platform::micmute' set 1
else
    # Microphone is active, turn off the LED
    brightnessctl --device='platform::micmute' set 0
fi
