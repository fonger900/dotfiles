#!/bin/bash

# Toggle the microphone using Pipewire/Wireplumber
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Synchronize the hardware LED to reflect the new state
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
"$SCRIPT_DIR/mic-mute-sync.sh"
