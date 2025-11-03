-- =============================================
-- LSP Configuration Plugins
-- =============================================

return {
  -- LSP Configuration
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
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      capabilities = {},
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                version = "LuaJIT",
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  "vim",
                  "it",
                  "describe",
                  "before_each",
                  "after_each"
                },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        },
        pyright = {},
        ts_ls = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("package.json", "tsconfig.json")(fname)
          end,
          single_file_support = false,
        },
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
            return require("lspconfig.util").root_pattern("tailwind.config.js", "tailwind.config.ts", "postcss.config.js",
              "postcss.config.ts")(fname)
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
      setup = {},
    },
    config = function(_, opts)
      local Util = require("config.utils")

      -- Setup on_attach hooks (keymaps, inlay hints, highlights)
      Util.lsp.on_attach(function(client, buffer)
        -- buffer-local keymaps
        require("config.keymaps").on_attach(client, buffer)
        -- extra LSP UX (inlay hints, doc highlights, etc.)
        local ok, LspCfg = pcall(require, "config.lsp")
        if ok and LspCfg and type(LspCfg.on_attach) == "function" then
          pcall(LspCfg.on_attach, client, buffer)
        end
      end)

      -- Diagnostics config (modern API: configure signs via vim.diagnostic.config)
      local icons = require("config.icons").diagnostics
      local sign_text = {
        [vim.diagnostic.severity.ERROR] = icons.Error,
        [vim.diagnostic.severity.WARN]  = icons.Warn,
        [vim.diagnostic.severity.HINT]  = icons.Hint,
        [vim.diagnostic.severity.INFO]  = icons.Info,
      }

      vim.diagnostic.config(vim.tbl_deep_extend("force", vim.deepcopy(opts.diagnostics), {
        signs = { text = sign_text },
      }))

      local servers = opts.servers
      -- Resolve dynamic settings tables (allows lazy requiring of schemastore, etc.)
      for name, cfg in pairs(servers) do
        if type(cfg) == "table" and type(cfg.settings) == "function" then
          local ok, res = pcall(function()
            return cfg.settings()
          end)
          if ok and type(res) == "table" then
            cfg.settings = res
          else
            cfg.settings = {}
          end
        end
      end
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
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
      end

      -- Setup mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      if have_mason then
        local ensure_installed = vim.tbl_keys(servers)
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup }
        })
      else
        -- Fallback: setup servers manually if mason-lspconfig is not available
        for server, _ in pairs(servers) do
          setup(server)
        end
      end

      -- Handle deno/tsserver conflicts in server setup
      -- This is handled more elegantly by setting proper root_dir patterns
      -- for each server which prevents conflicts naturally
    end,
  },

  -- Mason for LSP installer
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
    version = false,
  },
}
