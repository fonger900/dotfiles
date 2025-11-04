-- =============================================
-- LSP Configuration Plugins
-- =============================================

return {
  -- LSP Configuration & Servers
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      -- Default options for all servers
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
      inlay_hints = {
        enabled = false,
      },
      -- Capabilities are dynamically set by the config function
      capabilities = {},
      -- Server-specific configurations
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim", "it", "describe", "before_each", "after_each" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {},
        denols = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(fname)
          end,
        },
        vue_ls = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        },
        html = {},
        cssls = {},
        tailwindcss = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.ts",
              "postcss.config.js",
              "postcss.config.ts"
            )(fname)
          end,
        },
        jsonls = {
          settings = function()
            local ok, schemastore = pcall(require, "schemastore")
            return {
              json = {
                schemas = ok and schemastore.json.schemas() or nil,
                format = { enable = true },
                validate = { enable = true },
              },
            }
          end,
        },
      },
      -- Custom server setup hooks
      setup = {},
    },
    config = function(_, opts)
      local lsp_utils = require("utils.lsp")

      -- Configure buffer-local behavior on LSP attach
      lsp_utils.on_attach(function(client, bufnr)
        -- Keymaps
        require("config.keymaps").on_attach(client, bufnr)

        -- Inlay hints
        local ih_cfg = opts.inlay_hints or {}
        if ih_cfg.enabled and client.supports_method("textDocument/inlayHint") then
          require("config.utils").toggle.inlay_hints(bufnr, true)
        end

        -- Document highlights
        if client.supports_method("textDocument/documentHighlight") then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Disable semantic tokens for performance
        if client.name == "tsserver" or client.name == "ts_ls" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end)

      -- Configure diagnostic signs
      local icons = require("config.icons").diagnostics
      vim.diagnostic.config(vim.tbl_deep_extend("force", vim.deepcopy(opts.diagnostics), {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.HINT] = icons.Hint,
            [vim.diagnostic.severity.INFO] = icons.Info,
          },
        },
      }))


      -- Get capabilities
      local capabilities = lsp_utils.get_capabilities()

      -- Setup servers with mason-lspconfig
      local servers = opts.servers
      local mlsp = require("mason-lspconfig")

      mlsp.setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server)
            local server_opts = vim.tbl_deep_extend("force", {
              capabilities = vim.deepcopy(capabilities),
            }, servers[server] or {})

            if opts.setup[server] then
              if opts.setup[server](server, server_opts) then
                return
              end
            elseif opts.setup["*"] then
              if opts.setup["*"](server, server_opts) then
                return
              end
            end
            require("lspconfig")[server].setup(server_opts)
          end,
        },
      })
    end,
  },

  -- Mason for LSP/formatter/linter installers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "flake8",
        "prettier",
        "prettierd",
        "isort",
        "black",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Schema store for JSON
  {
    "b0o/schemastore.nvim",
    lazy = true,
    version = false, -- Avoids fatal error on startup
  },
}
