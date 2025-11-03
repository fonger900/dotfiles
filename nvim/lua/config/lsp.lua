-- =============================================
-- Enhanced LSP Configuration
-- =============================================

local M = {}

-- Setup function to be called after plugins are loaded
function M.setup()
  local util = require("config.utils")

  -- Setup diagnostics
  M.setup_diagnostics()

  -- Setup formatting
  M.setup_formatting()

  -- Setup LSP handlers
  M.setup_handlers()

  -- Additional LSP settings
  M.setup_additional()
end

function M.setup_diagnostics()
  -- Diagnostic configuration
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    severity_sort = true,
    signs = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- Diagnostic signs
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

function M.setup_formatting()
  -- Format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
    callback = function(event)
      local clients = vim.lsp.get_clients({ bufnr = event.buf })
      local client = clients[1]
      if client and client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({
          bufnr = event.buf,
          filter = function(c)
            return c.name ~= "tsserver" and c.name ~= "jsonls"
          end,
        })
      end
    end,
  })
end

function M.setup_handlers()
  -- LSP handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- Customize how diagnostics are displayed
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      source = "always",
      prefix = "●",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
  })
end

function M.setup_additional()
  -- Highlight symbol under cursor
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true }),
    callback = function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients > 0 then
        vim.lsp.buf.document_highlight()
      end
    end,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("LspDocumentHighlightClear", { clear = true }),
    callback = function()
      vim.lsp.buf.clear_references()
    end,
  })

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

  -- Attach keymaps
  require("config.keymaps").on_attach(client, bufnr)

  -- Enable inlay hints if supported
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint(bufnr, true)
  end

  -- Disable semantic tokens for certain clients (performance)
  if client.name == "tsserver" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- Setup document highlight if supported
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
end

return M