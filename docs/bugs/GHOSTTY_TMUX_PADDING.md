# 🐛 Bug: Unintended Bottom Padding in Ghostty with Tmux

## 🔍 Symptom
When using **Ghostty** with **Tmux**, the bottom status bar appears to have extra padding, making it look "detached" from the bottom of the window. This gap often appears to be larger than the specified `window-padding-y`.

## 🕵️ Cause: The Grid Remainder
This is not a bug in Tmux, but a result of how Ghostty handles **leftover pixels**. 

1.  **Grid vs. Pixels**: Most font sizes do not divide perfectly into the window's pixel height. 
2.  **The Remainder**: If your font is 20px high and your window is 1010px, there is a **10px remainder**.
3.  **The "Balance" Setting**: When `window-padding-balance = true` is set, Ghostty takes that 10px remainder and splits it: **5px at the top** and **5px at the bottom**.
4.  **The Stacking**: This 5px remainder is **added** to your `window-padding-y`. If your padding is 6, the bottom effectively becomes **11px** (6 + 5), causing the Tmux bar to float too high.

---

## ✅ Solution 1: Pin to Top (Asymmetric)
This is the most common fix. It tells Ghostty to put all "garbage" pixels at the bottom, keeping the top padding exactly as specified.

```bash
# ghostty.config
window-padding-y = 6
window-padding-balance = false
```

*   **Result**: The top gap is exactly 6px. The bottom gap will be 6px + all remaining pixels. While technically larger at the bottom, the **fixed anchor at the top** makes the terminal feel more stable.

---

## ✅ Solution 2: Pixel-Perfect Snap (Beautiful)
This is the cleanest solution. It forces the window to only resize in increments of exactly one character height, so there is **never a remainder**.

```bash
# ghostty.config
window-padding-y = 6
window-padding-balance = true  # Optional, but safe now
window-step-resize = true      # The key setting
```

*   **Result**: The window will "snap" as you resize it. There will be exactly 6px at the top and 6px at the bottom, with **zero** leftover pixels.

---

## 🛠️ Verification
After applying either fix, reload your Ghostty config (`Cmd + ,` or restart) and check the Tmux status bar. It should now sit flush with the bottom padding.
