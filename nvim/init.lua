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



-- Safe module loading with error handling
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Error loading " .. module .. ": " .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- Bootstrap lazy.nvim
safe_require("config.lazy")

-- Load core configuration
safe_require("config.options")
safe_require("config.keymaps")
safe_require("config.autocmds")



-- Load LSP and completion after plugins
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    safe_require("config.lsp")
  end,
})
