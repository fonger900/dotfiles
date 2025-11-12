# dotfiles

My personal development environment configuration.

## Overview

This repository contains the configuration files for my development setup, including:

- **Shell**: Zsh with Starship prompt
- **Terminal**: WezTerm
- **Editor**: Neovim
- **Version Control**: Git

## Installation

To install these dotfiles, run the following command:

```bash
./install.sh
```

## Features

- **Minimal & Clean**: A distraction-free, professional aesthetic.
- **Fullstack Ready**: Pre-configured for modern web development with Node.js, Python, Rust, Go, and more.
- **Git Integration**: Rich Git status and branch information directly in the prompt.
- **macOS Optimized**: Keybindings and settings tailored for macOS.

## Configuration Details

### WezTerm (`wezterm.lua`)

- **Theme**: Tokyo Night
- **Font**: JetBrainsMono Nerd Font
- **Keybindings**: macOS-style (e.g., `Cmd+T` for new tab)

### Starship (`starship.toml`)

- **Prompt**: Minimal and fast, showing only essential information.
- **Modules**: Directory, Git, language versions, and command duration.

### Zsh (`.zshrc`)

- **Aliases**: Shortcuts for common commands (`ll`, `gst`, `k`, etc.).
- **Functions**: Helpers for creating projects and managing environments.
- **Version Managers**: Integration with `nvm`, `pyenv`, `asdf`, and more.

### Neovim (`nvim/`)

A complete Neovim setup for fullstack development. See the [Neovim README](./nvim/README.md) for more details.
