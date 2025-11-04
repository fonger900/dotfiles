-- Simple Neovim Configuration
-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable faster startup
if vim.loader then vim.loader.enable() end

-- Load configuration
require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")
