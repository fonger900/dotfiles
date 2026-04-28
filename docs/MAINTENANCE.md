# System Maintenance — Debian 13 / Sway

## Quick maintenance

Run the maintenance script for routine upkeep:

```bash
~/.dotfiles/scripts/debian/maintain.sh
```

This handles: APT updates, orphan removal, apt cache clean, Flatpak updates, journal vacuum, font cache refresh.

---

## APT

```bash
# Update & upgrade
sudo apt update && sudo apt full-upgrade -y

# Remove unused dependencies
sudo apt autoremove --purge -y

# Clean downloaded package cache
sudo apt clean

# Remove residual config from purged packages
sudo apt purge $(dpkg -l | awk '/^rc/ {print $2}') -y

# Find orphaned packages
sudo apt install deborphan -y
deborphan
sudo apt purge $(deborphan) -y
```

---

## Flatpak

```bash
flatpak update -y
flatpak uninstall --unused -y

# List installed
flatpak list

# Remove specific app
flatpak uninstall <app.id> -y
```

---

## Dotfiles

```bash
# Re-apply all dotfiles (stow + tasks)
cd ~/.dotfiles && ansible-playbook ansible/playbook.yml -K

# Re-stow a single package
cd ~/.dotfiles && stow -v -R -t ~ <package>

# Check for broken symlinks in home
find ~ -maxdepth 3 -xtype l 2>/dev/null
```

---

## Runtimes (Mise)

```bash
# Update all tools
mise upgrade

# List installed tools
mise list

# Install a new tool
mise use -g node@lts
```

---

## Disk usage

```bash
# Top space consumers in home
du -sh ~/* | sort -rh | head -15

# APT cache size
du -sh /var/cache/apt/archives/

# Journal size
journalctl --disk-usage

# Trim journal to 2 weeks
sudo journalctl --vacuum-time=2weeks

# Thumbnail cache
du -sh ~/.cache/thumbnails
rm -rf ~/.cache/thumbnails/*
```

---

## System health

```bash
# Failed systemd units
systemctl --failed

# Check a specific service
systemctl status <service>

# Restart a service
sudo systemctl restart <service>

# Boot time breakdown
systemd-analyze blame | head -20
```

---

## Sway / Wayland

```bash
# Reload sway config
swaymsg reload

# Restart waybar
pkill waybar && waybar &

# Check sway log
journalctl --user -u sway -n 50

# List running Wayland apps
swaymsg -t get_tree | jq '.. | .app_id? // empty'
```

---

## Bluetooth

```bash
bluetoothctl
  power on
  scan on
  pair <MAC>
  connect <MAC>
  trust <MAC>

# Service
sudo systemctl restart bluetooth
```

### Bluetooth audio connected but silent

If a headset shows `Connected: yes` in `bluetoothctl info <MAC>` but no Bluetooth sink appears in `wpctl status`, the Bluetooth link is up but the A2DP audio transport is stuck.

Known failure signature:

```bash
bluetoothctl info 88:C9:E8:20:30:78
# Connected: yes

wpctl status
# no WH-1000XM5 sink listed

journalctl --user -u wireplumber --since '30 min ago' --no-pager
# spa.bluez5: Failure in Bluetooth audio transport ...
# pw.node: (bluez_output....) running -> error
```

Recovery steps:

```bash
# 1. Reset the user audio stack
systemctl --user restart wireplumber pipewire pipewire-pulse

# 2. Reconnect the headset cleanly
bluetoothctl disconnect 88:C9:E8:20:30:78
bluetoothctl connect 88:C9:E8:20:30:78

# 3. Confirm the Bluetooth sink exists again
pactl list sinks short
# expect: bluez_output.88_C9_E8_20_30_78.1

# 4. Make the headset the default output
pactl set-default-sink bluez_output.88_C9_E8_20_30_78.1
wpctl set-default 71   # use the current WH-1000XM5 node id from `wpctl status`
```

Verify:

```bash
wpctl status
# expect:
# Devices: WH-1000XM5 [bluez5]
# Sinks:   WH-1000XM5
# Default Configured Devices: bluez_output.88_C9_E8_20_30_78.1
```

If an app was already open when the sink was broken, restart playback once so it opens a fresh stream on the repaired default sink.

---

## Audio (PipeWire)

Custom configurations are managed via the `pipewire` package in dotfiles and symlinked to `~/.config/pipewire/`. These settings optimize for:
- **Sampling:** Support for 44.1k, 48k, 88.2k, and 96k rates.
- **Quality:** Higher quality resampling (`resample.quality = 6`).
- **Latency:** Tuned quantum limits (32-2048) for stability and responsiveness.

```bash
# Check status
systemctl --user status pipewire wireplumber

# Restart audio stack (to apply config changes)
systemctl --user restart pipewire pipewire-pulse wireplumber

# EasyEffects Management
# Start service (background)
flatpak run com.github.wwmm.easyeffects --gapplication-service &

# Open UI to manage presets
flatpak run com.github.wwmm.easyeffects
```

### Recommended Presets
For ThinkPad T14 internal speakers, it is recommended to install community presets:
1. Open EasyEffects.
2. Go to **Output** -> **Presets**.
3. Import or search for **"Advanced Auto Gain"** or **"Perfect EQ"**.


---

## Kernel / drivers

```bash
# List installed kernels
dpkg -l | grep linux-image

# Remove old kernels (keep current + 1)
sudo apt autoremove --purge -y

# Current kernel
uname -r
```
