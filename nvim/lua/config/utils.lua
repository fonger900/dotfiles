-- =============================================
-- Configuration Utilities
-- =============================================

local M = {}


---@param plugin string
function M.has(plugin)
  return require("lazy.plugins")[plugin] ~= nil
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.plugins")[name]
  if not plugin then
    return {}
  end
  return plugin.opts or {}
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    vim.opt_local[option] = vim.opt_local[option]:get() == values[1] and values[2] or values[1]
    return vim.notify("Set " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO)
  end

  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    local status = vim.opt_local[option]:get() and "Enabled" or "Disabled"
    vim.notify(status .. " " .. option, vim.log.levels.INFO)
  end
end

function M.toggle_diagnostics()
  local enabled = vim.diagnostic.is_enabled()
  if enabled then
    vim.diagnostic.enable(false)
    vim.notify("Disabled diagnostics", vim.log.levels.INFO)
  else
    vim.diagnostic.enable()
    vim.notify("Enabled diagnostics", vim.log.levels.INFO)
  end
end

function M.deprecate(old, new)
  vim.notify(old .. " is deprecated. Please use " .. new .. " instead", vim.log.levels.WARN, { title = "LazyVim" })
end

-- Deduplicates a list preserving order
function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

M.root_patterns = { ".git", "lua" }

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  local buf = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(buf)
  path = path ~= "" and vim.fs.dirname(path) or vim.uv.cwd()
  local root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
  return root and vim.fs.dirname(root) or path
end

-- LSP utilities
M.lsp = {}

function M.lsp.get_clients(opts)
  return vim.lsp.get_clients(opts)
end

---@param on_attach fun(client, buffer)
function M.lsp.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---@param name string
function M.lsp.get_config(name)
  return require("lspconfig.configs")[name]
end

---@param name string
---@param fn fun(client: any, buffer: integer)
function M.lsp.on_dynamic_capability(name, fn)
  vim.lsp.callbacks[name] = vim.lsp.callbacks[name] or {}
  table.insert(vim.lsp.callbacks[name], fn)
end

M.toggle = {}

---@param buf? number
function M.toggle.inlay_hints(buf)
  vim.lsp.inlay_hint.enable(buf, not vim.lsp.inlay_hint.is_enabled(buf))
end

return M
