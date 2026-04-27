#!/usr/bin/env bash
# Show sway keybinding hints via wofi

# Toggle: if fuzzel is already running, kill it and exit
if pgrep -x "fuzzel" > /dev/null; then
    pkill -x "fuzzel"
    exit 0
fi

hints="$(cat <<'EOF'
󰆍  Super+Enter        Terminal
󰈹  Super+B            Browser
󰉋  Super+E            Files
󰍉  Super+D            App launcher

󰌾  Super+Esc          Lock
󰐥  Super+Shift+E      Power menu
󰑓  Super+Shift+C      Reload sway

󰅖  Super+Q            Kill window
󰖯  Super+F            Fullscreen
󱂬  Super+Space        Toggle floating
󱂬  Super+V            Split toggle

󰬐  Super+H/J/K/L      Focus
󰬐  Super+Shift+H/J/K/L Move

󰬐  Super+1…0          Switch Workspace
󰬐  Super+Shift+1…0    Move Workspace

󰒱  Super+Shift+S      Screenshot
EOF
)"

echo -e "$hints" | fuzzel \
    --dmenu \
    --prompt "  Shortcuts " \
    --width 35 \
    --lines 18 \
    --no-icons
