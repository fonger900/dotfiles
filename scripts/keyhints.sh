#!/usr/bin/env bash
# Show sway keybinding hints via wofi

hints="$(cat <<'EOF'
 APPLICATIONS
󰆍  Super+Enter       Terminal
󰈹  Super+B           Browser
󰉋  Super+E           Files
󰍉  Super+D           App launcher

 SESSION
󰌾  Super+Esc         Lock
󰐥  Super+Shift+E     Power menu
󰑓  Super+Shift+C     Reload sway

 WINDOWS
  Super+Q           Kill window
  Super+F           Fullscreen
  Super+Space       Toggle floating
  Super+A           Focus parent
  Super+S           Layout stacking
  Super+W           Layout tabbed
  Super+V           Split toggle

 MOVE & FOCUS
  Super+H/J/K/L     Focus left/down/up/right
  Super+Shift+H/J/K/L  Move window

 WORKSPACES
  Super+1…0         Switch workspace
  Super+Shift+1…0   Move to workspace
  Super+Tab         Last workspace

 SCRATCHPAD
  Super+Shift+-     Send to scratchpad
  Super+-           Show scratchpad

 RESIZE
  Super+R           Resize mode

 SCREENSHOTS
  Print             Full screen
  Super+Shift+S     Region select
EOF
)"

echo "$hints" | wofi \
    --dmenu \
    --prompt "Keybindings" \
    --width 380 \
    --height 580 \
    --cache-file /dev/null \
    --hide-scroll \
    --no-actions \
    --style "$HOME/.config/wofi/keyhints.css" \
    --define=line_wrap=off \
    --define=dynamic_lines=false
