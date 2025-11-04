-- =============================================
-- Configuration Utilities
-- =============================================

local M = {}

local uv = vim.uv

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").spec.plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return vim.notify("Set " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO)
  end

  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      vim.notify("Enabled " .. option, vim.log.levels.INFO)
    else
      vim.notify("Disabled " .. option, vim.log.levels.INFO)
    end
  end
end

local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    vim.notify("Enabled diagnostics", vim.log.levels.INFO)
  else
    vim.diagnostic.disable()
    vim.notify("Disabled diagnostics", vim.log.levels.INFO)
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
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and uv.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or uv.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or uv.cwd()
  end
  ---@cast root string
  return root
end

-- Simple setup aims to avoid helper wrappers tied to specific picker plugins.



-- LSP utilities
M.lsp = {}

function M.lsp.get_clients(opts)
  local ret = vim.lsp.get_clients(opts)
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
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
  local configs = require("lspconfig.configs")
  return rawget(configs, name)
end

---@param name string
---@param fn fun(client: any, buffer: integer)
function M.lsp.on_dynamic_capability(name, fn)
  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspDynamicCapability",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client.name == name then
        return fn(client, buffer)
      end
    end,
  })
end

M.toggle = {}

---@param buf? number
function M.toggle.inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if type(ih) == "function" then
    ih(buf, value)
  elseif type(ih) == "table" and ih.enable then
    if value == nil then
      value = not ih.is_enabled(buf)
    end
    ih.enable(buf, value)
  end
end

return M
