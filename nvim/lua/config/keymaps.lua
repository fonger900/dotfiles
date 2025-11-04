-- ============================================================================
-- Keymap Configuration
-- ============================================================================
-- Central keymap definitions for enhanced Neovim navigation, editing, and
-- workflow. Uses Snacks.keymap for consistent keymap management across
-- all modes and contexts.

local keymap = require("snacks").keymap

-- ============================================================================
-- Enhanced Movement and Navigation
-- ============================================================================

-- Smart line movement: move by display lines when no count, real lines with count
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down" })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up" })

-- Window navigation: Use Ctrl+hjkl to move between windows
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing: Use Ctrl+arrows for precise window size adjustment
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- ============================================================================
-- Text Manipulation and Editing
-- ============================================================================

-- Move lines up/down: Alt+jk to move current line or selection
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better indenting: Maintain selection after indenting in visual mode
keymap.set("v", "<", "<gv", { desc = "Indent left (keep selection)" })
keymap.set("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- ============================================================================
-- Buffer and File Management
-- ============================================================================

-- Buffer navigation: Shift+hl for quick buffer switching
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- File operations: Leader-based shortcuts for common file actions
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file (universal)" })

-- Window splits: Leader-based window splitting
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- ============================================================================
-- Search and Interface
-- ============================================================================

-- Clear search highlighting: Press Escape to clear search highlights
keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlights" })

-- Terminal mode: Double Escape to exit terminal mode to normal mode
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- LSP and Diagnostics Navigation
-- ============================================================================

-- Diagnostic navigation helper: Creates functions for navigating diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go({ severity = severity }) end
end

-- Diagnostic keymaps: Navigate and view code diagnostics
keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
keymap.set("n", "[d", diagnostic_goto(false), { desc = "Previous diagnostic" })
keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Previous error" })

-- ============================================================================
-- LSP Buffer-Local Keymaps
-- ============================================================================
-- These keymaps are applied when LSP attaches to a buffer

local M = {}

-- LSP attach function: Sets up buffer-local LSP keymaps
function M.on_attach(client, buffer)
  -- Documentation and information
  keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Show hover documentation" })
  keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Show signature help" })

  -- Code actions and refactoring
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Code actions" })
  keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buffer, desc = "Rename symbol" })
end

return M
