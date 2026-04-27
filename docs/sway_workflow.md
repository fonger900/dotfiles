# 🚀 The Ultimate Sway Workflow Guide

Sway is a tiling window manager, which means it's designed to keep your hands on the keyboard and your windows organized automatically. Here is the "Best Flow" for high productivity.

## 1. The "Rule of Ten" (Workspaces)
Don't just open everything on one screen. Use workspaces to isolate contexts:
- **Workspace 1 (󰆍)**: Main Terminal / Development
- **Workspace 2 (󰈹)**: Primary Browser
- **Workspace 3 (󰅩)**: Code Editor (Neovim/Helix)
- **Workspace 4 (󰓇)**: Media (Spotify/YouTube)
- **Workspace 5 (󰙯)**: Communication (Slack/Discord)

**Flow**: Use `$mod + [Num]` to switch instantly, and `$mod + Shift + [Num]` to send a window to a task area.

## 2. Master the Layouts
Tiling is great, but sometimes you need more space:
- **Stacked (`$mod + s`)**: Windows sit on top of each other like physical paper. Great for focusing on one task while keeping others visible in the title bar.
- **Tabbed (`$mod + w`)**: Like browser tabs for your whole OS. This is the **best flow** for managing multiple terminal windows or browser instances.
- **Split Toggle (`$mod + v`)**: Change if the next window opens vertically or horizontally.

## 3. The "Ghost" Window (Scratchpad)
The scratchpad is a hidden workspace for windows you need "sometimes" but not "always" (like a calculator, a quick terminal, or your music player).
- **Move to Scratchpad**: `$mod + Shift + Minus (-)`
- **Show/Hide Scratchpad**: `$mod + Minus (-)`

**Pro Tip**: Move your `pavucontrol` or a small `btop` terminal to the scratchpad to pull them up anywhere.

## 4. Launching & Controlling
- **Launcher**: `$mod + d` (Wofi). Just start typing the app name.
- **Kill Window**: `$mod + Shift + q`. Never reach for the [X].
- **Floating Toggle**: `$mod + Shift + Space`. Use this for apps that don't tile well (calculators, small dialogs).

## 5. Hardware & System
- **Brightness/Volume**: Use the dedicated laptop keys.
- **Screenshots**:
    - `Print`: Capture whole screen to `~/Pictures/Screenshots`.
    - `$mod + Shift + s`: Select a region to capture.
- **Power Menu**: `$mod + Shift + e` for Logout/Reboot/Shutdown.

## 6. Maintenance Flow
- **Reload Config**: `$mod + Shift + c`. Use this after you edit your config to see changes instantly without logging out.
- **Idle Inhibition**: Use the new icon in Waybar (󰈉) to prevent sleep when you are reading or watching something that isn't fullscreen.

---
*Generated for Fonger's Dotfiles*
