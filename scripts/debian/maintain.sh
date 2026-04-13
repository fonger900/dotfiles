#!/bin/bash
set -e

echo "==> System maintenance starting..."

# APT update & upgrade
echo "==> APT: updating packages..."
sudo apt update && sudo apt full-upgrade -y

# Remove orphans and clean cache
echo "==> APT: removing unused packages..."
sudo apt autoremove --purge -y
sudo apt clean

# Remove residual configs
RESIDUAL=$(dpkg -l | awk '/^rc/ {print $2}')
if [ -n "$RESIDUAL" ]; then
    echo "==> APT: purging residual configs..."
    sudo apt purge $RESIDUAL -y
fi

# Flatpak
if command -v flatpak &>/dev/null; then
    echo "==> Flatpak: updating..."
    flatpak update -y
    flatpak uninstall --unused -y
fi

# Journal
echo "==> Journal: vacuuming (keeping 2 weeks)..."
sudo journalctl --vacuum-time=2weeks

# Font cache
echo "==> Fonts: rebuilding cache..."
fc-cache -f

# Broken symlinks in home
echo "==> Checking for broken symlinks in ~..."
BROKEN=$(find ~ -maxdepth 4 -xtype l 2>/dev/null)
if [ -n "$BROKEN" ]; then
    echo "   Broken symlinks found:"
    echo "$BROKEN"
else
    echo "   None found."
fi

echo ""
echo "==> Done. See docs/MAINTENANCE.md for manual steps."
