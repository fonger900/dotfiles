# 🌿 Shadow Garden Dotfiles - Fullstack Developer Edition

A comprehensive, modern terminal configuration optimized for fullstack development. Built with aesthetics, performance, and productivity in mind.

## 🎨 Philosophy

**Shadow Garden** theme provides a dark, elegant aesthetic with carefully chosen colors that reduce eye strain during long coding sessions while maintaining excellent readability and visual hierarchy.

**Colors:**

- 🟢 **Primary Green** (#7aa37a) - Success states, git clean, active elements
- 🟣 **Deep Purple** (#9f84bd) - Directories, special states, secondary actions  
- 🟡 **Warm Yellow** (#d1b56f) - Warnings, modifications, attention elements
- 🔵 **Cyan Accent** (#61dafb) - Modern tech stack, React/development focus

## 🚀 Overview

This dotfiles setup provides a complete development environment with:

### 🖥️ **Terminal Stack**

- **Shell**: Zsh with Oh My Zsh and comprehensive plugins
- **Prompt**: Starship with development context awareness
- **Terminal**: WezTerm with custom Shadow Garden theme
- **Multiplexer**: Tmux with DevStack Pro theme and developer shortcuts

### 🛠️ **Development Tools**

- **Editor**: Neovim with Lazy.nvim and full LSP support
- **Version Control**: Enhanced git aliases and visual status
- **Package Managers**: Support for npm, yarn, pnpm, pip, cargo
- **Containers**: Docker and Docker Compose shortcuts and management
- **Cloud**: AWS, GCP, Azure integrations

### 📁 **Configuration Files**

```
dotfiles/
├── .zshrc                 # Fullstack-optimized shell configuration
├── .tmux.conf            # DevStack Pro theme with development shortcuts
├── starship.toml         # Intelligent prompt with project context
├── install.sh            # Automated setup script
├── nvim/                 # Complete Neovim IDE configuration
└── wezterm/              # Terminal emulator with Shadow Garden theme
```

## ✨ Key Features

### 🎯 **Productivity Enhancements**

- **Smart project detection** - Automatically identifies framework types
- **Git integration** - Visual status, metrics, and convenient aliases
- **Development shortcuts** - Quick access to common tools and tasks
- **Session management** - Tmux session persistence and restoration
- **Auto-completion** - Enhanced tab completion for all tools

### 🌐 **Fullstack Support**

- **Frontend**: React, Vue, Svelte, Next.js detection and tooling
- **Backend**: Node.js, Python, Rust, Go language support
- **Database**: Connection helpers and query tools
- **Infrastructure**: Docker, Kubernetes, Terraform integration
- **Cloud providers**: AWS, GCP, Azure context switching

### ⚡ **Performance Optimized**

- **Fast startup times** - Lazy loading and optimized configurations
- **Efficient workflows** - Vim-style navigation throughout
- **Resource monitoring** - Built-in system performance indicators
- **Quick switching** - Instant context changes between projects

## 🔧 **Shell Features (.zshrc)**

### **Enhanced Aliases**

```bash
# Git shortcuts
gs, ga, gc, gp, gd, gb, gl    # Common git operations
gcb, gst, gstp                # Branch and stash management

# Package managers  
ni/yi/pi + r/s/t/b/d          # npm/yarn/pnpm + run/start/test/build/dev

# Docker management
d, dc, dcu, dcd, dps, di      # Docker and compose shortcuts
dex, dlogs, dprune            # Container management

# Development servers
serve, ports, killport        # Quick server utilities
```

### **Smart Functions**

- `newreact/newnext/newvite` - Project scaffolding
- `gitclean` - Automated branch cleanup  
- `setupnode` - Initialize Node.js projects
- `search` - Codebase search excluding node_modules

## 🎨 **Visual Experience**

### **Starship Prompt**

- **Project context** - Shows current framework (React, Next.js, etc.)
- **Git intelligence** - Branch, status, metrics, clean/dirty indicators
- **Environment aware** - Virtual environments, Node versions
- **Performance metrics** - Command duration, background jobs

### **Tmux DevStack Theme**

- **Top status bar** - Git branch, system info, real-time clock
- **VS Code colors** - Consistent with popular editor themes
- **Development shortcuts** - Quick access to nvim, lazygit, lazydocker
- **Floating windows** - Popup terminals for quick tasks

## 🚀 **Quick Start**

```bash
# Clone the repository
git clone https://github.com/fonger900/dotfiles.git ~/dotfiles

# Run the setup script
cd ~/dotfiles
./install.sh

# Reload your shell
source ~/.zshrc

# Install tmux plugins (after tmux is running)
# Press Ctrl+A then I
```

## 🎯 **For Developers**

This configuration is specifically optimized for:

- **Full-stack JavaScript/TypeScript development**
- **Modern framework workflows** (React, Next.js, Vue)
- **Container-based development** (Docker, Kubernetes)
- **Multi-language projects** (Node.js, Python, Rust, Go)
- **Cloud-native applications** (AWS, GCP, Azure)
- **Git-centric workflows** with visual feedback

## 🌟 **Philosophy**

*"A terminal should be beautiful, fast, and stay out of your way while providing everything you need at your fingertips."*

The Shadow Garden theme creates a calming, focused environment that enhances long coding sessions while the comprehensive tooling ensures you have everything needed for modern development workflows.

---

*Built with 🌿 by a developer, for developers*
