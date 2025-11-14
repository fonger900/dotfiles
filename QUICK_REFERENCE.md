# 🚀 Fullstack Dev Quick Reference

## Essential Shortcuts

### Tmux (Prefix: `Ctrl+A`)

```bash
# Panes
Ctrl+Shift+E    Split vertical
Ctrl+Shift+O    Split horizontal
Alt+H/J/K/L     Navigate panes
Prefix + Z      Zoom pane
Prefix + X      Kill pane

# Windows
Ctrl+Shift+T    New window
Alt+1-9         Jump to window
Alt+N/P         Next/Previous

# Layouts
Prefix + Alt+F  Fullstack layout (editor + server + logs)
Prefix + Alt+3  Three-column layout
Prefix + Alt+D  Docker monitoring layout

# Popups
Prefix + G      Quick terminal
Prefix + Shift+G  Git status
Prefix + Ctrl+G   Lazygit
Prefix + Ctrl+D   Docker status
```

### Wezterm

```bash
# Panes
Cmd+D          Split vertical
Cmd+Shift+D    Split horizontal
Alt+H/J/K/L    Navigate panes

# Tabs
Cmd+T          New tab
Cmd+1-9        Jump to tab
Cmd+[/]        Next/Previous tab

# Utilities
Cmd+F          Search
Cmd+Shift+P    Command palette
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

### Start New Fullstack Project

```bash
cnext my-app
cd my-app
tmux new -s my-app
# Press: Ctrl+A then Alt+F (fullstack layout)
# Pane 1: nvim .
# Pane 2: npm run dev
# Pane 3: git status
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
cat SETUP_GUIDE.md  # Full documentation
tmux list-keys   # All tmux bindings
```
