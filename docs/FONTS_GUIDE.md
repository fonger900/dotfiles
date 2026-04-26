# 🔠 Font Management Guide

This document explains how fonts are installed, configured, and managed in this dotfiles repository.

## 🛠️ Overview
Typography in this setup is optimized for a 1080p display, prioritizing clarity and readability.

- **Interface Font:** [Inter](https://rsms.me/inter/) (13px)
- **Terminal Font:** [JetBrains Mono Nerd Font](https://www.jetbrains.com/lp/mono/) (12px)
- **Fallback Font:** Noto Sans CJK (for Emoji and Asian character support)

---

## 📥 Installation

### Automated (Ansible)
Most fonts are handled automatically during `./bootstrap.sh`:
- **System Fonts:** Installed via APT in `ansible/tasks/system.yml`.
- **Nerd Fonts:** Downloaded from GitHub and installed to `~/.local/share/fonts` in `ansible/tasks/fonts.yml`.

### Manual Installation
To add a font manually:
1. Drop `.ttf` or `.otf` files into `~/.local/share/fonts/`.
2. Update the system font cache:
   ```bash
   fc-cache -fv
   ```

---

## ⚙️ Configuration

### 1. Global UI (Sway / Waybar)
Controlled in `sway/.config/sway/config`:
```sway
font pango:Inter 13
```

### 2. Terminal (WezTerm)
Controlled in `wezterm/.config/wezterm/wezterm.lua`:
```lua
config.font = wezterm.font_with_fallback({ 
  'JetBrainsMono NF', 
  'JetBrains Mono' 
})
```

### 3. Editor (Neovim)
While Neovim uses the terminal font, some UI elements are scaled via fontconfig.

---

## 🔍 Useful Commands

| Command | Action |
| :--- | :--- |
| `fc-list : family` | List all installed font families |
| `fc-list : family \| grep -i "name"` | Search for a specific font |
| `fc-match Monospace` | Check the current default monospace font |
| `fc-cache -fv` | Re-scan and rebuild font cache |

## 💡 Troubleshooting (1080p Optimization)
If fonts look "fuzzy" or "blurry" on the T14 display:
1. Ensure **Hinting** is enabled.
2. Check `zsh/exports.zsh` for scaling variables:
   - `GDK_DPI_SCALE=1.25` (Scales UI text)
   - `QT_SCALE_FACTOR=1.25` (Scales Qt apps)
