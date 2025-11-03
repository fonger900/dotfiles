-- =============================================
-- Enhanced Neovim Configuration
-- =============================================
-- Note: .luarc.json configures Lua LSP to recognize 'vim' global
-- and provides proper Neovim development environment

-- Enable the compiled Lua module loader (Neovim >= 0.9) for faster startup
pcall(function()
  if vim.loader and vim.loader.enable then
    vim.loader.enable()
  end
end)

-- Set leader key early (must be set before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable built-in plugins for faster startup
local disabled_plugins = {
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logipat", "rrhelper", "spellfile_plugin",
  "matchit", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers"
}

for _, plugin in pairs(disabled_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Safe module loading with error handling
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Error loading " .. module .. ": " .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- (Removed old notify shim; polyfill below addresses validate deprecations)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
safe_require("config.options")
safe_require("config.keymaps")
safe_require("config.autocmds")

-- Setup lazy.nvim and load plugins
require("lazy").setup({
  spec = {
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.lsp" },
    { import = "plugins.git" },
    { import = "plugins.utils" },
    { import = "plugins.snacks" },
  },
  defaults = { lazy = true },
  install = { colorscheme = { "catppuccin", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin", "rplugin", "spellfile_plugin", "shada_plugin"
      },
    },
  },
})

-- Load LSP and completion after plugins
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    safe_require("config.lsp")
  end,
})
