# Technical Deep Dive: EasyEffects Audio Persistence Issue

This document explains why audio is frequently "lost" when turning off EasyEffects on Linux systems using PipeWire/WirePlumber, and how the custom toggle script resolves it.

## The Problem

When EasyEffects is active, it creates a **Virtual Sink** (a software-based audio destination). All system audio is typically routed through this virtual sink so that effects (EQ, Compression, etc.) can be applied before the audio is sent to your actual hardware speakers.

The "Loss of Sound" bug occurs due to three main factors:

### 1. "Sticky" Stream Preferences
WirePlumber (the session manager for PipeWire) maintains a database of user preferences. If you play audio from an application (e.g., Firefox) while EasyEffects is on, WirePlumber "remembers" that Firefox prefers the EasyEffects Sink.

When you turn off EasyEffects:
1. The Virtual Sink is destroyed.
2. The "Sticky" preference in WirePlumber's database still points to the (now non-existent) EasyEffects Sink.
3. When you start a **new** video or stream, WirePlumber tries to connect it to the ghost sink.
4. Because the target doesn't exist, the audio stream is left "unrouted," resulting in silence.

### 2. Atomic Disconnection
If an application is currently playing audio when its output device (the EasyEffects sink) is suddenly deleted, the application's audio engine may hang or enter an error state. It doesn't always have the "fail-safe" logic to immediately search for a new hardware output.

### 3. Default Sink Lag
Even if you change the "Default Sink" globally, WirePlumber's per-application preferences often take priority over the global default. This is why a new YouTube video might still be silent even if your system settings show the hardware speakers are "Default."

---

## The Solution: `easyeffects-toggle.sh`

The custom toggle script prevents these issues by performing a "clean handoff" between the virtual and hardware layers.

### Step-by-Step Logic:

1. **Hardware Identification**: The script identifies your physical hardware (e.g., `alsa_output.pci...`) by name rather than temporary ID numbers.
2. **Preference Reset**: Before EasyEffects is allowed to quit, the script explicitly sets the Hardware Sink as the default for both **PipeWire** (`wpctl`) and **PulseAudio** (`pactl`).
3. **Active Migration**: It force-moves every active audio stream to the hardware sink while the EasyEffects sink still exists. This "graceful migration" prevents the application engines from hanging.
4. **Cleanup Delay**: After EasyEffects quits, the script waits a fraction of a second and runs a second migration pass to catch any streams that might have been created during the shutdown process.

### Best Practice
To ensure this cleanup logic runs every time, always use the **Waybar Toggle** rather than the "Quit" button inside the EasyEffects application window.
