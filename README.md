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
- 🤖 **AI-First Environment**: Pre-configured for **Antigravity** and agentic workflows with persistent context and Secret Service integration via `GEMINI.md`.

---

## 📦 What's Included

This repository is structured as a collection of "packages" for each application, managed by `stow`.

- **`zsh/`**, **`tmux/`**, **`nvim/`**, **`ghostty/`**, etc.: Configuration packages for each tool.
- **`docs/`**: Contains all the detailed guides and documentation.
- **`scripts/`**: Custom automation scripts added to your `$PATH`.
- **`bootstrap.sh`**: The main orchestration script (uses Ansible).
- **`GEMINI.md`**: Instructional context for AI agents (like Gemini) to understand the project architecture.

---

## 🚀 Quick Start

### Prerequisites

- macOS (Primary) or Linux
- [Homebrew](https://brew.sh/) installed
- `stow` (`brew install stow`)
- Basic command line knowledge

### Installation

```bash
# Clone the repository
git clone https://github.com/fonger900/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the installation script
chmod +x bootstrap.sh
./bootstrap.sh

# Restart your terminal
exec zsh
```

That's it! Your development environment is ready. 🎉

---

## 📖 Documentation

- **[Setup Guide](docs/SETUP_GUIDE.md)** - Complete installation and configuration guide.
- **[Font Management](docs/FONTS_GUIDE.md)** - Installing and configuring typography.
- **[Workspace Guide](docs/WORKSPACE_GUIDE.md)** - **START HERE** - Tmux and Terminal workflows.
- **[Fullstack Workflow](docs/FULLSTACK_WORKFLOW.md)** - A "day in the life" guide for building apps.
- **[Neovim Guide](docs/NEOVIM_GUIDE.md)** - Editor configuration and keymaps.
- **[Languages Guide](docs/LANGUAGES_GUIDE.md)** - Fullstack development tips (Node, Python, Go, etc.).
- **[Quick Reference](docs/QUICK_REFERENCE.md)** - Condensed cheat sheet.
- **[Helix Guide](docs/HELIX_GUIDE.md)** - Alternative editor configuration.
- **[Known Bugs & Fixes](docs/bugs/)** - Solutions for common environment quirks.

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
  eza \           # Better ls
  zoxide \        # Smart cd
  starship \      # Shell prompt
  fastfetch \     # System info
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

### Terminal (Ghostty/Wezterm)

| Action | Shortcut |
|--------|----------|
| Split vertical | `Cmd+D` |
| Navigate panes | `Alt+H/J/K/L` |
| New tab | `Cmd+T` |
| Jump to tab | `Cmd+1-9` |
| Search | `Cmd+F` |

---

## 🔧 Customization

### Managing Dotfiles with Stow

This dotfiles repository uses `stow` to manage symlinks. All configurations are organized into "packages" in the root of the repository (e.g., `zsh`, `nvim`, `tmux`).

To add a new configuration file:

1.  Create a new directory for your package: `mkdir myapp`
2.  Inside that directory, recreate the path where the config file should be in your home directory. For example, if you want to link `~/.config/myapp/config.json`, you would create `myapp/.config/myapp/config.json`.
3.  Add the package name (`myapp` in this case) to the `stow_packages` array in the `ansible/playbook.yml` file.
4.  Run `./bootstrap.sh` to stow the new package.

### Add Personal Configurations

To keep the main repo clean and generic, use these local override files (automatically git-ignored):

- **Zsh**: `~/.zshrc.local` (sourced at the end of `.zshrc`)
- **Git**: `~/.gitconfig.local` (can be included in your main `.gitconfig`)

Example `~/.zshrc.local`:
```bash
export CUSTOM_VAR="value"
alias myalias="my command"
```

---

## 🐛 Troubleshooting

### Slow shell startup?
Run `scripts/debug_profile.zsh` to identify slow components.

### Cursor escapes Lazygit in Neovim?
We have disabled `better-escape.nvim` in terminal mode. See [this guide](docs/bugs/LAZYGIT_JK_ESCAPE.md) for details.

### Colors not correct?
Ensure your `$TERM` is set to `xterm-256color` and you are using a Nerd Font.

---

## 🤝 Contributing

Suggestions and improvements are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

Built with inspiration from:

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Starship](https://starship.rs/)
- [Wezterm](https://wezfurlong.org/wezterm/)
- [Ghostty](https://ghostty.org/)
- [TPM](https://github.com/tmux-plugins/tpm)
ins/tpm)
