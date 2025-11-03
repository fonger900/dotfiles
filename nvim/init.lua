-- ==========================
-- Neovim Starter Config (Fullstack)
-- ==========================

-- Set the leader key to space
vim.g.mapleader = " "

-- =============================================================================
-- -- Options
-- =============================================================================
-- For more information about the options, see `:help option-list`

-- Editor appearance
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.opt.signcolumn = "yes" -- Always show the sign column

-- Indentation
vim.opt.tabstop = 4 -- Number of spaces a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Search
vim.opt.hlsearch = true -- Highlight all matches on search
vim.opt.incsearch = true -- Show search results as you type
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters

-- Performance
vim.opt.updatetime = 50 -- Faster completion

-- Behavior
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.scrolloff = 8 -- Keep 8 lines of context around the cursor

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

-- Load config
require("config.keymaps")
require("config.lsp")
require("config.cmp")
