---@diagnostic disable: undefined-global
-- Central keymap definitions for smoother navigation and editing.

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = true
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- ============================================================================
-- Enhanced Movement and Navigation
-- ============================================================================

-- Smart line movement: move by display lines when no count, real lines with count
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up" })

-- Window navigation: Use Ctrl+hjkl to move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing: Use Ctrl+arrows for precise window size adjustment
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- ============================================================================
-- Text Manipulation and Editing
-- ============================================================================

-- Move lines up/down: Alt+jk to move current line or selection
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better indenting: Maintain selection after indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- ============================================================================
-- Buffer and File Management
-- ============================================================================

-- Buffer navigation: Shift+hl for quick buffer switching
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- File operations: Leader-based shortcuts for common file actions
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file (universal)" })

-- Window splits: Leader-based window splitting
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- ============================================================================
-- Search and Interface
-- ============================================================================

-- Clear search highlighting: Press Escape to clear search highlights
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlights" })

-- Terminal mode: Double Escape to exit terminal mode to normal mode
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- LSP and Diagnostics Navigation
-- ============================================================================

-- Diagnostic navigation helper: Creates functions for navigating diagnostics
local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({
      count = next and 1 or -1,
      severity = severity,
    })
  end
end

-- Diagnostic keymaps: Navigate and view code diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Previous diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Previous error" })

-- ============================================================================
-- LSP Buffer-Local Keymaps
-- ============================================================================
-- These keymaps are applied when LSP attaches to a buffer

local M = {}

-- LSP attach function: Sets up buffer-local LSP keymaps
function M.on_attach(client, buffer)
  -- Documentation and information
  map("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Show hover documentation" })
  map("n", "gK", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Show signature help" })

  -- Code actions and refactoring
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Code actions" })
  map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buffer, desc = "Rename symbol" })
end

return M
