-- =============================================
-- Neovim Options Configuration
-- =============================================

local opt = vim.opt

-- ============================================================================
-- General
-- ============================================================================
opt.mouse = "a"                           -- Enable mouse mode
opt.clipboard = "unnamedplus"             -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.conceallevel = 3                      -- Hide * markup for bold and italic
opt.confirm = true                        -- Confirm to save changes before exiting modified buffer
opt.cursorline = true                     -- Enable highlighting of the current line
opt.expandtab = true                      -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt"            -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true                     -- Ignore case
opt.inccommand = "nosplit"                -- Preview incremental substitute
opt.laststatus = 3                        -- Global statusline
opt.list = true                           -- Show some invisible characters (tabs...
opt.pumblend = 10                         -- Popup blend
opt.pumheight = 10                        -- Maximum number of entries in a popup
opt.relativenumber = true                 -- Relative line numbers
opt.scrolloff = 4                         -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true                     -- Round indent
opt.shiftwidth = 2                        -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false                      -- Dont show mode since we have a statusline
opt.sidescrolloff = 8                     -- Columns of context
opt.signcolumn = "yes"                    -- Always show the signcolumn
opt.smartcase = true                      -- Don't ignore case with capitals
opt.smartindent = true                    -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true                     -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true                     -- Put new windows right of current
opt.tabstop = 2                           -- Number of spaces tabs count for
opt.termguicolors = true                  -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200                      -- Save swap file and trigger CursorHold
opt.virtualedit = "block"                 -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full"        -- Command-line completion mode
opt.winminwidth = 5                       -- Minimum window width
opt.wrap = false                          -- Disable line wrap

-- ============================================================================
-- UI
-- ============================================================================
opt.number = true                         -- Print line number
opt.pumblend = 10                         -- Popup blend
opt.pumheight = 10                        -- Maximum number of entries in a popup
opt.showmode = false                      -- Don't show mode since we have a statusline
opt.signcolumn = "yes"                    -- Always show the signcolumn
opt.termguicolors = true                  -- True color support
opt.winminwidth = 5                       -- Minimum window width

-- ============================================================================
-- Search
-- ============================================================================
opt.hlsearch = true                       -- Set highlight on search
opt.ignorecase = true                     -- Case insensitive searching
opt.smartcase = true                      -- Case sensitive if uppercase is used
opt.incsearch = true                      -- Show search results as you type

-- ============================================================================
-- Performance
-- ============================================================================
opt.lazyredraw = false                    -- Don't redraw while executing macros
opt.synmaxcol = 300                       -- Max column for syntax highlight
opt.updatetime = 200                      -- Reduce updatetime for CursorHold
opt.ttimeoutlen = 10                      -- Time in milliseconds to wait for a key code sequence to complete

-- ============================================================================
-- Fold
-- ============================================================================
opt.foldcolumn = "1"                      -- '0' is not bad
opt.foldlevel = 99                        -- Using ufo provider need a large value
opt.foldlevelstart = 99
opt.foldenable = true

-- ============================================================================
-- Neovim specific
-- ============================================================================
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- ============================================================================
-- Fix markdown indentation settings
-- ============================================================================
vim.g.markdown_recommended_style = 0

-- ============================================================================
-- Disable some built-in plugins we don't want
-- ============================================================================
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- ============================================================================
-- Language-specific settings
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- ============================================================================
-- Global variables
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Skip some remote provider loading
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0