-- =============================================
-- Enhanced LSP Configuration (modernized)
-- =============================================

local M = {}

-- Setup function to be called after plugins are loaded
function M.setup()
  -- Only apply safe, non-conflicting LSP UI defaults here.
  M.setup_diagnostics()
  M.setup_handlers()
end

function M.setup_diagnostics()
  -- Don't override global diagnostics settings from plugins/lsp.lua.
  -- Only enforce float styling here.
  local current = vim.diagnostic.config()
  vim.diagnostic.config(vim.tbl_deep_extend("force", current or {}, {
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }))
end

-- NOTE: Formatting on save is handled by conform.nvim in this config.
-- Guard against duplicate formatters; only add a simple fallback if conform isn't present.
function M.setup_formatting()
  local ok = pcall(require, "conform")
  if ok then
    return
  end
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
    callback = function(event)
      local clients = vim.lsp.get_clients({ bufnr = event.buf })
      local client = clients[1]
      if client and client:supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ bufnr = event.buf })
      end
    end,
  })
end

function M.setup_handlers()
  -- Patch floating preview once to enforce consistent style for all LSP popups
  if not M._ofp_patched then
    local orig = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      opts.max_width = opts.max_width or math.floor(vim.o.columns * 0.5)
      opts.max_height = opts.max_height or math.floor(vim.o.lines * 0.3)
      opts.zindex = opts.zindex or 50
      opts.focusable = false
      opts.wrap = true
      opts.winblend = opts.winblend or 0

      local bufnr, winnr = orig(contents, syntax, opts, ...)

      if syntax == "markdown" then
        pcall(vim.treesitter.start, bufnr, "markdown")
        vim.wo[winnr].conceallevel = 2
        vim.wo[winnr].concealcursor = "n"
      end

      return bufnr, winnr
    end
    M._ofp_patched = true
  end

  -- Beautiful hover handler with markdown conversion and trimming
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    if err then return end
    if not (result and result.contents) then return end
    config = config or {}
    config.border = config.border or "rounded"
    config.title = config.title or " Hover "
    config.focus_id = "hover-" .. tostring(ctx.bufnr)
    config.close_events = config.close_events or { "CursorMoved", "InsertEnter", "BufHidden" }

    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    lines = vim.lsp.util.trim_empty_lines(lines)
    if vim.tbl_isempty(lines) then return end

    return vim.lsp.util.open_floating_preview(lines, "markdown", config)
  end

  -- Signature help with matching border
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- Do not override publishDiagnostics with deprecated API; use vim.diagnostic instead.
end

function M.setup_additional()
  -- Show line diagnostics on hover
  vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("LspCursorHold", { clear = true }),
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

-- Enhanced capabilities
function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- nvim-cmp capabilities
  local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  -- Folding capabilities for nvim-ufo
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

-- Enhanced on_attach function
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Enable inlay hints if supported
  local ih_cfg = require("config.utils").opts("nvim-lspconfig").inlay_hints or {}
  if ih_cfg.enabled and client:supports_method("textDocument/inlayHint") then
    require("config.utils").toggle.inlay_hints(bufnr, true)
  end

  -- Disable semantic tokens for certain clients (performance)
  if client.name == "tsserver" or client.name == "ts_ls" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- Setup document highlight if supported
  if client:supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Auto-apply safe defaults when module is loaded
pcall(M.setup)

return M
