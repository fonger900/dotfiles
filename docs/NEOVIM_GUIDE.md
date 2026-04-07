# ⚡ Neovim Configuration Guide

This configuration is optimized for fullstack development with a focus on speed, aesthetics, and discoverability.

## 📋 Features

- **LSP**: Intelligent code completion and diagnostics for 20+ languages.
- **DAP**: Debugging support for Node.js, Python, and Go.
- **UI**: Catppuccin Mocha theme with a sleek, minimalist status line.
- **Search**: Blazing fast fuzzy finding via Snacks Picker (FZF-style).
- **Git**: Deep integration with Gitsigns and LazyGit.
- **Terminal**: Integrated floating and persistent terminals.

## 🚦 Getting Started

### Installation
Neovim is automatically configured when you run the project's `bootstrap.sh`. It uses `stow` to link the configuration to `~/.config/nvim`.

### First Run
1. Open Neovim: `nvim`
2. **Lazy.nvim** will automatically download and install all plugins.
3. Run `:checkhealth` to ensure all requirements are met.
4. Use `:Mason` to install additional Language Servers or Formatters.

## ⌨️ Key Workflows

### Finding Files & Code
- `<leader>ff`: Find files by name.
- `<leader>fg`: Search for text across the whole project (grep).
- `<leader>ss`: Search for the word under the cursor.

### Coding & Refactoring
- `gd`: Jump to definition (use `<C-o>` to jump back).
- `gr`: List all references in a quick-fix list.
- `<leader>ca`: Open Code Actions (fixes, imports, etc.).
- `<leader>cr`: Smart rename across files.

### Formatting & Linting
Formatting is handled by **conform.nvim**. Most languages are set to **format on save**.
- `<leader>cf`: Manually trigger formatting.

## 🔌 Core Plugins

| Plugin | Purpose |
|--------|---------|
| **lazy.nvim** | High-performance plugin manager |
| **mason.nvim** | Tooling installer (LSPs, Linters) |
| **blink.cmp** | Ultra-fast completion engine |
| **snacks.nvim** | All-in-one utility (Picker, Terminal, Dashboard) |
| **conform.nvim** | Formatting engine |
| **treesitter** | Advanced syntax highlighting |

## 🛠️ Troubleshooting

- **LSP not starting?**: Run `:LspInfo` to see if a server is attached to the buffer.
- **Missing icons?**: Ensure your terminal is using a **Nerd Font** (Ghostty and Wezterm are pre-configured).
- **Slow performance?**: Run `:Lazy profile` to identify slow-loading plugins.

---

**See Also**: [Languages Guide](./LANGUAGES_GUIDE.md) for environment-specific tips.
