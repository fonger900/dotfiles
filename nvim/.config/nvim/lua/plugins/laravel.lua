return {
  -- ============================================================================
  -- Laravel & PHP Development Configuration
  -- ============================================================================

  -- 1. Treesitter: Add PHP & Blade support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure parsers are installed
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php", "php_only", "blade" })
      end

      -- Manual configuration for blade parser (often required for custom parsers)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end,
    config = function(_, opts)
      -- Standard setup
      require("nvim-treesitter.configs").setup(opts)

      -- Register .blade.php filetype manually to ensure correct detection
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })
    end,
  },

  -- 2. Mason: Ensure PHP tools are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "intelephense",    -- PHP LSP
        "blade-formatter", -- Blade Formatter
        "pint",            -- Laravel Pint (PHP Formatter)
      })
    end,
  },

  -- 3. LSP Config: Setup Intelephense
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          filetypes = { "php", "blade", "php_only" },
          settings = {
            intelephense = {
              filetypes = { "php", "blade", "php_only" },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },
      },
    },
  },

  -- 4. Conform: Configure Formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint" },
        blade = { "blade-formatter" },
      },
    },
  },

  -- 5. Laravel.nvim: Artisan commands & utilities
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Required for UI
      "tpope/vim-dotenv",              -- Recommended
      "MunifTanjim/nui.nvim",          -- Required
    },
    cmd = { "Sail", "Artisan" },
    keys = {
      { "<leader>la", ":Artisan<cr>",            desc = "Laravel Artisan" },
      { "<leader>lr", ":Artisan route:list<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":Artisan make:model<cr>", desc = "Laravel Make Model" },
    },
    config = true,
  },
}
