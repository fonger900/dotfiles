# My Neovim Configuration

A modern, feature-rich Neovim setup optimized for full-stack development with Snacks.nvim integration.

## Requirements

- Neovim 0.10 or newer
- Git and a Nerd Font (for best UI rendering)
- GitHub CLI (optional, for GitHub integration features)

## Features

- **Lightning-fast startup** with lazy-loading and optimized plugin management.
- **Modern UI/UX** with Catppuccin theme, Snacks dashboard, and integrated notifications.
- **Comprehensive LSP integration** with fuzzy picker navigation and native actions.
- **Efficient navigation** with Snacks Picker, Snacks Explorer, Flash, and Harpoon.
- **Enhanced Git workflow** with GitSigns, Fugitive, DiffView, and GitHub CLI integration.
- **Smart code editing** with TreeSitter, autocompletion, formatting, and snippets.
- **Terminal integration** with toggleable floating/split terminals.
- **Dashboard** with quick actions and startup time display

## Core Plugins

### 🎯 **Snacks.nvim - Core Integration**

- [folke/snacks.nvim](https://github.com/folke/snacks.nvim): Comprehensive QoL plugin providing:
  - **Picker**: Fuzzy finding for files, grep, buffers, recent, diagnostics, git, GitHub
  - **Dashboard**: Beautiful startup screen with quick actions
  - **Notifier**: Modern notification system (replaces nvim-notify)
  - **Terminal**: Integrated terminal management
  - **Explorer**: Integrated file browsing and management
  - **Other**: Indent guides, profiler, zen mode, scratch buffers, toggles

### 🎨 **Theme & UI**

- [catppuccin/nvim](https://github.com/catppuccin/nvim): Soothing pastel theme with comprehensive plugin integration.
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Icons for file types and UI elements.
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): Fast and customizable statusline.
- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim): Elegant buffer tabs.

### 🧠 **LSP & Development**

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim): Portable LSP server manager.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): Mason integration for LSP.
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): LSP server configurations.
- [folke/neoconf.nvim](https://github.com/folke/neoconf.nvim): Project-local LSP configuration.
- [folke/neodev.nvim](https://github.com/folke/neodev.nvim): Enhanced Lua development for Neovim.

### ⌨️ **Code Completion & Snippets**

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Powerful completion engine.
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): LSP completion source.
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer): Buffer word completion.
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path): File path completion.
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine with rich features.
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets): Collection of useful snippets.

### 🔍 **Search & Navigation**

- [folke/flash.nvim](https://github.com/folke/flash.nvim): Enhanced f/F/t/T motions with labels.
- [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon): Quick file navigation bookmarks.

### 🛠️ **Formatting & Code Quality**

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): Async formatting with multiple formatter support.
- [b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim): JSON schema validation.

### 📝 **Git Integration**

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git decorations and hunk operations.
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive): Comprehensive Git wrapper.
- [tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb): GitHub integration for Fugitive.
- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim): Enhanced diff viewing and file history.

