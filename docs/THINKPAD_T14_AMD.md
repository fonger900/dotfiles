# ThinkPad T14 Gen 1 AMD — Optimization Guide

## Hardware

| Component | Spec |
|---|---|
| CPU | AMD Ryzen 5 PRO 4650U (Renoir, 6c/12t) |
| GPU | AMD Radeon Vega (integrated, Renoir) |
| Display | 14" IPS 1920×1080 (~157 DPI) |
| Battery | LGC 50Wh |
| Storage | NVMe SSD |

---

## Kernel Parameters

Set in `/etc/default/grub` (applied by ansible):

```
amd_pstate=active   — enables AMD's native P-state driver (better than ACPI cpufreq)
nvme.noacpi=1       — fixes NVMe power management regression on Renoir
```

Verify after reboot:
```bash
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
# should output: amd-pstate-epp
```

---

## Power Management (TLP)

Config at `/etc/tlp.d/99-thinkpad-t14.conf`.

Key decisions:

- `schedutil` governor — AMD's preferred; works with P-state, adapts to load
- `CPU_BOOST_ON_BAT=0` — disables turbo on battery, saves ~2W with minimal real-world impact
- `PLATFORM_PROFILE_ON_BAT=low-power` — engages AMD's firmware-level power profile
- `PCIE_ASPM_ON_BAT=powersupersave` — aggressive PCIe link power saving
- `RADEON_DPM_PERF_LEVEL_ON_BAT=low` — GPU clocks down on battery

Battery charge thresholds (75/80) are conservative for daily plugged-in use. For travel/unplugged use, temporarily disable:
```bash
sudo tlp fullcharge
```

Check TLP status:
```bash
sudo tlp-stat -s
sudo tlp-stat -b   # battery info
```

---

## Why thermald is disabled

`thermald` is an Intel-originated daemon that conflicts with AMD's own thermal management built into the P-state driver and firmware. On Ryzen, the CPU manages thermals via its own SMU (System Management Unit). Running thermald on AMD causes unnecessary throttling and CPU fights.

---

## GPU — Hardware Acceleration

Environment variables set in `~/.config/environment.d/` and `zsh/exports.zsh`:

```bash
AMD_VULKAN_ICD=RADV          # Mesa open-source Vulkan (better than AMDVLK on Renoir)
LIBVA_DRIVER_NAME=radeonsi   # VA-API for hardware video decode
VDPAU_DRIVER=radeonsi        # VDPAU fallback
```

Verify VA-API is working:
```bash
vainfo
# Should show: VAProfileH264*, VAProfileHEVC*, VAProfileVP9*
```

Enable hardware video decode in Firefox:
1. `about:config` → `media.ffmpeg.vaapi.enabled` = `true`
2. `about:config` → `media.hardware-video-decoding.force-enabled` = `true`

**Fix Small UI/Address Bar:**
If the address bar is too small on this display, set `layout.css.devPixelsPerPx` to `1.25` or `1.5` in `about:config`. See [Firefox UI Scaling](./bugs/FIREFOX_UI_SCALING.md) for details.

---

## Display Scaling

14" 1920×1080 = ~157 DPI. Not HiDPI but slightly dense. Settings applied:

```bash
GDK_SCALE=1           # no integer scaling (would be blurry at 2x)
GDK_DPI_SCALE=1.25    # GTK apps render 25% larger
QT_SCALE_FACTOR=1.25  # Qt apps (Firefox, VLC)
XCURSOR_SIZE=28       # cursor size
```

Sway output scale stays at `1.0` — fractional scaling in sway causes blur.
The DPI env vars handle scaling at the toolkit level instead, which is sharper.

Adjust if needed:
- Still too small → change to `1.35` or `1.5`
- Too large → try `1.1`

---

## Input Devices

### Touchpad
```
tap enabled              — tap to click
tap_button_map lrm       — 1-finger=left, 2-finger=right, 3-finger=middle
natural_scroll enabled   — macOS-style scroll direction
dwt enabled              — disable while typing
scroll_method two_finger
accel_profile adaptive
```

### TrackPoint (red nub)
```
pointer_accel 0.5
accel_profile adaptive
```

Tune live without reloading sway:
```bash
swaymsg input "type:pointer" pointer_accel 0.7
```

### Keyboard
```
xkb_options caps:escape  — Caps Lock acts as Escape (useful for vim)
```

To revert Caps Lock to normal, remove `xkb_options` line and reload sway.

---

## Screen Lock & Idle

Idle chain (swayidle):

| Time | Action |
|---|---|
| 4 min | Dim screen to 20% |
| 5 min | Lock screen (swaylock) |
| 10 min | Turn off display |
| On suspend | Pause media + lock |

Manual lock: `Super+Esc`

---

## Suspend / Sleep

Suspend works via `systemctl suspend` (from power menu or lid close).

If suspend is unreliable, check:
```bash
sudo journalctl -b -u systemd-sleep
cat /sys/power/mem_sleep   # should include 'deep'
echo deep | sudo tee /sys/power/mem_sleep   # force S3 sleep
```

To make S3 permanent, add to kernel params:
```
mem_sleep_default=deep
```

---

## Bluetooth

```bash
bluetoothctl
  power on
  scan on
  pair <MAC>
  connect <MAC>
  trust <MAC>       # auto-connect on future boots
```

`bt_auto_off.sh` runs on startup to turn off bluetooth if no devices are connected (saves ~0.5W).

---

## Battery Health Tips

- Charge thresholds 75/80 configured — battery won't charge above 80% when plugged in
- Check battery wear:
```bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'energy|capacity'
```
- For travel (need full charge):
```bash
sudo tlp fullcharge BAT0
```
- Reset to thresholds after:
```bash
sudo tlp setcharge 75 80 BAT0
```
