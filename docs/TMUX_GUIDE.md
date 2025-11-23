# 🚀 Tmux Guide for Fullstack Development

## Why Tmux?

Tmux is your **primary multi-terminal solution**. Use it instead of terminal emulator panes/splits.

### Advantages

- ✅ **Persistent** - Sessions survive terminal crashes and restarts
- ✅ **Resumable** - Close laptop, come back days later, everything's there
- ✅ **Auto-saved** - Every 15 minutes automatically
- ✅ **Named sessions** - `frontend`, `backend`, `devops` - organize by project
- ✅ **Universal** - Works in any terminal, even over SSH
- ✅ **Powerful** - Pre-configured layouts, popup windows, sync mode

## Quick Start

### Basic Session Management

```bash
# Create new session
tmux new -s project-name

# List all sessions
tmux ls

# Attach to existing session
tmux attach -t project-name

# Detach from current session
Ctrl+A then D

# Kill session
tmux kill-session -t project-name

# Switch between sessions
Ctrl+A then S
```

## Core Concepts

### Sessions

Your workspace. Each project gets its own session.

```bash
tmux new -s frontend    # Frontend project
tmux new -s backend     # Backend project
tmux new -s infra       # DevOps/infrastructure
```

### Windows (tabs)

Different contexts within a project.

```bash
# Window 1: Code
# Window 2: Tests
# Window 3: Docker/servers
# Window 4: Logs
```

### Panes

Split windows for side-by-side work.

```bash
# Split current window
Ctrl+Shift+E    # Vertical split
Ctrl+Shift+O    # Horizontal split
```

## Essential Keybindings

**Prefix Key: `Ctrl+A`** (instead of default `Ctrl+B`)

### Panes (splits)

| Action | Shortcut |
|--------|----------|
| Split vertical | `Ctrl+Shift+E` or `Prefix + \|` |
| Split horizontal | `Ctrl+Shift+O` or `Prefix + -` |
| Navigate left | `Alt+H` |
| Navigate down | `Alt+J` |
| Navigate up | `Alt+K` |
| Navigate right | `Alt+L` |
| Zoom pane | `Prefix + Z` |
| Kill pane | `Prefix + X` |
| Show pane numbers | `Prefix + Q` |
| Resize left | `Prefix + H` (hold) |
| Resize down | `Prefix + J` (hold) |
| Resize up | `Prefix + K` (hold) |
| Resize right | `Prefix + L` (hold) |

### Windows (tabs)

| Action | Shortcut |
|--------|----------|
| New window | `Ctrl+Shift+T` or `Prefix + C` |
| Jump to window 1-9 | `Alt+1` to `Alt+9` |
| Next window | `Alt+N` or `Prefix + N` |
| Previous window | `Alt+P` or `Prefix + P` |
| Rename window | `Prefix + ,` |
| Kill window | `Prefix + X` |
| Choose window | `Prefix + W` |

### Sessions

| Action | Shortcut |
|--------|----------|
| Choose session | `Prefix + S` |
| Detach | `Prefix + D` |
| Switch to last | `Prefix + L` |

### Copy Mode (vim-style)

| Action | Shortcut |
|--------|----------|
| Enter copy mode | `Prefix + [` |
| Start selection | `V` |
| Copy selection | `Y` |
| Paste | `Prefix + ]` |
| Search up | `?` |
| Search down | `/` |
| Quit | `Q` or `Escape` |

## Pre-configured Layouts

### Fullstack Layout (`Prefix + Alt+F`)

```
┌────────────────┬─────────┐
│                │ Server  │
│                │ (npm)   │
│    Editor      ├─────────┤
│    (nvim)      │ Git/    │
│                │ Logs    │
└────────────────┴─────────┘
```

**Use case:** Web development with live server and git monitoring

```bash
# Start session and apply layout
tmux new -s myapp
# Press: Ctrl+A then Alt+F

# In each pane:
nvim .              # Left pane
npm run dev         # Top-right pane
git status          # Bottom-right pane
```

### Three-Column Layout (`Prefix + Alt+3`)

```
┌──────┬──────┬──────┐
│      │      │      │
│ Code │ Term │ Docs │
│      │      │      │
└──────┴──────┴──────┘
```

**Use case:** Code + terminal + documentation/browser

### Docker Layout (`Prefix + Alt+D`)

```
┌────────────────┬─────────┐
│                │ docker  │
│                │ ps -a   │
│   Workspace    ├─────────┤
│                │ docker  │
│                │ stats   │
└────────────────┴─────────┘
```

**Use case:** Docker development with live monitoring

```bash
# Automatically runs:
# - docker ps -a (top-right)
# - docker stats (bottom-right)
```

## Popup Windows (Tmux 3.2+)

Quick floating windows for temporary tasks:

| Action | Shortcut |
|--------|----------|
| Quick terminal | `Prefix + G` |
| Git status | `Prefix + Shift+G` |
| Lazygit | `Prefix + Ctrl+G` |
| Docker status | `Prefix + Ctrl+D` |

**Usage:** Check something quickly without switching panes

## Advanced Features

### Synchronized Panes

Send the same command to all panes:

```bash
# Toggle sync
Prefix + Shift+S

# Now typing in one pane types in all
# Useful for: updating multiple servers, running same command
```

### Session Save/Restore

**Automatic** (via tmux-resurrect + continuum):

- Auto-saves every 15 minutes
- Survives system restarts
- Restores on boot

**Manual:**

```bash
Prefix + Ctrl+S    # Save now
Prefix + Ctrl+R    # Restore
```

