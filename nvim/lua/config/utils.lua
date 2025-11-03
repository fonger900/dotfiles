-- =============================================
-- Configuration Utilities
-- =============================================

local M = {}

-- Prefer vim.uv (Neovim >= 0.10), fallback to vim.loop for compatibility
local uv = vim.uv or vim.loop

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

-- this will return a function that calls telescope.
-- cwd will default to util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    if builtin == "files" then
      if uv.fs_stat((opts.cwd or uv.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= uv.cwd() then
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          M.telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

-- Terminal utility
function M.terminal(cmd, opts)
  opts = opts or {}
  local float_term = nil

  if vim.fn.has("nvim-0.8") == 1 then
    -- Use toggleterm if available
    local ok, toggleterm = pcall(require, "toggleterm.terminal")
    if ok then
      local Terminal = toggleterm.Terminal
      if not float_term then
        float_term = Terminal:new({
          cmd = cmd,
          dir = opts.cwd or M.get_root(),
          direction = "float",
          float_opts = {
            border = "rounded",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
          },
        })
      end
      float_term:toggle()
      return
    end
  end

  -- Fallback to basic terminal
  vim.cmd("tabnew")
  if opts.cwd then
    vim.cmd("lcd " .. opts.cwd)
  end
  vim.cmd("terminal " .. (cmd or ""))
  vim.cmd("startinsert")
end

-- LSP utilities
M.lsp = {}

function M.lsp.get_clients(opts)
  local ret = {} ---@type table[] LSP client objects
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client table LSP client object
      ret = vim.tbl_filter(function(client)
        return client:supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
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
---@param fn fun(name:string)
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

-- Format utilities
M.format = {}

-- registry for custom formatters (kept for compatibility)
M.format.formatters = M.format.formatters or {}

---@param opts? {force?:boolean}
function M.format.format(opts)
  local buf = vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end
  local formatters = M.format.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)

  if #client_ids == 0 then
    return
  end

  if formatters.null_ls then
    return vim.lsp.buf.format(vim.tbl_deep_extend("force", {
      bufnr = buf,
      filter = function(client)
        return vim.tbl_contains(client_ids, client.id)
      end,
    }, require("config.utils").opts("nvim-lspconfig").format or {}))
  end

  return vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  }, require("config.utils").opts("nvim-lspconfig").format or {}))
end

---@param buf? number
---@return LazyFormatterState
function M.format.get_formatters(buf)
  local buf = buf or vim.api.nvim_get_current_buf()
  local formatters = {} ---@type LazyFormatter[]
  local have_primary = false

  -- check for primary formatters (conform)
  if M.has("conform.nvim") then
    local conform = require("conform")
    for _, formatter in ipairs(conform.list_formatters_for_buffer(buf)) do
      if formatter.available then
        have_primary = true
        formatters[#formatters + 1] = {
          name = formatter.name,
          primary = true,
          priority = 1,
          format = function(opts)
            return conform.format(vim.tbl_deep_extend("force", {
              bufnr = buf,
              async = false,
              dry_run = false,
              formatters = { formatter.name },
            }, opts))
          end,
        }
      end
    end
  end

  -- check for lsp formatters
  local clients = M.lsp.get_clients({ bufnr = buf })
  local null_ls = package.loaded["null-ls"] and
      require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}

  ---@param client table LSP client object
  local function add_client(client)
    local info = {
      name = client.name,
      primary = false,
      priority = 2,
      format = function(opts)
        return vim.lsp.buf.format(vim.tbl_deep_extend("force", { bufnr = buf }, opts))
      end
    }
    -- HACK: show only one null-ls formatter
    if client.name == "null-ls" then
      if #null_ls > 0 then
        info.name = null_ls[1].name
      end
      info.null_ls = true
    end
    formatters[#formatters + 1] = info
  end

  for _, client in ipairs(clients) do
  local supports_format = client:supports_method("textDocument/formatting")
    or client:supports_method("textDocument/rangeFormatting")
    if supports_format and not (client.name == "null-ls" and #null_ls == 0) then
      add_client(client)
    end
  end

  -- sort by priority
  table.sort(formatters, function(a, b)
    if a.primary ~= b.primary then
      return a.primary
    end
    return a.priority < b.priority
  end)

  return {
    active = formatters,
    available = {},
    null_ls = #null_ls > 0 and formatters[1] and formatters[1].null_ls or false,
  }
end

---@return LazyFormatter?
function M.format.formatter()
  local formatters = M.format.get_formatters()
  return formatters.active[1]
end

function M.format.register(formatter)
  M.format.formatters[#M.format.formatters + 1] = formatter
  table.sort(M.format.formatters, function(a, b)
    return a.priority < b.priority
  end)
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
