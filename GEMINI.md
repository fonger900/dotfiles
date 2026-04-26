# 🚀 Fonger's Dotfiles: Project Context

This document serves as the primary instructional context for Gemini CLI interactions within this repository.

## 📖 Project Overview

This is a comprehensive, production-ready development environment configuration ("dotfiles") repository, primarily optimized for **fullstack engineering** (Node.js, Python, Go, Rust) and **macOS**.

The project uses a **modular architecture** where configurations for different tools (Zsh, Neovim, Tmux, etc.) are isolated into "packages." These packages are managed using **GNU Stow**, which symlinks them into the user's home directory.

### 🛠️ Core Technology Stack
- **Shell**: Zsh (with Oh-My-Zsh, powerlevel10k-style Starship prompt)
- **Multiplexer**: Tmux (Prefix: `Ctrl+A`, integrated with Catppuccin theme)
- **Editors**: Neovim (Modular Lua config), Helix (Modern alternative)
- **Terminals**: Ghostty (Primary)
- **Package Managers**: Homebrew (System), Mise (Runtimes), PNPM (Node.js)
- **Utilities**: `fzf`, `ripgrep`, `fd`, `eza`, `bat`, `zoxide`

## 🏗️ Building and Running

### Installation
The environment is bootstrapped using the `bootstrap.sh` script (which uses Ansible):
```bash
# Main installation and symlinking
./bootstrap.sh
```
This script:
1.  Verifies prerequisites (`zsh`, `git`, `stow`).
2.  Executes the Ansible playbook (`ansible/playbook.yml`) to manage system state and tool installation.
3.  Stows all packages listed in `stow_packages` in `ansible/playbook.yml` to `$HOME`.
4.  Prompts to install Oh-My-Zsh and essential Zsh/Tmux plugins.
5.  Checks for recommended CLI tools.

### Verification
A health check script is provided to verify the environment:
```bash
./scripts/devsetup.sh
```

### Runtime
- **Reloading Zsh**: `reload` (alias for `source ~/.zshrc`)
- **Tmux Plugins**: `Prefix + I` (inside Tmux)
- **Neovim Plugins**: Automatically managed by `Lazy.nvim` on startup.

## 📝 Development Conventions

### Configuration Structure
- **Stow Packages**: Each top-level directory (e.g., `zsh/`, `nvim/`, `tmux/`) represents a Stow package.
- **XDG Compliance**: Most configurations follow the XDG Base Directory Specification, with files located in `.config/` subdirectories.

### Extension & Overrides
To keep the main repository generic and shareable, machine-specific or sensitive configurations should be placed in:
- **Zsh**: `~/.zshrc.local` (sourced automatically)
- **Git**: `~/.gitconfig.local`
- **Other Tools**: Use `.local` suffix for ignored files.

### Coding & Shell Style
- **Shell Scripts**: Use `set -euo pipefail` for robustness.
- **Aliases**: Defined in `zsh/aliases.zsh`. Avoid adding heavy logic to aliases; use scripts in `scripts/` instead.
- **Modular Neovim**: The Neovim config is split into `config/` (settings) and `plugins/` (individual tool setup).

### Path Management
- Paths are managed in `zsh/path.zsh`.
- Use the `typeset -U path` command in Zsh to ensure unique entries in the `$PATH`.
- **Prepend** project-specific or priority paths (like `scripts/`) and **append** system or auxiliary paths.

## 📂 Key Directories
- `docs/`: Extensive documentation on workflows, keymaps, and tool-specific guides.
- `scripts/`: Custom automation scripts added to the user's `$PATH`.
- `zsh/`: Modular Zsh configuration (`aliases.zsh`, `exports.zsh`, `path.zsh`).
- `nvim/`: Modular Neovim configuration following modern Lua practices.

## 🤖 AI Agent Environment & Persistence

This repository is optimized for AI-driven development using **Antigravity**. To ensure session and chat history persistence, the environment relies on the **Secret Service (libsecret)** provided by **gnome-keyring**.

### Required Persistence Configuration
If chat history is lost on restart, verify the following:

1.  **Secret Service Provider**: **gnome-keyring** must be running.
    - Start it in Sway with `exec gnome-keyring-daemon --start --components=secrets`.
    - It is automatically unlocked by PAM on login.
2.  **IDE Configuration**: `~/.antigravity/argv.json` must include:
    ```json
    "password-store": "gnome"
    ```
    This forces the Electron engine to use the Secret Service for session encryption.
3.  **Environment Variables**:
    - `ELECTRON_PASSWORD_STORE="gnome"` (set in `zsh/exports.zsh`).
    - `CHROME_CONFIG_FLAGS="--password-store=gnome"` (for Chromium-based tools).

### Session Context
On Linux (Debian 13), the environment uses `dbus-run-session` in `.zprofile` to ensure a consistent D-Bus session across Sway and its subprocesses, which is critical for keyring accessibility.
