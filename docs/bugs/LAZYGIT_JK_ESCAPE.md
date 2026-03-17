# 🐛 Bug: Cursor Escape from Lazygit Overlay (jk/jj)

## 🔍 Symptom
When using **Lazygit** inside Neovim (via `Snacks.lazygit()`), attempting to navigate quickly by holding `j` and then pressing `k` (or typing `jj`) causes the cursor to suddenly "escape" the Lazygit terminal overlay and jump back into the background editor buffer.

This makes it impossible to use common "fast exit" chord mappings while working within the Lazygit TUI.

## 🕵️ Cause: Global Terminal Escapes
The issue was caused by the **`better-escape.nvim`** plugin. 

1.  **Default Mappings**: By default, `better-escape.nvim` sets up `jk`, `jj`, and other "quick escape" mappings across **all modes**, including Terminal mode (`t`).
2.  **Terminal Mode Behavior**: In Neovim, terminal mode mappings (`tnoremap`) take precedence. When `jk` is typed, the plugin intercepts it and sends `<Esc>`, which Neovim interprets as a request to leave terminal mode.
3.  **Overlay Conflict**: Since Lazygit is running in a floating terminal window, escaping terminal mode causes the focus to shift back to the underlying editor buffer, effectively "breaking" the Lazygit session's interactivity.

---

## ✅ Solution: Disable in Terminal Mode
The fix involves explicitly configuring `better-escape.nvim` to **disable all mappings in terminal mode**. This ensures that chords like `jk` are passed directly to the TUI application (Lazygit) rather than being intercepted by Neovim.

Update the `better-escape.nvim` configuration in `nvim/.config/nvim/lua/plugins/editor.lua`:

```lua
-- nvim/.config/nvim/lua/plugins/editor.lua
{
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  opts = {
    default_mappings = false,
    mappings = {
      i = { j = { k = "<Esc>", j = "<Esc>" } }, -- Insert mode (Keep)
      c = { j = { k = "<Esc>", j = "<Esc>" } }, -- Command mode (Keep)
      t = {},                                   -- Terminal mode (DISABLE)
      v = { j = { k = "<Esc>" } },             -- Visual mode (Keep)
      s = { j = { k = "<Esc>" } },             -- Select mode (Keep)
    },
  },
}
```

*   **Result**: `jk` and `jj` continue to work as escape chords in Insert and Command modes, but are ignored in Terminal mode, allowing Lazygit to function normally.

---

## 🛠️ Verification
1.  Open Neovim.
2.  Launch Lazygit using `<leader>gg`.
3.  Navigate the list of files or commits.
4.  Type `jk` or `jj` rapidly.
5.  **Pass**: The cursor remains inside Lazygit, and the `jk` characters are handled by Lazygit (usually just moving down and then up).
6.  **Fail**: The cursor jumps to the editor buffer, and Lazygit becomes non-interactive until re-entered.
