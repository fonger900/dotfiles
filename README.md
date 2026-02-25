# 🚀 Fonger's Fullstack Development Dotfiles

> A comprehensive, production-ready development environment for fullstack engineers

**Optimized for:** Node.js, Python, Go, Rust, Docker, macOS Native Containers, Kubernetes, and modern web development

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

This repository is structured as a collection of "packages" for each application, managed by `stow`.

- **`zsh/`**, **`tmux/`**, **`nvim/`**, **`ghostty/`**, etc.: Configuration packages for each tool.
- **`docs/`**: Contains all the detailed guides and documentation.
- **`install.sh`**: The installation script that orchestrates the setup.

---

## 🚀 Quick Start

### Prerequisites

- macOS (or Linux with minor modifications)
- [Homebrew](https://brew.sh/) installed
- `stow` (`brew install stow`)
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

All detailed documentation has been moved to the `docs/` directory.

- **[Setup Guide](docs/SETUP_GUIDE.md)** - Complete installation and configuration guide.
- **[Tmux Guide](docs/TMUX_GUIDE.md)** - **START HERE** - Your primary multi-terminal workspace.
- **[Fullstack Dev Guide](docs/FULLSTACK_DEV_GUIDE.md)** - Guide for fullstack development.
- **[Terminal Guide](docs/TERMINAL_GUIDE.md)** - Guide for the terminal setup.
- **[Quick Reference](docs/QUICK_REFERENCE.md)** - Essential shortcuts and commands.
- **[Neovim Guide](nvim/.config/nvim/README.md)** - Neovim-specific documentation.

---

## 🛠️ Recommended Tools

Install these for the best experience:

```bash
brew install \
  stow \          # Symlink manager for dotfiles
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
  lazydocker \    # Docker TUI
  container       # Native macOS Containers
```

---

## 🎨 Theme & Appearance

All configurations use the **Catppuccin Mocha** color scheme for consistency:

- Terminal: Ghostty & Wezterm with Catppuccin Mocha
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

### Native macOS Container Development

```bash
# Start the container service
cs start

# Run a container
cr -it alpine
# Inside container: ls /

# List containers
cl
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

See [Quick Reference](docs/QUICK_REFERENCE.md) for complete list.

---

## 🔧 Customization

### Managing Dotfiles with Stow

This dotfiles repository uses `stow` to manage symlinks. All configurations are organized into "packages" in the root of the repository (e.g., `zsh`, `nvim`, `tmux`).

To add a new configuration file:

1.  Create a new directory for your package: `mkdir myapp`
2.  Inside that directory, recreate the path where the config file should be in your home directory. For example, if you want to link `~/.config/myapp/config.json`, you would create `myapp/.config/myapp/config.json`.
3.  Add the package name (`myapp` in this case) to the `STOW_PACKAGES` array in the `install.sh` script.
4.  Run `./install.sh` to stow the new package.

### Add Personal Configurations

Create `~/.zshrc.local` for machine-specific settings:

```bash
# ~/.zshrc.local
export CUSTOM_VAR="value"
alias myalias="my command"
```

This file is sourced at the end of `.zshrc` and is git-ignored.

### Modify Existing Configs

All configurations are well-commented and organized into sections. Feel free to customize. To find a configuration, look for the corresponding directory (e.g., `zsh/`, `tmux/`, `nvim/`).

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

See [Setup Guide](docs/SETUP_GUIDE.md#troubleshooting) for more solutions.

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
