# 🚀 Fonger's Fullstack Development Dotfiles

> A comprehensive, production-ready development environment for fullstack engineers

**Optimized for:** Node.js, Python, Go, Rust, Docker, Kubernetes, and modern web development

---

## ✨ Features

- 🎨 **Beautiful terminal setup** with Catppuccin Mocha theme
- ⚡ **Fast shell startup** with lazy-loaded components
- 🔧 **Comprehensive aliases** for Git, Docker, Node.js, Python, and more
- 📦 **Smart package manager** integration (npm, yarn, pnpm, bun)
- 🐳 **Docker-first** workflow with power commands
- 🎯 **Tmux-centric multi-terminal** workflow with vim-style navigation
- 💻 **Pre-configured tmux layouts** for different dev scenarios
- 🔍 **Fuzzy finding** with FZF integration
- 📊 **Persistent session management** with automatic save/restore
- 🛠️ **Quick project initialization** for popular frameworks

---

## 📦 What's Included

### Core Configurations

| File | Description |
|------|-------------|
| `.zshrc` | Enhanced Zsh with Oh-My-Zsh, plugins, aliases, and custom functions |
| `.tmux.conf` | **Primary workspace manager** - Tmux with vim navigation, layouts, and session persistence |
| `wezterm.lua` | Terminal emulator with theme and basic keybindings (use tmux for panes/windows) |
| `starship.toml` | Starship prompt configuration |
| `nvim/` | Neovim configuration with LSP, treesitter, and plugins |

### Documentation

| File | Description |
|------|-------------|
| `SETUP_GUIDE.md` | Comprehensive setup and usage guide |
| `QUICK_REFERENCE.md` | Quick reference cheat sheet |
| `TMUX_GUIDE.md` | **Complete tmux guide** - Your primary workspace tool |
| `install.sh` | Automated installation script |

---

## 🚀 Quick Start

### Prerequisites