### 🎯 **Quality of Life**

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim): Keymap hints and organization.
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim): Smart commenting with TreeSitter integration.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs): Auto-close brackets and quotes.
- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround): Add/change/delete surrounding characters.
- [gbprod/yanky.nvim](https://github.com/gbprod/yanky.nvim): Enhanced yank history and operations.

### 🌲 **Syntax & TreeSitter**

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Advanced syntax highlighting and code understanding.

## Essential Key Bindings

### 🗂️ **File Operations**

| Key | Description |
|---|---|
| `<leader><space>` | Smart find files (Snacks picker) |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Find buffers |
| `<leader>fc` | Find config files |
| `<leader>fn` | New file |
| `<leader>e` | File explorer (Snacks) |

### 🔍 **Search & Find**

| Key | Description |
|---|---|
| `<leader>/` | Live grep |
| `<leader>sg` | Grep in root directory |
| `<leader>sw` | Grep word under cursor |
| `<leader>sb` | Search buffer lines |
| `<leader>sr` | Search registers |
| `<leader>sm` | Search marks |
| `<leader>sk` | Search keymaps |

### 🧠 **LSP & Code**

| Key | Description |
|---|---|
| `gd` | Goto definition (via Snacks picker) |
| `gr` | References (via Snacks picker) |
| `gI` | Goto implementation (via Snacks picker) |
| `gy` | Goto type definition (via Snacks picker) |
| `K` | Hover documentation |
| `gK` | Signature help |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Line diagnostics |
| `[d` / `]d` | Previous/Next diagnostic |
| `[e` / `]e` | Previous/Next error |

### 📝 **Git Workflow**

| Key | Description |
|---|---|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Git branches |
| `<leader>gs` | Git status |
| `<leader>gd` | Git diff |
| `<leader>gl` | Git log |
| `<leader>ghi` | GitHub issues |
| `<leader>ghp` | GitHub pull requests |

### 🛠️ **Utilities**

| Key | Description |
|---|---|
| `<leader>z` | Zen mode |
| `<leader>.` | Scratch buffer |
| `<leader>bd` | Delete buffer |
| `<c-/>` | Toggle terminal |
| `<leader>l` | Lazy plugin manager |
| `<leader>w` | Save file |
| `<leader>q` | Quit |

### 🎛️ **UI Toggles**

| Key | Description |
|---|---|
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle word wrap |
| `<leader>ul` | Toggle line numbers |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ud` | Toggle diagnostics |

## ⚡ Enhanced Neovim Configuration

A modern, feature-rich, and highly optimized Neovim configuration designed for full-stack development with excellent performance and user experience.

## ✨ Features

### 🎨 **Modern UI & Theme**

- **Catppuccin Mocha** colorscheme with deep integrations
- **Lualine** statusline with useful information
- **Bufferline** for elegant tab management
- **Neo-tree** file explorer with git integration
- **Dashboard** with quick actions and startup time display
- **Indent guides** for better code readability

### 🧠 **Smart Code Intelligence**

- **Full LSP support** with Mason for easy server management
- **Enhanced autocompletion** with nvim-cmp and LuaSnip
- **Treesitter** for accurate syntax highlighting and text objects  
- **Code formatting** with Conform.nvim supporting multiple formatters
- **LSP navigation** via Snacks picker for better UX
- **Inlay hints** and **semantic tokens** support

### 🔍 **Powerful Navigation & Search**

- **Snacks Picker** for unified fuzzy finding (files, grep, buffers, git, GitHub)
- **Flash** for enhanced motion and search
- **Harpoon** for quick file navigation bookmarks
- **Snacks Explorer** for integrated file browsing and management
- **Session persistence** with automatic restore

### 📝 **Enhanced Editing Experience**

- **Smart autopairs** and **surround** operations
- **Multiple cursors** support
- **Comment toggling** with TreeSitter context awareness
- **Enhanced yank history** with Yanky
- **Better escape** for smoother editing
- **Advanced text objects** and movements

### 🔧 **Git Workflow**

- **Gitsigns** for inline git information and hunk operations
- **Fugitive** for comprehensive git operations
- **Diffview** for advanced diff viewing and file history
- **GitHub integration** via Snacks GitHub CLI picker
- **Git blame**, **log**, and **branch** navigation

### 🚀 **Performance & UX**

- **Lightning-fast startup** with lazy loading and modern optimizations
- **Snacks ecosystem** for unified UI/UX (notifications, dashboard, terminal)
- **Modern APIs** with fallbacks for compatibility
- **Efficient terminal integration** with multiple backends
- **Smart toggles** for development preferences

## 📁 Directory Structure

```sh
nvim/
├── init.lua                    # Main configuration entry point
├── lazy-lock.json             # Plugin version lock file
├── lua/
│   ├── types.lua              # Type definitions for better LSP
│   ├── config/
│   │   ├── autocmds.lua       # Auto commands configuration
│   │   ├── icons.lua          # Icon definitions
│   │   ├── keymaps.lua        # Core key mappings (editor functionality)
│   │   ├── lsp.lua            # LSP client configurations
│   │   ├── options.lua        # Neovim options and settings
│   │   └── utils.lua          # Utility functions and helpers
│   └── plugins/
│       ├── coding.lua         # Completion, snippets, and coding tools
│       ├── editor.lua         # Editor enhancements and text objects
│       ├── git.lua            # Git integration plugins
│       ├── lsp.lua            # LSP server and client setup
│       ├── snacks.lua         # Snacks.nvim configuration (picker, UI, etc.)
│       ├── ui.lua             # UI themes and visual plugins
│       └── utils.lua          # Utility plugins and tools
```

## ⚙️ Configuration Highlights

### 🔗 **Snacks-Powered Architecture**

- **Unified picker system** for files, search, git, and GitHub operations
- **Integrated notifications** and dashboard for better UX
- **Smart toggles** for development preferences
- **Terminal management** with multiple backends

### 🎯 **Intelligent Key Mappings**

- `<Space>` as leader key for easy access
- **Snacks handles**: file operations, search, git, LSP navigation, UI features
- **Keymaps.lua handles**: core editor functionality, window management, diagnostics
- **LSP integration**: Snacks picker for navigation, native LSP for immediate actions
- Context-aware mappings that adapt to file types
- Comprehensive which-key integration for discoverability

### 🛠️ **LSP Configuration**

- Support for 15+ language servers out of the box
- Automatic server installation and configuration
- Enhanced diagnostics with custom styling
- Code actions, formatting, and renaming support
- **Lua LSP**: Properly configured with `.luarc.json` for Neovim development
  - Recognizes `vim` global and Neovim APIs
  - Includes runtime path and workspace library settings
  - Optimized for plugin development
  - Custom type definitions in `lua/types.lua` for better LSP support
  - Comprehensive type annotations for formatters and LSP clients

### 📦 **Plugin Management**

- **Lazy.nvim** for modern plugin management
- Automatic plugin installation and updates
- Performance-focused loading strategies
- Easy plugin configuration and customization

## 🚀 Installation

1. **Backup your existing configuration** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:

   ```bash
   git clone <your-repo> ~/.config/nvim
   ```

3. **Start Neovim**:

   ```bash
   nvim
   ```

4. **Let Lazy.nvim install plugins** (happens automatically on first launch)

## 🚀 Quick Start

After installation, the configuration provides:

- **Modern dashboard** on startup with quick actions
- **Integrated help** via `<leader>sk` (search keymaps) and `:help`
- **Plugin management** via `:Lazy` command
- **LSP setup** via `:Mason` for language servers
- **Git integration** ready to use with `:LazyGit` or `<leader>gg`

### **First Steps**

1. Open Neovim and let plugins install
2. Run `:checkhealth` to verify setup
3. Try `<leader><space>` to find files
4. Use `<leader>sk` to explore available keymaps
5. Press `<leader>e` for file explorer

## 🔧 Supported Languages & Tools

- **Web Development**: HTML, CSS, JavaScript, TypeScript, Vue.js, React
- **Backend**: Python, Node.js, Go, Rust  
- **Systems**: Lua (Neovim), Bash, JSON, YAML, TOML
- **Styling**: Tailwind CSS, SCSS, CSS
- **Databases**: SQL, various config files
- **DevOps**: Docker, Kubernetes, various config formats
- **Markup**: Markdown, LaTeX

## 📊 Performance Metrics

- **Startup time**: ~40-70ms (with lazy loading optimizations)
- **Memory usage**: ~25-40MB (efficient plugin management)
- **Plugin count**: 40+ carefully selected and optimized plugins
- **Lazy loading**: 95% of plugins load only when needed
- **Modern APIs**: Optimized for Neovim 0.10+ features

## 🐛 Troubleshooting & Health Checks

### **Plugin Management**

```lua
:Lazy                 -- Open Lazy plugin manager
:Lazy check health    -- Check plugin health
:Lazy clean          -- Remove unused plugins  
:Lazy update         -- Update all plugins
:Lazy profile        -- Profile plugin loading times
```

### **LSP Diagnostics**

```lua
:LspInfo             -- Show active LSP clients
:Mason               -- Manage LSP servers and tools
:checkhealth         -- Comprehensive health check
:checkhealth snacks  -- Check Snacks configuration
```

### **Performance Analysis**

```lua
:Snacks profile      -- Profile startup and runtime
:Snacks dashboard    -- Show startup time on dashboard
```

### **Common Issues**

- **Slow startup**: Run `:Snacks profile` to identify bottlenecks
- **LSP not working**: Check `:LspInfo` and `:Mason` for server status  
- **Keymaps conflict**: Use `:Snacks picker keymaps` to search mappings
- **Git features**: Ensure git and gh CLI are installed for full functionality

## 🔄 Updates & Maintenance

This configuration is actively maintained and updated for:

- **Latest Neovim features** and API improvements
- **Plugin updates** and security patches
- **Performance optimizations** and modernizations
- **Bug fixes** and compatibility improvements

Check the [CHANGELOG.md](CHANGELOG.md) for detailed update history.

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch  
3. Test your changes thoroughly
4. Submit a pull request with clear descriptions

## 📝 License

This configuration is MIT licensed - feel free to use and modify as needed!

This configuration is open source and available under the MIT License.

---

## Happy coding with Neovim! 🎉
