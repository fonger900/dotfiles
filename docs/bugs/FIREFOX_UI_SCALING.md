# 🦊 Firefox UI Scaling (Small Address Bar)

## Issue
On high-density displays (like the ThinkPad T14 1080p panel), the Firefox ESR address bar, tabs, and menu items may appear too small, even if system-wide GTK scaling (`GDK_DPI_SCALE`) is set. This happens because `GDK_DPI_SCALE` primarily affects font rendering, while Firefox's internal UI elements scale independently.

## Solution

### 1. Internal Firefox Scaling (Most Reliable)
This scales the entire browser UI (chrome) and web content proportionally.

1.  Open Firefox and navigate to `about:config`.
2.  Search for **`layout.css.devPixelsPerPx`**.
3.  The default value is `-1.0` (follows system).
4.  Change it to a positive value like **`1.25`** or **`1.5`** until the UI feels comfortable.

### 2. Environment Variables
Ensure these are set in `zsh/exports.zsh` (already included in these dotfiles):

```bash
export GDK_SCALE=1
export GDK_DPI_SCALE=1.25
export MOZ_ENABLE_WAYLAND=1
```

*Note: If `GDK_DPI_SCALE` is increased significantly, you may need to reduce the `layout.css.devPixelsPerPx` value to avoid "double scaling".*

## Verification
- Address bar should be easily clickable.
- Extension icons in the toolbar should be clear and properly sized.
- Tab text should match the scaling of other system applications.
