-- ============================================================================
-- Neovim Options Configuration
-- ============================================================================
-- Core Neovim settings that define the editor behavior, appearance, and
-- functionality. These settings provide a solid foundation for modern
-- text editing with sensible defaults.

local opt = vim.opt

-- ============================================================================
-- Interface and Interaction
-- ============================================================================

opt.mouse = "a"                           -- Enable mouse support in all modes
opt.clipboard = "unnamedplus"             -- Use system clipboard for all operations
opt.completeopt = "menu,menuone,noselect" -- Completion menu behavior
opt.confirm = true                        -- Ask for confirmation instead of failing
opt.timeoutlen = 300                      -- Timeout for key sequence completion (ms)

-- ============================================================================
-- Visual Appearance
-- ============================================================================

opt.cursorline = true    -- Highlight the line containing the cursor
opt.termguicolors = true -- Enable 24-bit RGB color support
opt.signcolumn = "yes"   -- Always show the sign column (git, diagnostics)
opt.laststatus = 3       -- Global statusline across all windows
opt.list = true          -- Show invisible characters (tabs, spaces)
opt.wrap = false         -- Disable line wrapping for better code reading

-- ============================================================================
-- Line Numbers and Navigation
-- ============================================================================

opt.relativenumber = true -- Show relative line numbers for easy jumping
opt.scrolloff = 4         -- Keep 4 lines visible above/below cursor
opt.sidescrolloff = 8     -- Keep 8 columns visible left/right of cursor

-- ============================================================================
-- Indentation and Formatting
-- ============================================================================

opt.expandtab = true   -- Convert tabs to spaces
opt.shiftwidth = 2     -- Number of spaces for each indentation level
opt.tabstop = 2        -- Number of spaces a tab character represents
opt.shiftround = true  -- Round indent to multiple of shiftwidth
opt.smartindent = true -- Smart auto-indenting for new lines

-- ============================================================================
-- Search Behavior
-- ============================================================================

opt.ignorecase = true      -- Ignore case in search patterns
opt.smartcase = true       -- Override ignorecase if search has uppercase
opt.hlsearch = true        -- Highlight all search matches
opt.incsearch = true       -- Show search matches as you type
opt.inccommand = "nosplit" -- Show live preview of substitute commands

-- ============================================================================
-- Window and Split Behavior
-- ============================================================================

opt.splitbelow = true -- Open horizontal splits below current window
opt.splitright = true -- Open vertical splits to the right of current window

-- ============================================================================
-- File Handling and Persistence
-- ============================================================================

opt.undofile = true  -- Enable persistent undo across sessions
opt.updatetime = 200 -- Faster completion and CursorHold events (ms)

-- ============================================================================
-- Code Folding
-- ============================================================================

opt.foldcolumn = "1"    -- Show fold indicators in the gutter
opt.foldlevel = 99      -- High fold level (don't fold by default)
opt.foldlevelstart = 99 -- Start with all folds open
opt.foldenable = true   -- Enable folding functionality

-- ============================================================================
-- Performance Optimization
-- ============================================================================

opt.synmaxcol = 300     -- Limit syntax highlighting to 300 columns
opt.smoothscroll = true -- Enable smooth scrolling for better UX

-- ============================================================================
-- Language-Specific Settings
-- ============================================================================

-- Python: Use 4-space indentation (PEP 8 standard)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Go: Use tabs instead of spaces (Go standard)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false -- Use actual tab characters
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})
