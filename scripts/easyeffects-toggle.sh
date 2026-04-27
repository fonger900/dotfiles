#!/usr/bin/env bash
# Script to toggle EasyEffects and ensure audio streams are migrated

# Function to get the real hardware sink NAME
get_hardware_sink_name() {
    # Get the name of the first ALSA sink that isn't EasyEffects
    pactl list sinks short | grep -v "easyeffects" | head -n 1 | cut -f2
}

# Function to migrate all streams to a specific sink
migrate_streams() {
    local target=$1
    if [ -z "$target" ]; then return; fi
    
    echo "Migrating all streams to $target..."
    pactl list sink-inputs short | cut -f1 | while read -r id; do
        pactl move-sink-input "$id" "$target" 2>/dev/null
    done
}

if pgrep -f "com.github.wwmm.easyeffects" > /dev/null || [ "$1" == "--quit" ]; then
    echo "Stopping EasyEffects and migrating streams..."
    
    # 1. Identify hardware sink name
    HW_NAME=$(get_hardware_sink_name)
    
    if [ -n "$HW_NAME" ]; then
        echo "Hardware sink identified: $HW_NAME"
        
        # 2. Set hardware sink as default (using name is more robust)
        wpctl set-default "$HW_NAME"
        pactl set-default-sink "$HW_NAME"
        
        # 3. Migrate active streams before quitting
        migrate_streams "$HW_NAME"
    fi
    
    # 4. Quit EasyEffects
    flatpak run com.github.wwmm.easyeffects --quit
    
    # 5. Small delay and migrate again (to catch streams that were just created)
    sleep 0.5
    if [ -n "$HW_NAME" ]; then
        migrate_streams "$HW_NAME"
    fi
    
    notify-send "EasyEffects" "Disabled - Audio routed to hardware" -i audio-speakers
else
    echo "Starting EasyEffects..."
    notify-send "EasyEffects" "Enabling..." -i audio-speakers
    
    # Ensure service is started
    flatpak run com.github.wwmm.easyeffects --gapplication-service &
    
    # Wait for it to initialize and become default
    for i in {1..10}; do
        EE_SINK=$(pactl list sinks short | grep "easyeffects_sink" | cut -f2)
        if [ -n "$EE_SINK" ]; then
            wpctl set-default "$EE_SINK"
            pactl set-default-sink "$EE_SINK"
            migrate_streams "$EE_SINK"
            break
        fi
        sleep 0.5
    done
fi
