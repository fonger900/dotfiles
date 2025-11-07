# 🚀 Neovim Fullstack Development Guide

A comprehensive guide to using this Neovim configuration for modern fullstack development.

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [Language Support](#-language-support)
- [Essential Keymaps](#️-essential-keymaps)
- [Development Workflows](#-development-workflows)
- [Plugin Overview](#-plugin-overview)
- [Troubleshooting](#️-troubleshooting)

**📖 Additional Guides**:

- [Terminal Management Guide](./TERMINAL_GUIDE.md) - Complete terminal usage and workflows

## 🚦 Quick Start

### Prerequisites

Ensure you have the following installed:

- **Neovim** 0.11+ (`brew install neovim`)
- **Node.js** 22+ for TypeScript/JavaScript tooling
- **Python** 3.12+ with pip
- **Git** for version control
- **ripgrep** for fast searching (`brew install ripgrep`)
- **fd** for file finding (`brew install fd`)

### First Launch

1. Open Neovim: `nvim`
2. Lazy.nvim will automatically install all plugins
3. Run `:checkhealth` to verify installation
4. Install language servers: `:Mason` → Install needed servers

## 💻 Language Support

### Frontend

**JavaScript/TypeScript** - Full support via `ts_ls`, Prettier, ESLint

- Auto-completion, error highlighting, auto-imports, refactoring

**React/Vue/Svelte** - Full JSX/TSX support via Treesitter

- Component completion, hooks, lifecycle methods

**CSS/Tailwind** - CSS Language Server, TailwindCSS LSP

- Class completion, validation, color previews

### Backend

**Python** - Pyright, Black, isort

- Type checking, import organization, Django/Flask support

**Go** - gopls

- Modules support, struct tags, interface implementation

**Rust** - rust-analyzer

- Cargo integration, macro expansion, trait implementation

### DevOps

**Docker** - Syntax highlighting, validation

**YAML/JSON** - Schema validation for Kubernetes, GitHub Actions

## ⌨️ Essential Keymaps

### Core Navigation

```lua
-- Window Management
<C-h/j/k/l>     -- Navigate between windows
<C-↑/↓/←/→>     -- Resize windows

-- Buffer Management  
<S-h>           -- Previous buffer
<S-l>           -- Next buffer
<leader>bd      -- Delete buffer
<leader>bp      -- Pin buffer
```

### Code Navigation

```lua
-- LSP Navigation
gd              -- Go to definition
gD              -- Go to declaration
gr              -- Go to references
gi              -- Go to implementation
K               -- Show hover documentation
<C-k>           -- Signature help

-- Diagnostics
]d              -- Next diagnostic
[d              -- Previous diagnostic
<leader>cd      -- Line diagnostics
<leader>cD      -- Workspace diagnostics
```

### Search & Find

```lua
-- File Operations
<leader>ff      -- Find files
<leader>fg      -- Live grep
<leader>fb      -- Browse buffers
<leader>fr      -- Recent files

-- Code Search
<leader>ss      -- Search current word
<leader>sS      -- Search with selection
<leader>sc      -- Search in current buffer
```

### Code Actions

```lua
-- Editing
<leader>ca      -- Code actions
<leader>cr      -- Rename symbol
<leader>cf      -- Format buffer
<leader>cF      -- Format selection

-- Git Operations
<leader>gg      -- Open Lazygit
<leader>gb      -- Blame line
<leader>gd      -- Diff this
<leader>gh      -- Preview hunk
```

### Terminal

```lua
<C-/>           -- Quick terminal (Snacks)
<leader>tt      -- Toggle terminal (ToggleTerm)
:ToggleTerm 1   -- Numbered terminal #1
<Esc><Esc>      -- Exit terminal mode
```

**📖 See [Terminal Guide](./TERMINAL_GUIDE.md) for complete terminal workflows**

## 🔄 Development Workflows

### Quick Start

1. **Open Project**: `nvim .`
2. **Find Files**: `<leader>ff`
3. **Start Terminal**: `<C-/>` or `<leader>tt`
4. **Code Actions**: `<leader>ca`
5. **Git**: `<leader>gg` (LazyGit)

### Frontend Workflow

```bash
# Create project
npm create vue@latest my-app
cd my-app
nvim .

# In Neovim:
# <leader>tt - Start dev server (npm run dev)
# <leader>ff - Find files
# <leader>ca - Code actions, auto-imports
# <leader>cf - Format code
# <C-/>      - Quick git commands
```

### Backend Workflow

```bash
# Python/Django
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
nvim .

# In Neovim:
# <leader>tt - Start server (python manage.py runserver)
# LSP provides type checking, import organization
# Format on save enabled (Black + isort)
```

### Full-Stack Structure

```text
my-fullstack-app/
├── frontend/          # React/Vue/Angular
├── backend/           # Django/Go/Rust/Node.js
├── docker-compose.yml
├── .env.example
└── README.md
```

**See [Terminal Guide](./TERMINAL_GUIDE.md) for multi-terminal development workflows**

## 🔌 Plugin Overview

### Core

- **lazy.nvim** - Plugin manager with lazy loading
- **catppuccin** - Modern colorscheme
- **lualine** - Status line with git/LSP info
- **bufferline** - Tab-like buffer management
- **snacks.nvim** - Multi-purpose plugin (picker, terminal, dashboard, etc.)

### Language & Completion

- **nvim-lspconfig** - Language server configuration
- **mason.nvim** - LSP/formatter/linter installer (`:Mason`)
- **nvim-cmp** - Auto-completion engine
- **luasnip** - Snippet engine
- **nvim-treesitter** - Syntax highlighting

### Editor Enhancement

- **flash.nvim** - Enhanced navigation
- **which-key** - Keymap hints
- **conform.nvim** - Code formatting
- **gitsigns** - Git integration

### Coding Tools

- **Comment.nvim** - Smart commenting (`gcc`, `gbc`)
- **nvim-surround** - Surround text objects (`ys`, `ds`, `cs`)
- **nvim-autopairs** - Auto-close brackets
- **todo-comments** - Highlight TODO/FIXME
- **toggleterm.nvim** - Terminal integration

## 🛠️ Troubleshooting

### Common Issues

#### Language Server Not Working

1. Check installation: `:Mason`
2. Restart LSP: `:LspRestart`
3. Check logs: `:LspLog`
4. Verify config: `:LspInfo`

#### Formatting Not Working

1. Check formatter: `:Mason`
2. Verify file type: `:set filetype?`
3. Manual format: `<leader>cf`
4. Check config: `:ConformInfo`

#### Slow Startup

1. Profile plugins: `:Lazy profile`
2. Check health: `:checkhealth`
3. Disable unused plugins in `lua/plugins/`

#### Git Integration Issues

1. Verify git: `:!git --version`
2. Check repo: `:!git status`
3. Restart gitsigns: `:Gitsigns refresh`

### Customization

#### Add Language Support

1. Install LSP: `:Mason` → install language server
2. Add to `lua/plugins/lsp.lua` servers table
3. Add formatter to `lua/plugins/coding.lua`
4. Add treesitter parser to `ensure_installed`

#### Custom Keymaps

Edit `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>cr", function()
  -- Your custom function
end, { desc = "Custom command" })
```

#### Project-Specific Settings

Create `.nvim.lua` in project root:

```lua
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
```

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LSP Configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Treesitter Languages](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
- [Mason Packages](https://mason-registry.dev/registry/list)

---

**Happy Coding!** 🎉

This configuration provides a smooth, efficient development experience across the fullstack spectrum. Customize it to match your workflow and preferences!
