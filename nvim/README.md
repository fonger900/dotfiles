# My Neovim Configuration

A personalized Neovim setup for full-stack development.

## Requirements

- Neovim 0.10 or newer
- Git and a Nerd Font (for best UI rendering)

## Features

- **Fast startup time** with lazy-loading of plugins.
- **Modern look and feel** with Catppuccin theme and custom statusline.
- **Enhanced development experience** with LSP, autocompletion, formatting, and linting.
- **Efficient navigation** with Telescope, Neo-tree, and Flash.

## Plugins

### Theme & UI

- [catppuccin/nvim](https://github.com/catppuccin/nvim): Soothing pastel theme.
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Icons for various plugins.
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A blazing fast and easy to configure statusline.
- [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim): A file explorer tree.
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim): To improve the UI for `vim.ui.select` and `vim.ui.input`.

### Syntax Highlighting

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): For syntax highlighting and more.

### LSP

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim): Portable package manager for Neovim that runs everywhere you need it.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): A collection of common configurations for Neovim's built-in LSP.
<!-- lspsaga is optional and currently disabled in this setup to avoid deprecation warnings -->

### Autocomplete

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion plugin for neovim coded in Lua.
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): nvim-cmp source for neovim's built-in LSP.
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer): nvim-cmp source for buffer words.
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path): nvim-cmp source for path.
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine for Neovim written in Lua.
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip): nvim-cmp source for LuaSnip.

### Git

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git integration for buffers.
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper so awesome, it should be illegal.

### Fuzzy Finder

- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): A highly extendable fuzzy finder over lists.

### Formatting & Linting

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): A lightweight formatting plugin.
<!-- Linting is primarily provided via LSP diagnostics; nvim-lint is optional and currently disabled. -->

### Navigation

- [folke/flash.nvim](https://github.com/folke/flash.nvim): Enhanced f/F/t/T motions.

### Quality of Life

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim): A plugin that shows pending keybindings.
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim): Smart and powerful commenting plugin.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs): A super-fast autopair plugin.
- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim): A snazzy bufferline.

## Key-bindings

| Key | Description |
|---|---|
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>h` | Clear search highlights |
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<C-h>` | Navigate to the window on the left |
| `<C-l>` | Navigate to the window on the right |
| `<C-j>` | Navigate to the window below |
| `<C-k>` | Navigate to the window above |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>e` | Toggle file explorer |
| `<leader>t` | Open terminal |

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
- **Linting** with nvim-lint for code quality
- **Inlay hints** and **semantic tokens** support

### 🔍 **Powerful Navigation & Search**

- **Telescope** fuzzy finder with advanced features
- **Flash** for enhanced motion and search
- **Harpoon** for quick file navigation
- **Project management** with automatic detection
- **Session persistence** across Neovim restarts

### 📝 **Enhanced Editing Experience**

- **Smart autopairs** and **surround** operations
- **Multiple cursors** support
- **Comment toggling** with context awareness
- **Todo comments** highlighting and navigation
- **Better escape** for smoother editing
- **Advanced text objects** and movements

### 🔧 **Git Integration**

- **Gitsigns** for inline git information
- **Fugitive** for comprehensive git operations
- **Diffview** for advanced diff viewing
- **GitHub integration** with Octo

### 🚀 **Performance Optimizations**

- **Lazy loading** of plugins for faster startup
- **Disabled built-in plugins** for reduced memory usage
- **Optimized settings** for better performance
- **Asynchronous operations** where possible

## 📁 Directory Structure

```sh
nvim/
├── init.lua                    # Main configuration entry point
├── lazy-lock.json             # Plugin version lock file
├── lua/
│   ├── config/
│   │   ├── autocmds.lua       # Auto commands configuration
│   │   ├── icons.lua          # Icon definitions
│   │   ├── keymaps.lua        # Key mappings configuration
│   │   ├── lsp.lua            # LSP configuration
│   │   ├── options.lua        # Neovim options
│   │   └── utils.lua          # Utility functions
│   └── plugins/
│       ├── coding.lua         # Completion and formatting plugins
│       ├── editor.lua         # Editor enhancement plugins
│       ├── git.lua            # Git integration plugins
│       ├── lsp.lua            # LSP related plugins
│       ├── ui.lua             # UI and visual plugins
│       └── utils.lua          # Utility plugins
```

## ⚙️ Configuration Highlights

### 🔗 **Modular Plugin Architecture**

- Plugins are organized by category for better maintainability
- Each plugin module focuses on specific functionality
- Easy to enable/disable entire feature sets

### 🎯 **Smart Key Mappings**

- `<Space>` as leader key for easy access
- Logical grouping of commands under leader key
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

## 🎮 Key Bindings

### **General**

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | Leader | Main leader key |
| `<C-s>` | Save | Save current file |
| `<Esc>` | Clear | Clear search highlights |
| `jk` | Escape | Alternative escape in insert mode |

### **Navigation**

| Key | Action | Description |
|-----|--------|-------------|
| `<C-h/j/k/l>` | Window Nav | Navigate between windows |
| `<S-h/l>` | Buffer Nav | Navigate between buffers |
| `<leader>e` | Explorer | Toggle file explorer |
| `<leader>ff` | Find Files | Fuzzy find files |
| `<leader>fg` | Live Grep | Search in files |

### **Code Actions**

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to definition |
| `gr` | References | Show references |
| `K` | Hover | Show documentation |
| `<leader>ca` | Code Action | Show code actions |
| `<leader>cr` | Rename | Rename symbol |
| `<leader>cf` | Format | Format code |

### **Git**

| Key | Action | Description |
|-----|--------|-------------|
| `]h/[h` | Hunk Nav | Navigate git hunks |
| `<leader>ghs` | Stage Hunk | Stage current hunk |
| `<leader>ghr` | Reset Hunk | Reset current hunk |
| `<leader>ghp` | Preview | Preview hunk changes |

## 🛠️ Customization

### **Adding New Plugins**

1. Choose the appropriate category in `lua/plugins/`
2. Add your plugin configuration
3. Restart Neovim

### **Modifying Key Mappings**

Edit `lua/config/keymaps.lua` to customize key bindings

### **LSP Configuration**

Modify `lua/plugins/lsp.lua` to add new language servers

### **Theme Customization**

Edit `lua/plugins/ui.lua` to change themes or UI elements

## 🔧 Supported Languages

- **Web Development**: HTML, CSS, JavaScript, TypeScript, Vue.js
- **Python**: Full support with Pyright
- **Systems**: Lua (Neovim), Bash, JSON, YAML
- **Styling**: Tailwind CSS, SCSS
- **Databases**: SQL
- **DevOps**: Docker, various config files

## 📊 Performance

- **Startup time**: ~50-80ms (cold start with all plugins)
- **Memory usage**: ~30-50MB (base configuration)
- **Plugin count**: 50+ carefully selected plugins
- **Lazy loading**: 90% of plugins load only when needed

## 🐛 Troubleshooting

### **Plugin Issues**

```lua
:Lazy check health    -- Check plugin health
:Lazy clean          -- Remove unused plugins
:Lazy update         -- Update all plugins
```

### **LSP Issues**

```lua
:LspInfo             -- Show LSP information
:Mason               -- Manage LSP servers
:checkhealth         -- Comprehensive health check
```

### **Performance Issues**

```lua
:StartupTime         -- Analyze startup performance
:Lazy profile        -- Profile plugin loading
```

## 🤝 Contributing

Feel free to submit issues, feature requests, or pull requests to improve this configuration!

## 📝 License

This configuration is open source and available under the MIT License.

---

**Happy coding with Neovim! 🎉**
