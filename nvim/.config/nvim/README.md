# Neovim Configuration

A modern, feature-rich, and highly optimized Neovim configuration designed for full-stack development with excellent performance and user experience.

## ✨ Features

### 🎨 Modern UI & Theme

- **Catppuccin Mocha** colorscheme with deep integrations
- **Lualine** statusline with useful information
- **Bufferline** for elegant tab management
- **Snacks Explorer** for integrated file browsing and management
- **Dashboard** with quick actions and startup time display
- **Indent guides** for better code readability

### 🧠 Smart Code Intelligence

- **Full LSP support** with Mason for easy server management
- **Enhanced autocompletion** with nvim-cmp and LuaSnip
- **Treesitter** for accurate syntax highlighting and text objects
- **Code formatting** with Conform.nvim supporting multiple formatters
- **LSP navigation** via Snacks picker for better UX
- **Inlay hints** and **semantic tokens** support

### 🔍 Powerful Navigation & Search

- **Snacks Picker** for unified fuzzy finding (files, grep, buffers, git, GitHub)
- **Flash** for enhanced motion and search
- **Harpoon** for quick file navigation bookmarks
- **Session persistence** with automatic restore

### 📝 Enhanced Editing Experience

- **Smart autopairs** and **surround** operations
- **Comment toggling** with TreeSitter context awareness
- **Enhanced yank history** with Yanky
- **Better escape** for smoother editing
- **Advanced text objects** and movements

### 🔧 Git Workflow

- **Gitsigns** for inline git information and hunk operations
- **Fugitive** for comprehensive git operations
- **Diffview** for advanced diff viewing and file history
- **GitHub integration** via Snacks GitHub CLI picker
- **Git blame**, **log**, and **branch** navigation

### 🚀 Performance & UX

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

### 🔗 Snacks-Powered Architecture

- **Unified picker system** for files, search, git, and GitHub operations
- **Integrated notifications** and dashboard for better UX
- **Smart toggles** for development preferences
- **Terminal management** with multiple backends

### 🎯 Intelligent Key Mappings

- `<Space>` as leader key for easy access
- **Snacks handles**: file operations, search, git, LSP navigation, UI features
- **Keymaps.lua handles**: core editor functionality, window management, diagnostics
- **LSP integration**: Snacks picker for navigation, native LSP for immediate actions
- Context-aware mappings that adapt to file types
- Comprehensive which-key integration for discoverability

### 🛠️ LSP Configuration

- Support for 15+ language servers out of the box
- Automatic server installation and configuration
- Enhanced diagnostics with custom styling
- Code actions, formatting, and renaming support
- **Lua LSP**: Properly configured for Neovim development
  - Recognizes `vim` global and Neovim APIs
  - Includes runtime path and workspace library settings
  - Optimized for plugin development
  - Comprehensive type annotations for formatters and LSP clients

### 📦 Plugin Management

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
    git clone https://github.com/fonger900/dotfiles.git ~/.config/nvim
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

### First Steps

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

### Plugin Management

```lua
:Lazy                 -- Open Lazy plugin manager
:Lazy check health    -- Check plugin health
:Lazy clean          -- Remove unused plugins
:Lazy update         -- Update all plugins
:Lazy profile        -- Profile plugin loading times
```

### LSP Diagnostics

```lua
:LspInfo             -- Show active LSP clients
:Mason               -- Manage LSP servers and tools
:checkhealth         -- Comprehensive health check
:checkhealth snacks  -- Check Snacks configuration
```

### Performance Analysis

```lua
:Snacks profile      -- Profile startup and runtime
:Snacks dashboard    -- Show startup time on dashboard
```

### Common Issues

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

---

## Happy coding with Neovim! 🎉
