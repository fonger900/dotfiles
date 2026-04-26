# 🛠️ Setup & Installation Guide

This guide provides detailed instructions for installing and maintaining your development environment.

## 🚀 Quick Start

If you are on macOS and have [Homebrew](https://brew.sh/) installed, you can get up and running quickly:

1. **Clone and Install**:
   ```bash
   git clone https://github.com/fonger900/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   chmod +x bootstrap.sh
   ./bootstrap.sh
   ```

2. **Post-Installation**:
   - Restart your terminal.
   - Open `tmux` and press `Prefix + I` (default prefix is `Ctrl+A`) to install plugins.
   - Open `nvim` and wait for plugins to install automatically.

3. **AI Agent Persistence**:
   - If using **Antigravity**, ensure you have **KeePassXC** installed and set up as your Secret Service provider.
   - In KeePassXC: Settings -> Browser Integration -> Check "Enable Secret Service".
   - Unlock your database to allow the IDE to save chat history and login sessions.

---

## 📦 What's Installed?

The `bootstrap.sh` script (powered by Ansible) automates the setup of several key components:

### Core Tools (via Homebrew)
- **Shell**: `zsh`, `starship`, `zoxide`, `fastfetch`
- **Editor**: `neovim`, `helix`
- **Multiplexer**: `tmux`
- **Modern CLI**: `eza`, `bat`, `fd`, `ripgrep`, `fzf`

### Zsh Plugins (Oh-My-Zsh)
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `zsh-completions`

### Package Managers
- **Mise**: Polyglot tool version manager (replaces nvm/pyenv/etc.)
- **TPM**: Tmux Plugin Manager

---

## 📂 Repository Structure

This project uses `stow` to manage configuration symlinks.

```text
dotfiles/
├── zsh/      -> ~/.zshrc, aliases.zsh, etc.
├── nvim/     -> ~/.config/nvim/
├── tmux/     -> ~/.tmux.conf
├── scripts/  -> ~/dotfiles/scripts/ (Added to PATH)
└── ...       (other tool-specific directories)
```

### Adding a New Tool Config
1. Create a directory for the tool: `mkdir mytool`
2. Replicate the target home path: `mkdir -p mytool/.config/mytool`
3. Add your config: `touch mytool/.config/mytool/config.toml`
4. Add `mytool` to `stow_packages` in `ansible/playbook.yml`.
5. Run `./bootstrap.sh`.

---

## 🔧 Maintenance & Customization

### Updating
To update your environment and all tools:
```bash
brew update && brew upgrade
mise self-update && mise upgrade
# Inside Neovim: :Lazy update
# Inside Tmux: Prefix + U
```

### Personal Overrides
For machine-specific settings that you don't want to commit to git, use:
- **Zsh**: `~/.zshrc.local`
- **Git**: `~/.gitconfig.local`

---

## 🛠️ Troubleshooting

### Shell Startup is Slow
Run `scripts/debug_profile.zsh` to see a breakdown of startup time. Common culprits are synchronous version manager initializations.

### Colors/Icons are Missing
- Ensure you are using a **Nerd Font** in your terminal settings (e.g., JetBrainsMono Nerd Font).
- Verify `$TERM` is set correctly (`xterm-256color` for terminal, `screen-256color` or `tmux-256color` inside tmux).

### Tmux Sessions Disappeared
Tmux sessions persist until a reboot or manual kill. If you can't find yours, try:
```bash
tmux ls
tmux attach -t <name>
```

---

**Next Steps**: 
- Master your workspace in the **[Workspace Guide](./WORKSPACE_GUIDE.md)**.
- Learn editor shortcuts in the **[Neovim Guide](./NEOVIM_GUIDE.md)**.
EOVIM_GUIDE.md)**.
