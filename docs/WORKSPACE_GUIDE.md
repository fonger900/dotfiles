# 🚀 Fullstack Dev Workspace Guide

🎯 **Philosophy**: Use Tmux as your primary workspace manager. It provides persistence, portability, and powerful layouts that terminal emulators alone cannot match.

---

## 🏗️ The Tmux Workflow

Tmux is the heart of this development environment. It keeps your sessions alive and your workspace organized.

### Core Concepts

1.  **Sessions**: One per project (e.g., `shop-frontend`, `api-backend`).
2.  **Windows**: Contexts within a project (e.g., `1:Code`, `2:Tests`, `3:Docker`).
3.  **Panes**: Splits within a window for side-by-side work.

### Essential Keybindings

**Prefix Key: `Ctrl+A`**

| Action | Shortcut |
|--------|----------|
| **Panes** | |
| Split vertical | `Ctrl+Shift+E` or `Prefix + |` |
| Split horizontal | `Ctrl+Shift+O` or `Prefix + -` |
| Navigate (vim-style) | `Alt+H/J/K/L` (No prefix!) |
| Zoom/Unzoom | `Prefix + Z` |
| Kill pane | `Prefix + X` |
| **Windows** | |
| New window | `Ctrl+Shift+T` or `Prefix + C` |
| Jump to window 1-9 | `Alt+1-9` (No prefix!) |
| Rename window | `Prefix + ,` |
| Choose window | `Prefix + W` |
| **Sessions** | |
| Choose session | `Prefix + S` |
| Detach session | `Prefix + D` |

### Floating Popups (Tmux 3.2+)

Quick windows for temporary tasks without splitting your layout:

| Action | Shortcut |
|--------|----------|
| Quick Terminal | `Prefix + G` |
| Git Status | `Prefix + Shift+G` |
| Lazygit | `Prefix + Ctrl+G` |
| Docker Status | `Prefix + Ctrl+D` |

---

## 📐 Pre-configured Layouts

Apply these to instantly set up your workspace for specific tasks.

### Fullstack Layout (`Prefix + Alt+F`)
**Best for**: Web development with a live server.
- **Left**: Main Editor (Neovim)
- **Top-Right**: Dev Server (`npm run dev`)
- **Bottom-Right**: Git/Logs

### Docker Layout (`Prefix + Alt+D`)
**Best for**: Container-heavy development.
- **Left**: Workspace
- **Top-Right**: `docker ps -a`
- **Bottom-Right**: `docker stats`

### Three-Column Layout (`Prefix + Alt+3`)
**Best for**: Comparing code, docs, and terminal output.

---

## 💻 Integrated Neovim Terminals

While Tmux is for workspace management, Neovim's internal terminals are for editor-integrated tasks.

| Action | Keymap | System |
|--------|--------|--------|
| Quick Terminal | `<C-/>` | **Snacks**: For one-off commands (ls, git add) |
| Persistent Term | `<leader>tt` | **ToggleTerm**: For long-running processes |
| Specific Term | `:ToggleTerm 1`| **ToggleTerm**: Switch to a numbered instance |

### Recommended Strategy
1.  **Use Tmux Panes** for the "Big Three": Editor, main Dev Server, and global Logs.
2.  **Use Neovim Terminals** for task-local actions: Running a specific test, installing a package, or quick git commits.

---

## 🔄 Real-World Workflows

### Starting Your Day
```bash
# Attach to yesterday's session or start fresh
tmux attach -t project || tmux new -s project
```

### Context Switching
Instead of opening new terminal tabs, use **Tmux Windows** (`Alt+1-9`):
- `Alt+1`: Code & Dev Server
- `Alt+2`: Database Client / Docker Compose
- `Alt+3`: Documentation / Scratchpad

### Remote Development
If working over SSH, your Tmux session persists even if your connection drops. Simply reconnect and run `tmux attach` to find everything exactly as you left it.

---

## 🛠️ Troubleshooting

- **Colors look wrong?** Ensure `echo $TERM` returns `screen-256color` or `tmux-256color`.
- **Prefix not working?** Double-check that you are using `Ctrl+A`.
- **Sessions not restoring?** Manually trigger a restore with `Prefix + Ctrl+R`.

---

**Next Step**: See the [Cheat Sheet](./QUICK_REFERENCE.md) for a condensed list of all commands.
