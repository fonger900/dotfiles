-- =========================================================================
-- Global Bootstrapping
-- =========================================================================
-- Establish leader keys, enable the Lua bytecode loader, and disable providers
-- as early as possible to keep startup lightweight.

---@diagnostic disable: undefined-global

vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.loader then
  vim.loader.enable()
end

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

return true
