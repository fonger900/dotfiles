#!/bin/bash

# Robustly get microphone status (retries if pipewire is initializing)
for i in {1..10}; do
    status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        break
    fi
    sleep 0.2
done

if [[ -z "$status" ]]; then
    # If we still can't get status, just exit
    exit 0
fi

if [[ $status == *"[MUTED]"* ]]; then
    # Microphone is muted, turn on the LED
    brightnessctl --device='platform::micmute' set 1 2>/dev/null || true
else
    # Microphone is active, turn off the LED
    brightnessctl --device='platform::micmute' set 0 2>/dev/null || true
fi
