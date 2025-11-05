# 🚀 Neovim Fullstack Development Guide

A comprehensive guide to using this Neovim configuration for modern fullstack development. This setup includes language servers, formatters, linters, and tools for web development, backend services, and DevOps workflows.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Language Support](#language-support)
- [Essential Keymaps](#essential-keymaps)
- [Development Workflows](#development-workflows)
- [Plugin Overview](#plugin-overview)
- [Troubleshooting](#troubleshooting)

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

### Frontend Development

#### JavaScript/TypeScript

- **Language Server**: TypeScript Language Server (`ts_ls`)
- **Formatter**: Prettier/Prettierd
- **Linter**: ESLint (via LSP)
- **Features**:
  - Auto-completion with type information
  - Error highlighting and quick fixes
  - Auto-imports and organize imports
  - Refactoring support

```lua
-- Key commands:
-- <leader>ca = Code actions
-- <leader>cr = Rename symbol
-- gd = Go to definition
-- gr = Go to references
```

#### React/Vue/Svelte

- Full JSX/TSX support via Treesitter
- Component prop completion
- Hook and lifecycle method suggestions
- CSS-in-JS syntax highlighting

#### CSS/SCSS/Tailwind

- **Language Servers**: CSS Language Server, TailwindCSS
- **Features**:
  - Class name completion
  - CSS property validation
  - Color previews
  - Tailwind utility suggestions

### Backend Development

#### Python

- **Language Server**: Pyright
- **Formatter**: Black + isort
- **Features**:
  - Type checking with mypy integration
  - Import organization
  - Django/Flask framework support
  - Virtual environment detection

```bash
# Setup Python environment
python -m venv .venv
source .venv/bin/activate  # or .venv/Scripts/activate on Windows
pip install black isort mypy
```

#### Go

- **Language Server**: gopls
- **Features**:
  - Go modules support
  - Struct tag generation
  - Interface implementation
  - Test generation

#### Rust

- **Language Server**: rust-analyzer
- **Features**:
  - Cargo integration
  - Macro expansion
  - Trait implementation
  - Error lens with suggestions

### DevOps & Configuration

#### Docker

- Dockerfile syntax highlighting
- Multi-stage build support
- docker-compose.yml validation

#### YAML/JSON

- Schema validation for Kubernetes, GitHub Actions
- Auto-completion for common configurations
- Format on save

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

### Terminal Management

```lua
-- Primary Terminal
<C-/>           -- Toggle Snacks terminal (Ctrl + /)
<C-_>           -- Alternative terminal toggle

-- ToggleTerm Integration
<leader>tt      -- Toggle terminal (horizontal split)
<leader>tf      -- Toggle floating terminal

-- Multiple Terminal Instances
:ToggleTerm 1   -- Open terminal #1
:ToggleTerm 2   -- Open terminal #2
:ToggleTerm 3   -- Open terminal #3
```

## 🖥️ Running Multiple Terminals

### Quick Start - Multiple Terminals

Your Neovim setup includes both **Snacks Terminal** and **ToggleTerm** for powerful terminal management:

#### Method 1: ToggleTerm (Recommended for Multiple Terminals)

```lua
-- Open specific numbered terminals
:ToggleTerm 1    -- Development server (e.g., npm run dev)
:ToggleTerm 2    -- Git operations
:ToggleTerm 3    -- Testing (e.g., npm test)
:ToggleTerm 4    -- Database/Docker commands
```

#### Method 2: ToggleTerm with Different Directions

```lua
-- Different terminal layouts
:ToggleTerm direction=horizontal    -- Bottom split
:ToggleTerm direction=vertical      -- Side split  
:ToggleTerm direction=float         -- Floating window
:ToggleTerm direction=tab           -- New tab
```

### Practical Multi-Terminal Workflow

#### Frontend Development Setup

1. **Terminal 1** - Development Server

   ```bash
   # Use: <leader>tt or :ToggleTerm 1
   npm run dev
   # or
   yarn dev
   ```

2. **Terminal 2** - Git Operations

   ```bash
   # Use: :ToggleTerm 2
   git status
   git add .
   git commit -m "feature: add new component"
   ```

3. **Terminal 3** - Testing

   ```bash
   # Use: :ToggleTerm 3
   npm test
   # or
   npm run test:watch
   ```

4. **Terminal 4** - Package Management

   ```bash
   # Use: :ToggleTerm 4
   npm install
   npm audit fix
   ```

#### Fullstack Development Setup

1. **Terminal 1** - Frontend Server

   ```bash
   cd frontend
   npm run dev          # React/Vue/Angular dev server
   ```

2. **Terminal 2** - Backend Server  

   ```bash
   cd backend
   python manage.py runserver    # Django
   # or
   go run main.go               # Go
   # or  
   cargo run                    # Rust
   ```

3. **Terminal 3** - Database

   ```bash
   docker-compose up -d postgres
   # or
   mysql -u root -p
   ```

4. **Terminal 4** - General Commands

   ```bash
   # Build, deploy, docker commands, etc.
   docker-compose up
   ```

### Advanced Terminal Features

#### Terminal Navigation

```lua
-- In terminal mode:
<C-h/j/k/l>     -- Navigate between windows (including terminals)
<Esc><Esc>      -- Exit terminal mode to normal mode
<C-\><C-n>      -- Alternative exit to normal mode
```

#### Terminal Keymaps in Different Modes

```lua
-- Normal mode (outside terminal)
<leader>tt      -- Toggle main terminal
<leader>tf      -- Toggle floating terminal
<C-/>           -- Quick Snacks terminal

-- Terminal mode (inside terminal)
<C-h>           -- Move to left window
<C-l>           -- Move to right window  
<C-j>           -- Move to window below
<C-k>           -- Move to window above
```

#### Custom Terminal Commands

You can also create custom terminal commands:

```bash
# In any terminal
:TermExec cmd="npm run build"     # Execute command in terminal
:TermExec cmd="git push" go_back=0  # Run command and stay in terminal
```

### Terminal Management Tips

#### Best Practices

1. **Use Numbered Terminals**: Assign specific purposes to numbered terminals
2. **Floating for Quick Tasks**: Use `<leader>tf` for quick commands
3. **Splits for Monitoring**: Use horizontal/vertical splits for logs
4. **Tab Terminals**: Use tab direction for isolated environments

#### Switching Between Terminals

```lua
-- Quick terminal switching
1<C-\>          -- Switch to terminal #1  
2<C-\>          -- Switch to terminal #2
3<C-\>          -- Switch to terminal #3

-- Or use the command
:ToggleTerm 1   -- Focus terminal #1
:ToggleTerm 2   -- Focus terminal #2
```

#### Terminal Persistence

- **ToggleTerm**: Terminals persist across sessions
- **Working Directory**: Each terminal remembers its directory
- **Process Continuation**: Long-running processes continue in background

### Example: Full Development Session

```bash
# Setup for a React + Node.js project
:ToggleTerm 1
cd frontend && npm run dev

:ToggleTerm 2  
cd backend && npm run dev

:ToggleTerm 3
npm test

:ToggleTerm 4
# Available for git, docker, misc commands

# Use <C-/> for quick one-off commands
# Use <leader>tt to toggle main terminal
# Use <leader>tf for floating terminal
```

## 🔄 Development Workflows

### Frontend Workflow

1. **Project Setup**

   ```bash
   # Create new project
   npm create vue@latest my-app  # or create-react-app, etc.
   cd my-app
   nvim .
   ```

2. **Development Flow**
   - Use `<leader>ff` to quickly navigate files
   - Open terminal with `<leader>tt` for running dev server
   - Use `<leader>ca` for auto-imports and quick fixes
   - Format on save is enabled by default

3. **Testing & Debugging**
   - Run tests in integrated terminal
   - Use LSP diagnostics for error checking
   - Git integration for version control

### Backend API Development

1. **Python/Django Setup**

   ```bash
   # Activate virtual environment
   source .venv/bin/activate
   # Install dependencies
   pip install -r requirements.txt
   # Open project
   nvim .
   ```

2. **Development Features**
   - Auto-completion for Django models/views
   - Import organization with isort
   - Black formatting on save
   - Type checking with Pyright

3. **Database Integration**
   - SQL syntax highlighting
   - Connection strings in env files
   - Migration file support

### Full-Stack Project Structure

```text
my-fullstack-app/
├── frontend/          # React/Vue/Angular app
│   ├── src/
│   ├── package.json
│   └── ...
├── backend/           # API server
│   ├── app/
│   ├── requirements.txt
│   └── ...
├── docker-compose.yml # Development environment
├── .env.example      # Environment variables
└── README.md         # Project documentation
```

## 🔌 Plugin Overview

### Core Functionality

- **lazy.nvim**: Plugin manager with lazy loading
- **catppuccin**: Modern colorscheme
- **lualine**: Status line with git/LSP info
- **bufferline**: Tab-like buffer management

### Language & Completion

- **nvim-lspconfig**: Language server configuration
- **mason.nvim**: LSP/formatter/linter installer
- **nvim-cmp**: Auto-completion engine
- **luasnip**: Snippet engine
- **nvim-treesitter**: Syntax highlighting

### Editor Enhancement

- **telescope**: Fuzzy finder for files/text
- **flash.nvim**: Enhanced navigation
- **which-key**: Keymap hints
- **conform.nvim**: Code formatting
- **gitsigns**: Git integration

### Coding Tools

- **Comment.nvim**: Smart commenting
- **nvim-surround**: Surround text objects
- **nvim-autopairs**: Auto-close brackets
- **todo-comments**: Highlight TODO/FIXME

## 🛠️ Troubleshooting

### Common Issues

#### Language Server Not Working

1. Check if installed: `:Mason`
2. Restart LSP: `:LspRestart`
3. Check logs: `:LspLog`
4. Verify config: `:LspInfo`

#### Formatting Not Working

1. Check formatter installation: `:Mason`
2. Verify file type: `:set filetype?`
3. Manual format: `<leader>cf`
4. Check conform config: `:ConformInfo`

#### Slow Startup

1. Check lazy loading: `:Lazy profile`
2. Disable unused plugins in plugin files
3. Use `:checkhealth` for issues

#### Git Integration Issues

1. Verify git in PATH: `:!git --version`
2. Check repository: `:!git status`
3. Restart gitsigns: `:Gitsigns refresh`

### Performance Tips

1. **Large Files**: Disable some features for files >1MB
2. **Many Files**: Use `.nvimignore` for node_modules, etc.
3. **Remote Development**: Consider disabling some visual plugins
4. **Memory Usage**: Monitor with `:lua print(collectgarbage("count"))`

### Configuration Customization

#### Adding New Language Support

1. Add to Mason: `:Mason` → install language server
2. Add to `lua/plugins/lsp.lua` servers table
3. Add formatter to `lua/plugins/coding.lua`
4. Add treesitter parser to `ensure_installed`

#### Custom Keymaps

Add to `lua/config/keymaps.lua`:

```lua
-- Custom keymap example
keymap.set("n", "<leader>cr", function()
  -- Your custom function
end, { desc = "Custom command" })
```

#### Project-Specific Settings

Create `.nvim.lua` in project root:

```lua
-- Project-specific configuration
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
```

## 📚 Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LSP Configuration Examples](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Treesitter Supported Languages](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
- [Mason Package List](https://mason-registry.dev/registry/list)

---

**Happy Coding!** 🎉

This configuration is designed to provide a smooth, efficient development experience across the fullstack spectrum. Don't hesitate to customize it further to match your specific workflow and preferences.
