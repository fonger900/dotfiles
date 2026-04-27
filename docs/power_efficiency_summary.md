# Power Efficiency Configuration (ThinkPad T14 AMD)

This document summarizes how power efficiency is managed on your system, based on your current `.dotfiles` configuration.

## 1. TLP Power Management (`/etc/tlp.d/99-thinkpad-t14.conf`)
TLP is the central daemon managing your power profiles. It dynamically adjusts hardware behavior when the device is running on battery:

- **CPU Limits:** Turbo boost is disabled on battery (`CPU_BOOST_ON_BAT=0`), saving about ~2W with minimal performance impact. It uses the modern `schedutil` governor.
- **Platform Profile:** Switches to `low-power` mode via AMD's firmware when on battery.
- **GPU & PCIe:** The Radeon integrated graphics are forced into `low` performance mode, and PCIe connections are put into `powersupersave` mode to aggressively cut power to idle components.

## 2. Battery Lifespan (Charge Thresholds)
To preserve the physical health of your battery over the long term, your configuration limits charging:

- **Thresholds:** The battery stops charging at **80%** and only starts again if it drops below **75%**.
- **When Traveling:** If you need a full 100% charge before a trip, run `sudo tlp fullcharge BAT0` in your terminal. You can restore the thresholds later with `sudo tlp setcharge 75 80 BAT0`.

## 3. Kernel & Hardware Adjustments
- **AMD P-State Driver:** Your GRUB boot configuration includes `amd_pstate=active`, which gives the CPU finer control over its clock speeds compared to older generic drivers.
- **Hardware Video Decoding:** Browsers and media players are configured to use the GPU for video decoding (`VA-API` via the `radeonsi` driver). This prevents the CPU from doing the heavy lifting while watching videos.
- **Deep Sleep:** The system is forced to use `deep` (S3) sleep mode (`mem_sleep_default=deep`) during suspend, which consumes significantly less power than modern standby.

## 4. Screen & Idle (`swayidle`)
Your display manager actively saves power when you step away:
- **4 minutes:** Dims the screen to 20% brightness.
- **5 minutes:** Locks the screen.
- **10 minutes:** Completely turns off the display.

## Quick Commands to Check Power Status
- **View TLP battery status:** `sudo tlp-stat -b`
- **View overall TLP system config:** `sudo tlp-stat -s`
- **Check live battery drain:** `upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'energy|capacity|state|rate'`
