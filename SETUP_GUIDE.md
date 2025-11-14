# 🚀 Fullstack Development Environment Setup Guide

This guide will help you set up and use your refactored zsh, wezterm, and tmux configurations optimized for fullstack development.

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Configuration Overview](#configuration-overview)
4. [Key Features](#key-features)
5. [Keyboard Shortcuts](#keyboard-shortcuts)
6. [Development Workflows](#development-workflows)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Tools

```bash
# macOS (using Homebrew)
brew install \
  zsh \
  tmux \
  neovim \
  git \
  fzf \
  ripgrep \
  fd \
  bat \
  exa \
  zoxide \
  starship

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Optional but Recommended

```bash
# Development tools
brew install \
  node \
  python@3.11 \
  go \
  rust \
  docker \
  docker-compose \
  kubectl \
  terraform

# Version managers
brew install nvm pyenv

# Additional tools
brew install \
  lazygit \
  lazydocker \
  jq \
  yq \
  httpie \
  tldr
```

---

## Installation

1. **Clone or backup your dotfiles:**

```bash
cd ~
git clone <your-dotfiles-repo> dotfiles
cd dotfiles
```

2. **Run the installation script:**

```bash
chmod +x install.sh
./install.sh
```

3. **Install Tmux plugins:**

```bash
# Start tmux
tmux

# Press: Ctrl+a then Shift+I (capital i)
# Wait for plugins to install
```

4. **Reload your shell:**

```bash
source ~/.zshrc
```

---

## Configuration Overview

### `.zshrc` - Enhanced Zsh Configuration

**Key Improvements:**

- **Modular structure** with clear sections
- **Lazy loading** for NVM (faster startup)
- **Enhanced PATH management** using typeset
- **Comprehensive aliases** for all major tools
- **Custom functions** for common dev tasks
- **Better completion system**
- **Optimized plugin loading**

**Sections:**

1. Oh-My-Zsh configuration
2. Environment variables (XDG, editor, pager)
3. Path configuration (organized by priority)
4. Language-specific setups (Node, Python, Go, Rust, Deno)
5. Docker & database configuration
6. Development aliases (Git, Docker, Node, Python)
7. Custom functions
8. FZF, Zoxide, and Starship integration
9. Welcome message with version info

### `wezterm.lua` - Terminal Emulator Configuration

**Key Improvements:**

- **Smart tab titles** with process icons
- **Catppuccin Mocha** theme with custom colors
- **Enhanced key bindings** for productivity
- **Quick select patterns** (paths, hashes, IPs)
- **Launch menu** for quick project access
- **Hyperlink rules** for localhost URLs
- **Mouse bindings** for URL opening
- **Performance optimizations** (WebGPU, 120fps)

**Features:**

- Pane management matching tmux
- Tab navigation with CMD+number
- Search and copy mode
- Command palette access
- Window opacity and blur

### `.tmux.conf` - Terminal Multiplexer Configuration

**Key Improvements:**

- **Vim-style navigation** throughout
- **Development layouts** (fullstack, docker, 3-column)
- **Session management** with resurrect & continuum
- **Popup windows** for quick git/docker info
- **Enhanced status bar** with Catppuccin theme
- **Better mouse support**
- **Nested session handling**

**Features:**

- Smart pane navigation (works with nvim)
- Quick window switching with Alt+number
- Copy mode with vim bindings
- Synchronized panes for parallel commands
- Automatic session save/restore

---

## Key Features

### 🔥 Quick Project Initialization

```bash
# React with TypeScript
cra my-app

# Next.js with TypeScript & Tailwind
cnext my-app

# Vite
cvite my-app

# T3 Stack (Next.js + tRPC + Prisma)
ct3 my-app

# Django
djstart my-project

# FastAPI
fapistart my-api
```

### 🐳 Docker Power Commands

```bash
# Quick compose operations
dcu          # docker-compose up
dcud         # docker-compose up -d
dcd          # docker-compose down
dclf         # docker-compose logs -f

# Cleanup
dclean       # Clean all Docker resources
dcleanimg    # Clean images only
dprune       # System prune
```

### 🎯 Git Workflow Shortcuts

```bash
# Common operations
gaa          # git add --all
gcam         # git commit -a -m
gp           # git push
gpf          # git push --force-with-lease

# Branch management
gcb          # git checkout -b
gnew         # Checkout main, pull, create new branch

# Quick commits
gct "msg"    # Commit with timestamp
qpush "msg"  # Add, commit, and push

# Visual history
glg          # Pretty git log graph
```

### 🔍 Search & Navigation

```bash
# FZF fuzzy finding
Ctrl+T       # Fuzzy file search
Ctrl+R       # Fuzzy history search
Alt+C        # Fuzzy directory navigation

# Zoxide (smart cd)
z <dir>      # Jump to frequently used directory
zi           # Interactive directory selection

# Find files/directories
ff pattern   # Find files by name
fdir pattern # Find directories by name
```

### 🛠️ Development Utilities

```bash
# Port management
killport 3000        # Kill process on port 3000
ports                # List all open ports

# Quick server
serve 8000           # HTTP server on port 8000

# System info
devsetup             # Check installed dev tools
npmscripts           # Show package.json scripts

# Database connections
pgconnect mydb       # Connect to PostgreSQL
mongoconnect mydb    # Connect to MongoDB
redisconnect         # Connect to Redis
```

---

## Keyboard Shortcuts

### Wezterm

| Action | Shortcut |
|--------|----------|
| **Panes** | |
| Split vertical | `Ctrl+Shift+E` or `Cmd+D` |
| Split horizontal | `Ctrl+Shift+O` or `Cmd+Shift+D` |
| Navigate panes | `Alt+H/J/K/L` |
| Resize panes | `Ctrl+Shift+Arrow` |
| Close pane | `Cmd+W` |
| Zoom pane | `Ctrl+Shift+Z` |
| **Tabs** | |
| New tab | `Cmd+T` or `Ctrl+Shift+T` |
| Next/Prev tab | `Cmd+[` / `Cmd+]` |
| Jump to tab | `Cmd+1-9` |
| Move tab | `Cmd+Shift+[` / `Cmd+Shift+]` |
| **Search** | |
| Search | `Cmd+F` |
| Quick select | `Ctrl+Shift+Space` |
| Copy mode | `Ctrl+Shift+X` |
| **Other** | |
| Command palette | `Cmd+Shift+P` |
| Launcher | `Cmd+Shift+L` |
| Reload config | `Cmd+Shift+R` |

### Tmux

| Action | Shortcut |
|--------|----------|
| **Prefix** | `Ctrl+A` |
| **Panes** | |
| Split vertical | `Ctrl+Shift+E` or `Prefix + \|` |
| Split horizontal | `Ctrl+Shift+O` or `Prefix + -` |
| Navigate panes | `Alt+H/J/K/L` |
| Resize panes | `Prefix + H/J/K/L` (repeat) |
| Zoom pane | `Prefix + Z` |
| Kill pane | `Prefix + X` |
| **Windows** | |
| New window | `Ctrl+Shift+T` or `Prefix + C` |
| Next/Prev window | `Alt+N` / `Alt+P` |
| Jump to window | `Alt+1-9` |
| **Layouts** | |
| Fullstack layout | `Prefix + Alt+F` |
| 3-column layout | `Prefix + Alt+3` |
| Docker layout | `Prefix + Alt+D` |
| Reset layout | `Prefix + Alt+0` |
| **Popups** | |
| Quick terminal | `Prefix + G` |
| Git status | `Prefix + Shift+G` |
| Lazygit | `Prefix + Ctrl+G` |
| Docker status | `Prefix + Ctrl+D` |
| **Sessions** | |
| List sessions | `Prefix + S` |
| New session | `Prefix + Shift+S` |
| Detach | `Prefix + D` |
| **Other** | |
| Copy mode | `Prefix + [` or `Alt+[` |
| Reload config | `Prefix + R` |
| Sync panes | `Prefix + Shift+S` |

---

## Development Workflows

### Frontend Development Workflow

```bash
# 1. Create new project
cnext my-app
cd my-app

# 2. Start tmux session with layout
tmux new -s my-app
# Press: Ctrl+A then Alt+F (fullstack layout)

# 3. In panes:
# Pane 1 (main): Open editor
nvim .

# Pane 2 (right-top): Start dev server
npm run dev

# Pane 3 (right-bottom): Git operations
git status
```

### Backend Development Workflow (Python/Django)

```bash
# 1. Create Django project
djstart my-project
cd my-project

# 2. Setup virtual environment
python3 -m venv venv
source venv/bin/activate

# 3. Start tmux with layout
tmux new -s my-project
# Press: Ctrl+A then Alt+F

# 4. In panes:
# Pane 1: Editor
nvim .

# Pane 2: Django dev server
djr

# Pane 3: Django shell or tests
djs
```

### Fullstack with Docker Workflow

```bash
# 1. Navigate to project
cd ~/Projects/my-fullstack-app

# 2. Start tmux with Docker layout
tmux new -s fullstack
# Press: Ctrl+A then Alt+D (docker layout)

# 3. Panes auto-configured:
# Pane 1: Your workspace
# Pane 2: docker ps -a (monitoring)
# Pane 3: docker stats (resources)

# 4. In main pane:
dcud  # Start docker-compose in detached mode
dclf  # Follow logs
```

### Microservices Development

```bash
# Use tmux windows for each service

# Window 1: API Gateway
tmux new -s microservices -n gateway
cd ~/Projects/api-gateway
npm run dev

# Window 2: Auth Service (Ctrl+A then C)
cd ~/Projects/auth-service
npm run dev

# Window 3: User Service
cd ~/Projects/user-service
npm run dev

# Window 4: Database & Docker
docker-compose up postgres redis

# Navigate: Alt+1, Alt+2, Alt+3, Alt+4
```

---

## Troubleshooting

### Zsh is slow to start

```bash
# Enable profiling
# Uncomment at top of .zshrc:
# zmodload zsh/zprof

# Reload and check
source ~/.zshrc

# At end of output, uncomment:
# zprof

# Common fixes:
# 1. NVM is lazy-loaded by default
# 2. Reduce Oh-My-Zsh plugins
# 3. Check completion cache
```

### Tmux plugins not working

```bash
# Reinstall TPM
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux, press: Ctrl+A then Shift+I
```

### Colors not working correctly

```bash
# Check terminal type
echo $TERM

# Should be: screen-256color (in tmux) or xterm-256color

# Add to .zshrc if needed:
export TERM=xterm-256color
```

### Key bindings not working in tmux

```bash
# Check if keys are bound
tmux list-keys | grep <your-key>

# Reload config
tmux source-file ~/.tmux.conf

# Or in tmux: Ctrl+A then R
```

### NVM commands not found

```bash
# Manually load NVM
load_nvm

# Or add to .zshrc for immediate loading:
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

---

## Tips & Best Practices

1. **Use tmux sessions for projects**: `tmux new -s project-name`
2. **Leverage layouts**: Press `Prefix + Alt+F` for quick fullstack setup
3. **Use FZF extensively**: `Ctrl+R` for command history is a game-changer
4. **Learn vim motions**: They work everywhere (tmux copy mode, nvim, etc.)
5. **Customize**: Add your own functions to `~/.zshrc.local`
6. **Session persistence**: Tmux auto-saves every 15 minutes
7. **Docker cleanup**: Run `dclean` weekly to free up space
8. **Git aliases**: Master `gaa`, `gcam`, `gp` workflow

---

## Additional Resources

- [Wezterm Documentation](https://wezfurlong.org/wezterm/)
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [Oh-My-Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [Starship Prompt](https://starship.rs/)
- [FZF Examples](https://github.com/junegunn/fzf#examples)

---

**Happy coding! 🚀**
