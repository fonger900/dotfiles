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

---

## Audio (PipeWire)

```bash
# Check status
systemctl --user status pipewire wireplumber

# Restart audio stack
systemctl --user restart pipewire pipewire-pulse wireplumber

# List audio devices
wpctl status
pactl list sinks short
```

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