### Nested Sessions (SSH)

Working on remote server? Toggle bindings:

```bash
F12    # Disable local tmux, control remote tmux
F12    # Re-enable local tmux
```

## Real-World Workflows

### Workflow 1: Fullstack Web App

```bash
# Start session
tmux new -s webapp

# Apply fullstack layout
Ctrl+A then Alt+F

# Left pane: Editor
nvim .

# Right-top: Frontend dev server
cd frontend && npm run dev

# Right-bottom: Backend server
cd ../backend && npm run dev

# Create new window for database
Ctrl+Shift+T
docker-compose up postgres

# Switch between windows
Alt+1    # Code + servers
Alt+2    # Database
```

### Workflow 2: Microservices

```bash
# Start session
tmux new -s microservices

# Window per service
Ctrl+Shift+T    # Create windows
Prefix + ,      # Rename each

# Layout:
# Window 1 (Alt+1): api-gateway
# Window 2 (Alt+2): auth-service
# Window 3 (Alt+3): user-service
# Window 4 (Alt+4): order-service
# Window 5 (Alt+5): docker-compose

# In each service window, split for logs
Ctrl+Shift+E
# Top: npm run dev
# Bottom: npm run logs
```

### Workflow 3: Remote Server

```bash
# Local machine: Start tmux
tmux new -s local

# SSH into server
ssh user@server

# On server: Attach/create tmux
tmux attach -t deploy || tmux new -s deploy

# Work on server in tmux
# Ctrl+A then D to detach

# Connection drops? No problem!
# Reconnect and: tmux attach -t deploy

# Back to local tmux: F12 to toggle bindings
```

### Workflow 4: Daily Development

```bash
# Morning: Resume where you left off
tmux attach -t project

# Lunch: Detach (everything keeps running)
Ctrl+A then D

# Afternoon: Reattach
tmux attach -t project

# End of day: Just close terminal
# Auto-saves every 15 min, persists across reboots

# Next morning: Everything's exactly as you left it
tmux attach -t project
```

## Tips & Best Practices

### 1. Name Your Sessions

```bash
# Good
tmux new -s frontend
tmux new -s api-backend
tmux new -s infra

# Not helpful
tmux new    # Creates session "0", "1", etc.
```

### 2. One Session Per Project

```bash
~/projects/shop-frontend  → tmux session: shop-frontend
~/projects/shop-backend   → tmux session: shop-backend
~/devops                  → tmux session: infra
```

### 3. Use Windows for Contexts

Within a session:

- Window 1: Code
- Window 2: Tests running
- Window 3: Dev servers
- Window 4: Docker/logs
- Window 5: Database client

### 4. Detach, Don't Close

```bash
# ✅ Good: Detach
Ctrl+A then D

# ❌ Avoid: Killing session
# Only kill when truly done with project
```

### 5. Navigate with Keyboard

```bash
# Panes: Alt+H/J/K/L (no prefix needed)
# Windows: Alt+1-9 (no prefix needed)
# Sessions: Ctrl+A then S
```

### 6. Use Popups for Quick Checks

```bash
# Don't split a pane just to check git status
# Use popup instead
Prefix + Shift+G    # Quick git status
```

## Troubleshooting

### Colors look wrong

```bash
# Check TERM
echo $TERM    # Should be: screen-256color

# If in tmux and it's wrong
Ctrl+A then :
set -g default-terminal "screen-256color"
```

### Prefix not working

```bash
# Make sure you're pressing Ctrl+A (not Ctrl+B)
# Test it:
Ctrl+A then ?    # Should show help
```

### Sessions not restoring

```bash
# Check if tmux-resurrect is installed
ls ~/.tmux/plugins/tmux-resurrect

# Manual restore
Prefix + Ctrl+R
```

### Mouse not working

```bash
# Mouse should be enabled by default
# If not, add to ~/.tmux.conf:
set -g mouse on

# Then reload:
Prefix + R
```

## Useful Commands

```bash
# Session management
tmux ls                          # List sessions
tmux new -s name                 # New session
tmux attach -t name              # Attach
tmux kill-session -t name        # Kill session
tmux kill-server                 # Kill all sessions

# Window management  
tmux new-window -n name          # New window with name
tmux list-windows                # List windows
tmux select-window -t 1          # Switch to window 1

# Pane management
tmux split-window -h             # Horizontal split
tmux split-window -v             # Vertical split
tmux list-panes                  # List panes
tmux select-pane -t 1            # Switch to pane 1

# Configuration
tmux show-options -g             # Show options
tmux source-file ~/.tmux.conf    # Reload config
```

## Cheat Sheet Summary

**Most Used:**

```
Ctrl+A then:
  D              Detach
  C              New window
  ,              Rename window
  W              Choose window
  S              Choose session
  Z              Zoom pane
  [              Copy mode
  R              Reload config

Without prefix:
  Ctrl+Shift+E   Split vertical
  Ctrl+Shift+O   Split horizontal
  Ctrl+Shift+T   New window
  Alt+H/J/K/L    Navigate panes
  Alt+1-9        Jump to window
```

## Resources

- Config file: `~/.tmux.conf`
- Plugins dir: `~/.tmux/plugins/`
- Sessions stored: `~/.tmux/resurrect/`
- Install plugins: `Ctrl+A then Shift+I`
- Update plugins: `Ctrl+A then Shift+U`

---

**Remember:** Tmux is your primary workspace manager. Use it for all multi-terminal work, not your terminal emulator's panes/splits. This gives you portability, persistence, and power! 🚀
