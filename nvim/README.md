# My Neovim Configuration

A personalized Neovim setup for full-stack development.

## Features

-   **Fast startup time** with lazy-loading of plugins.
-   **Modern look and feel** with Catppuccin theme and custom statusline.
-   **Enhanced development experience** with LSP, autocompletion, formatting, and linting.
-   **Efficient navigation** with Telescope, Neo-tree, and Flash.

## Plugins

### Theme & UI

-   [catppuccin/nvim](https://github.com/catppuccin/nvim): Soothing pastel theme.
-   [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Icons for various plugins.
-   [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A blazing fast and easy to configure statusline.
-   [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim): A file explorer tree.
-   [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim): To improve the UI for `vim.ui.select` and `vim.ui.input`.

### Syntax Highlighting

-   [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): For syntax highlighting and more.

### LSP

-   [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim): Portable package manager for Neovim that runs everywhere you need it.
-   [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
-   [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): A collection of common configurations for Neovim's built-in LSP.
-   [nvimdev/lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim): A light-weight lsp plugin based on neovim built-in lsp with a highly performant UI.

### Autocomplete

-   [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion plugin for neovim coded in Lua.
-   [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): nvim-cmp source for neovim's built-in LSP.
-   [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer): nvim-cmp source for buffer words.
-   [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path): nvim-cmp source for path.
-   [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine for Neovim written in Lua.
-   [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip): nvim-cmp source for LuaSnip.

### Git

-   [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git integration for buffers.
-   [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper so awesome, it should be illegal.

### Fuzzy Finder

-   [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): A highly extendable fuzzy finder over lists.

### Formatting & Linting

-   [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): A lightweight formatting plugin.
-   [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint): An asynchronous linting plugin.

### Navigation

-   [folke/flash.nvim](https://github.com/folke/flash.nvim): Enhanced f/F/t/T motions.

### Quality of Life

-   [folke/which-key.nvim](https://github.com/folke/which-key.nvim): A plugin that shows pending keybindings.
-   [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim): Smart and powerful commenting plugin.
-   [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs): A super-fast autopair plugin.
-   [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim): A snazzy bufferline.

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

## Installation

1.  Clone this repository to your Neovim configuration directory:

    ```bash
    git clone https://github.com/your-username/your-repo-name.git ~/.config/nvim
    ```

2.  Start Neovim. The plugins will be installed automatically.

