#!/bin/bash
# ============================================================================
# 🔋 Bluetooth Auto-Off Script
# ============================================================================
# Automatically turns off Bluetooth power if no devices are connected 
# for a set period (default: 5 minutes) to save battery.

# Configuration
CHECK_INTERVAL=60       # Check every 60 seconds
IDLE_THRESHOLD=300      # 5 minutes (300 seconds)
IDLE_COUNTER=0

echo "🚀 Bluetooth auto-off daemon started..."

while true; do
    # Check if any device is connected
    if bluetoothctl info | grep -q "Connected: yes"; then
        # Device is connected, reset counter
        if [ $IDLE_COUNTER -ne 0 ]; then
            echo "✅ Device connected. Resetting idle counter."
            IDLE_COUNTER=0
        fi
    else
        # No device connected, increment counter
        IDLE_COUNTER=$((IDLE_COUNTER + CHECK_INTERVAL))
        
        # If idle for longer than threshold, turn off power
        if [ $IDLE_COUNTER -ge $IDLE_THRESHOLD ]; then
            # Double check power status before turning off
            if bluetoothctl show | grep -q "Powered: yes"; then
                echo "💤 No connection for 5 minutes. Powering off Bluetooth to save battery."
                bluetoothctl power off
                # Notify user if notify-send is available
                if command -v notify-send &>/dev/null; then
                    notify-send "Bluetooth" "Powered off to save battery" -i bluetooth
                fi
            fi
            IDLE_COUNTER=0
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
