# 🚀 Fullstack Dev Quick Reference

🎯 Philosophy: Use Tmux for all multi-terminal workflows, not terminal emulator panes

## Essential Shortcuts

### Tmux (Prefix: `Ctrl+A`) - PRIMARY WORKFLOW

```bash
# Sessions (persistent workspaces)
tmux new -s name    Create new session
tmux ls             List sessions
tmux attach -t name Attach to session
Prefix + D          Detach from session
Prefix + S          Choose session

# Panes (split current window)
Ctrl+Shift+E        Split vertical (or Prefix + |)
Ctrl+Shift+O        Split horizontal (or Prefix + -)
Alt+H/J/K/L         Navigate panes (vim-style)
Prefix + Z          Zoom/unzoom pane
Prefix + X          Kill pane
Prefix + Q          Show pane numbers

# Windows (tabs in tmux)
Ctrl+Shift+T        New window
Alt+1-9             Jump to window 1-9
Alt+N/P             Next/Previous window
Prefix + ,          Rename window
Prefix + W          Choose window

# Layouts (auto-arrange panes)
Prefix + Alt+F      Fullstack layout (editor + server + logs)
Prefix + Alt+3      Three-column layout
Prefix + Alt+D      Docker monitoring layout
Prefix + Space      Cycle through layouts

# Popups (floating windows)
Prefix + G          Quick terminal popup
Prefix + Shift+G    Git status popup
Prefix + Ctrl+G     Lazygit popup
Prefix + Ctrl+D     Docker status popup

# Copy Mode (vim-style)
Prefix + [          Enter copy mode
v                   Begin selection
y                   Copy selection
Prefix + ]          Paste

# Useful
Prefix + R          Reload tmux config
Prefix + Shift+S    Sync panes (send to all)
```

### Wezterm (Terminal Emulator)

Note: Use tmux for splitting/multi-terminal, wezterm just for tabs

```bash
# Tabs (multiple tmux sessions)
Cmd+T          New tab (start new tmux session here)
Cmd+W          Close tab
Cmd+1-9        Jump to tab
Cmd+[/]        Next/Previous tab

# Utilities
Cmd+F          Search in terminal
Cmd+Shift+P    Command palette
Cmd+K          Clear scrollback
```

## Quick Commands

### Git Workflow

```bash
gaa              # git add --all
gcam "msg"       # git commit -a -m "msg"
gp               # git push
gpf              # git push --force-with-lease
gcb name         # git checkout -b name
gnew name        # Create branch from main
glg              # Pretty log graph
```

### Docker

```bash
dcu              # docker-compose up
dcud             # docker-compose up -d
dcd              # docker-compose down
dclf             # docker-compose logs -f
dclean           # Clean all Docker resources
dsh container    # Shell into container
```

### Node.js

```bash
ni               # npm install
nrd              # npm run dev
nrb              # npm run build
nrt              # npm run test

# Same for yarn (y*) and pnpm (p*)
```

### Python

```bash
venvnew          # Create and activate venv
djr              # Django runserver
djm              # Django migrate
djmm             # Django makemigrations
djmmm            # makemigrations + migrate
```

### Project Creation

```bash
cnext my-app     # Next.js with TypeScript
cvite my-app     # Vite
ct3 my-app       # T3 Stack
djstart my-app   # Django
fapistart my-api # FastAPI
```

### Utilities

```bash
killport 3000    # Kill process on port
ports            # List open ports
serve 8000       # HTTP server
devsetup         # Check dev tools
npmscripts       # Show package.json scripts
```

### Search & Navigation

```bash
Ctrl+T           # Fuzzy file search (FZF)
Ctrl+R           # Fuzzy history search
Alt+C            # Fuzzy directory search
z project        # Jump to directory (zoxide)
ff pattern       # Find files
fdir pattern     # Find directories
```

## Common Workflows

### Start New Fullstack Project (Tmux-First)

```bash
# Create and enter project
cnext my-app && cd my-app

# Start tmux session
tmux new -s my-app

# Apply fullstack layout: Ctrl+A then Alt+F
# This creates 3 panes automatically:
# - Left (70%): Main workspace
# - Right-Top (15%): Dev server
# - Right-Bottom (15%): Git/logs

# In each pane:
# Pane 1: nvim .
# Pane 2: npm run dev
# Pane 3: git status && echo "Ready!"

# Navigate: Alt+H/J/K/L
# Detach: Ctrl+A then D
# Reattach later: tmux attach -t my-app
```

### Docker Development (Tmux)

```bash
cd project

# Start tmux with docker layout
tmux new -s project
# Press: Ctrl+A then Alt+D

# Auto-creates docker monitoring panes:
# - Left: Main workspace
# - Right-Top: docker ps -a
# - Right-Bottom: docker stats

dcud  # Start containers
dclf  # In another pane, follow logs
```

### Microservices (Multiple Windows)

```bash
# Start session
tmux new -s microservices

# Create window for each service
Ctrl+Shift+T  # New window
# Rename: Ctrl+A then ,

# Example:
# Window 1: api-gateway
# Window 2: auth-service  
# Window 3: user-service
# Window 4: docker-compose

# Switch: Alt+1, Alt+2, Alt+3, Alt+4
# Or: Ctrl+A then W (choose window)
```

### Full Day Workflow

```bash
# Morning: Start/resume work
tmux attach -t project || tmux new -s project

# Split for different tasks
Ctrl+Shift+E  # Vertical split
Ctrl+Shift+O  # Horizontal split

# Lunch: Detach (keeps everything running)
Ctrl+A then D

# Afternoon: Reattach (everything as you left it)
tmux attach -t project

# Evening: Sessions auto-save every 15min
# Just close terminal, everything persists!

# Next day: Resume exactly where you left off
tmux attach -t project
```

### Docker Development

```bash
cd project
tmux new -s project
# Press: Ctrl+A then Alt+D (docker layout)
dcud  # Start containers
dclf  # Follow logs
```

### Quick Git Push

```bash
gaa
gcam "feature: add new component"
gp
```

### Clean Development Environment

```bash
dclean           # Docker cleanup
npm cache clean --force
rm -rf node_modules && ni
```

## Tips

1. **Learn the prefix**: `Ctrl+A` is your tmux gateway
2. **Use FZF**: `Ctrl+R` for history is a game-changer
3. **Layouts**: Automate your workspace setup
4. **Aliases**: Type less, do more
5. **Session persistence**: Tmux saves every 15min

## Help

```bash
devsetup         # Check installed tools
cat docs/SETUP_GUIDE.md  # Full documentation
tmux list-keys   # All tmux bindings
```
