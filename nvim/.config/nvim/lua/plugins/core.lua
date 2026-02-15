-- ============================================================================
-- Core UI and Essential Utility Plugins
-- ============================================================================
-- This file contains fundamental UI components and essential utilities that
-- form the foundation of the Neovim experience: colorscheme, statusline,
-- bufferline, terminal integration, and core editing enhancements.

return {
  -- ============================================================================
  -- Core Dependencies
  -- ============================================================================

  -- Plenary: Lua utility library used by many plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Vim-repeat: Makes plugin actions repeatable with the '.' command
  { "tpope/vim-repeat",      event = "VeryLazy" },

  -- ============================================================================
  -- Visual Theme and Appearance
  -- ============================================================================

  -- Tokyonight colorscheme: Darker, high-contrast
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- File type icons for enhanced visual file identification
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- Load when needed by other plugins
    opts = {
      override = {
        -- Custom icon overrides for specific file types
        zsh = { icon = "", color = "#428850", name = "Zsh" },
        [".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" },
      },
    },
  },

  -- ============================================================================
  -- Status and Buffer Management
  -- ============================================================================

  -- Lualine: Customizable statusline with project info, LSP status, etc.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- Load after startup for better performance
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight", -- Match colorscheme
        globalstatus = true,  -- Single statusline across all windows
      },
      sections = {
        -- Left side: Mode indicator
        lualine_a = { "mode" },
        -- Git info and diagnostics
        lualine_b = { "branch", "diff", "diagnostics" },
        -- Current file path
        lualine_c = { { "filename", path = 1 } },
        -- Right side: File info
        lualine_x = { "encoding", "fileformat", "filetype" },
        -- Progress through file
        lualine_y = { "progress" },
        -- Cursor location
        lualine_z = { "location" },
      },
      extensions = { "lazy", "mason" }, -- Integrate with plugin managers
    },
  },

  -- Bufferline: Tab-like interface for open buffers
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy", -- Load after initial setup
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      -- Buffer management keymaps
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",   desc = "Toggle pin" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = "bdelete! %d",  -- Command to close buffers
        diagnostics = "nvim_lsp",       -- Show LSP diagnostics in bufferline
        always_show_bufferline = false, -- Hide when only one buffer open
      },
    },
  },



  -- ============================================================================
  -- Enhanced Editing Features
  -- ============================================================================

  -- Yanky: Advanced yank/paste functionality with history
  {
    "gbprod/yanky.nvim",
    dependencies = {
      -- SQLite for persistent yank history (Unix only)
      { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") }
    },
    opts = {
      ring = {
        -- Use SQLite on Unix, fallback to shada on Windows
        storage = jit.os:find("Windows") and "shada" or "sqlite"
      },
    },
    keys = {
      -- Yank history and enhanced paste operations
      { "<leader>p", function() vim.cmd("YankyRingHistory") end, desc = "Yank History" },
      { "y",         "<Plug>(YankyYank)",                        mode = { "n", "x" } }, -- Enhanced yank
      { "p",         "<Plug>(YankyPutAfter)",                    mode = { "n", "x" } }, -- Enhanced paste after
      { "P",         "<Plug>(YankyPutBefore)",                   mode = { "n", "x" } }, -- Enhanced paste before
    },
  },

  -- Harpoon: Lightning-fast file navigation for frequently used files
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", -- Use version 2
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      -- File marking and navigation
      { "<leader>H", function() require("harpoon"):list():append() end,                                 desc = "Harpoon file" },
      { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
      -- Quick access to first 4 marked files
      { "<leader>1", function() require("harpoon"):list():select(1) end,                                desc = "Harpoon 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end,                                desc = "Harpoon 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end,                                desc = "Harpoon 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end,                                desc = "Harpoon 4" },
    },
  },

  -- ============================================================================
  -- UI Enhancements
  -- ============================================================================

  -- Noice: Modern UI for messages, cmdline and popup menu
  {
    "folke/noice.nvim",
    event = "VeryLazy",                        -- Load after startup
    dependencies = { "MunifTanjim/nui.nvim" }, -- UI component library
    opts = {
      lsp = {
        -- These overrides improve markdown rendering in hover docs and cmp.
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- This route filters out the annoying "No information available" spam.
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,         -- Use bottom search bar
        command_palette = true,       -- Command palette style cmdline
        long_message_to_split = true, -- Open long messages in split
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
  },

  -- Vim Visual Multi: Multiple cursor editing (like Sublime Text/VSCode)
  {
    "mg979/vim-visual-multi",
    keys = {
      { "<C-n>", desc = "Multi-cursor word" },
      { "<C-Down>", desc = "Multi-cursor down" },
      { "<C-Up>", desc = "Multi-cursor up" },
    },
  },
}
