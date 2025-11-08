-- ============================================================================
-- LSP Configuration and Language Servers
-- ============================================================================
-- This file configures Language Server Protocol (LSP) functionality for
-- various programming languages including syntax highlighting, diagnostics,
-- code completion, and intelligent code navigation.

return {
  -- Main LSP configuration plugin
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },                      -- Load when opening files
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false }, -- Project-local config
      { "folke/neodev.nvim",  opts = {} },                       -- Neovim development setup
      "mason.nvim",                                              -- Package manager for LSP servers
      "williamboman/mason-lspconfig.nvim",                       -- Bridge between Mason and lspconfig
    },
    opts = {
      -- Diagnostic display configuration
      diagnostics = {
        underline = true, -- Underline problematic code
        update_in_insert = false, -- Don't show diagnostics while typing
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" }, -- Inline diagnostic text
        severity_sort = true, -- Sort by severity (errors first)
        float = { focusable = false, border = "rounded" }, -- Floating diagnostic window style
      },
      -- Language server configurations
      -- Each server can have custom settings for language-specific features
      servers = {
        -- Lua language server (for Neovim config development)
        lua_ls = {},
        -- Python language server
        basedpyright = {},       -- Use default configuration
        -- TypeScript/JavaScript language server
        ts_ls = {},         -- Use default configuration
        -- Web development servers
        html = {},          -- HTML language server
        cssls = {},         -- CSS language server
        tailwindcss = {},   -- TailwindCSS language server
        eslint = {},        -- ESLint for JavaScript/TypeScript linting
        -- Systems programming
        rust_analyzer = {}, -- Rust language server
        gopls = {},         -- Go language server
        -- Configuration files
        jsonls = {},        -- JSON language server
        vue_ls = {},
      },
    },
    config = function(_, opts)
      -- Function called when LSP attaches to a buffer
      -- Sets up buffer-local keymaps and features
      local on_attach = function(client, bufnr)
        -- Load LSP-specific keymaps (defined in config/keymaps.lua)
        require("config.keymaps").on_attach(client, bufnr)

        -- Enable document highlighting (highlight symbol under cursor)
        if client.supports_method("textDocument/documentHighlight") then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight, -- Highlight matching symbols
          })
        end
      end

      -- Configure global diagnostic settings
      vim.diagnostic.config(opts.diagnostics)

      -- Setup LSP client capabilities (what features the client supports)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Enhance capabilities with nvim-cmp completion if available
      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Setup function for individual language servers
      local servers = opts.servers
      local function setup(server)
        -- Merge server-specific config with common config
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities), -- LSP capabilities
          on_attach = on_attach,                     -- Attach function for keymaps/features
        }, servers[server] or {})
        -- Initialize the language server
        require("lspconfig")[server].setup(server_opts)
      end

      -- Use Mason to manage language server installation and setup
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers), -- Install all configured servers
        handlers = { setup },                     -- Use our setup function for each server
      })
    end,
  },

  -- Mason: Package manager for LSP servers, formatters, and linters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",                                                 -- Load on :Mason command
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } }, -- Open Mason UI
    build = ":MasonUpdate",                                        -- Update packages on plugin update
    opts = {
      -- Tools to automatically install
      ensure_installed = {
        "stylua",   -- Lua formatter
        "prettier", -- JavaScript/TypeScript/CSS/HTML formatter
        "black",    -- Python formatter
        "isort",    -- Python import sorter
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      -- Function to ensure all specified tools are installed
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install() -- Install missing tools
          end
        end
      end

      -- Install tools after registry refresh (if available)
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