- macOS (or Linux with minor modifications)
- [Homebrew](https://brew.sh/) installed
- Basic command line knowledge

### Installation

```bash
# Clone the repository
git clone https://github.com/fonger900/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the installation script
chmod +x install.sh
./install.sh

# Restart your terminal
exec zsh
```

That's it! Your development environment is ready. 🎉

---

## 📖 Documentation

- **[Setup Guide](SETUP_GUIDE.md)** - Complete installation and configuration guide
- **[Tmux Guide](TMUX_GUIDE.md)** - **START HERE** - Your primary multi-terminal workspace
- **[Quick Reference](QUICK_REFERENCE.md)** - Essential shortcuts and commands
- **[Neovim Guide](nvim/README.md)** - Neovim-specific documentation

---

## 🎯 Key Highlights

### Intelligent Shell Configuration

```bash
# Lazy-loaded NVM for fast startup
# Organized PATH management
# Smart completion system
# History optimization (100k lines, dedup, timestamps)
```

### Power Aliases

```bash
# Git shortcuts
gaa && gcam "msg" && gp     # Add, commit, push in one line

# Docker shortcuts  
dcud                         # docker-compose up -d
dclf                         # Follow logs

# Quick project creation
cnext my-app                 # Next.js + TypeScript + Tailwind
cvite my-app                 # Vite
djstart my-project           # Django
```

### Tmux-First Multi-Terminal Philosophy

**Why Tmux over terminal panes?**

- ✅ **Persistent sessions** - Detach/reattach anytime, survives terminal crashes
- ✅ **Universal** - Works in any terminal (wezterm, iTerm, Terminal.app)
- ✅ **Session management** - Auto-saves every 15 min, resume days later
- ✅ **Named sessions** - `tmux attach -t project-name`
- ✅ **Remote-friendly** - SSH into servers and maintain sessions
- ✅ **Powerful layouts** - Pre-configured for different workflows

**Basic workflow:**

```bash
# Start named session
tmux new -s myproject

# Use tmux splits, not terminal splits
Ctrl+Shift+E  # Split vertical
Ctrl+Shift+O  # Split horizontal
Alt+H/J/K/L   # Navigate

# Detach (keeps running)
Ctrl+A then D

# Reattach later
tmux attach -t myproject
```

### Smart Tmux Layouts

Press `Ctrl+A` then:

- `Alt+F` - Fullstack layout (editor + server + logs)
- `Alt+3` - Three-column layout (code + terminal + docs)
- `Alt+D` - Docker monitoring (main + ps + stats)

### Development Functions

```bash
killport 3000        # Kill process on port 3000
serve 8000           # Quick HTTP server
devsetup             # Check installed dev tools
npmscripts           # View package.json scripts
dsh container        # Shell into Docker container
```

---

## 🛠️ Recommended Tools

Install these for the best experience:

```bash
brew install \
  fzf \           # Fuzzy finder
  ripgrep \       # Fast search
  fd \            # Fast find
  bat \           # Better cat
  exa \           # Better ls
  zoxide \        # Smart cd
  starship \      # Shell prompt
  tmux \          # Terminal multiplexer
  neovim \        # Text editor
  lazygit \       # Git TUI
  lazydocker      # Docker TUI
```

---

## 🎨 Theme & Appearance

All configurations use the **Catppuccin Mocha** color scheme for consistency:

- Terminal: Wezterm with Catppuccin Mocha
- Tmux: Catppuccin status bar
- Shell: Starship prompt
- Editor: Neovim with Catppuccin theme

---

## 📚 Workflow Examples

### Starting a New Project

```bash
# Create Next.js project
cnext my-app
cd my-app

# Start tmux session with fullstack layout
tmux new -s my-app
# Press: Ctrl+A then Alt+F (creates 3-pane layout)

# Work in tmux panes (not terminal panes):
# Pane 1 (main): nvim .
# Pane 2 (right-top): npm run dev
# Pane 3 (right-bottom): git status

# Navigate between panes: Alt+H/J/K/L
# Detach: Ctrl+A then D
# Reattach: tmux attach -t my-app
```

### Docker Development

```bash
cd project
tmux new -s project
# Press: Ctrl+A then Alt+D (docker layout)

# Panes show: main workspace, docker ps, docker stats
dcud  # Start containers in detached mode
dclf  # Follow logs
```

### Microservices

```bash
# Use tmux windows for each service
tmux new -s microservices -n api-gateway
# Ctrl+A then C to create new window for each service
# Alt+1, Alt+2, Alt+3 to switch between them
```

---

## ⌨️ Essential Shortcuts

### Tmux (Prefix: `Ctrl+A`)

| Action | Shortcut |
|--------|----------|
| Split vertical | `Ctrl+Shift+E` |
| Split horizontal | `Ctrl+Shift+O` |
| Navigate panes | `Alt+H/J/K/L` |
| Zoom pane | `Prefix + Z` |
| New window | `Ctrl+Shift+T` |
| Jump to window | `Alt+1-9` |

### Wezterm

| Action | Shortcut |
|--------|----------|
| Split vertical | `Cmd+D` |
| Navigate panes | `Alt+H/J/K/L` |
| New tab | `Cmd+T` |
| Jump to tab | `Cmd+1-9` |
| Search | `Cmd+F` |

See [Quick Reference](QUICK_REFERENCE.md) for complete list.

---

## 🔧 Customization

### Add Personal Configurations

Create `~/.zshrc.local` for machine-specific settings:

```bash
# ~/.zshrc.local
export CUSTOM_VAR="value"
alias myalias="my command"
```

This file is sourced at the end of `.zshrc` and is git-ignored.

### Modify Existing Configs

All configurations are well-commented and organized into sections. Feel free to customize:

- `.zshrc` - Shell aliases, functions, environment variables
- `.tmux.conf` - Keybindings, layouts, plugins
- `wezterm.lua` - Theme, fonts, keybindings
- `starship.toml` - Prompt appearance

---

## 🐛 Troubleshooting

### Slow shell startup?

```bash
# NVM is already lazy-loaded
# Check what's taking time:
# Uncomment zprof lines in .zshrc
```

### Tmux plugins not working?

```bash
# In tmux, press: Ctrl+A then Shift+I
# Or reinstall: rm -rf ~/.tmux/plugins/tpm && git clone ...
```

### Colors not correct?

```bash
echo $TERM  # Should be: xterm-256color or screen-256color
```

See [Setup Guide](SETUP_GUIDE.md#troubleshooting) for more solutions.

---

## 🤝 Contributing

Suggestions and improvements are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

---

## 📝 License

MIT License - Feel free to use and modify as you wish.

---

## 🙏 Acknowledgments

Built with inspiration from:

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Starship](https://starship.rs/)
- [Wezterm](https://wezfurlong.org/wezterm/)
- [TPM](https://github.com/tmux-plugins/tpm)
