-- =============================================
-- Keymaps Configuration
-- =============================================
-- Note: Many file/search/git mappings are handled by Snacks.nvim
-- See: lua/plugins/snacks.lua for picker and utility keymaps

local map = vim.keymap.set

-- ============================================================================
-- Better defaults
-- ============================================================================

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffer management
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete buffer (force)" })
-- Note: <leader>bd is handled by Snacks.bufdelete() in snacks.lua

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- ============================================================================
-- Essential File & Session Operations
-- ============================================================================

-- Core file operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit without saving" })
map("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Lazy plugin manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Clear search highlights
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- ============================================================================
-- Window & Tab Management
-- ============================================================================
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>wo", "<C-W>o", { desc = "Only window", remap = true })

-- Tab management
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })



-- Terminal mode mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- ============================================================================
-- UI Toggles (Note: Many toggles now handled by Snacks in snacks.lua)
-- ============================================================================
-- Snacks handles: spell, wrap, relativenumber, diagnostics, inlay_hints,
-- conceallevel, treesitter, background, line_number, indent, dim





-- ============================================================================
-- Diagnostic navigation
-- ============================================================================

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- ============================================================================
-- LSP Keymaps (Note: Snacks handles many LSP pickers, see snacks.lua)
-- ============================================================================
-- Snacks provides: gd, gD, gr, gI, gy (via picker for better UX)
-- This section provides fallback/alternative LSP bindings

local M = {}

---@param client table LSP client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  local function map_buffer(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = buffer
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Core LSP actions (native)
  map_buffer("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  map_buffer("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map_buffer("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map_buffer({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  map_buffer("n", "<leader>cA", function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source" },
        diagnostics = {},
      },
    })
  end, { desc = "Source Action" })
  map_buffer("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

  -- Diagnostic navigation (native)
  map_buffer("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  map_buffer("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
  map_buffer("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  map_buffer("n", "[e", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { desc = "Prev Error" })
  map_buffer("n", "]e", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { desc = "Next Error" })

  -- Note: gd, gD, gr, gI, gy are handled by Snacks picker for better UX
  -- If you prefer native LSP, uncomment these:
  -- map_buffer("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
  -- map_buffer("n", "gr", vim.lsp.buf.references, { desc = "References" })
  -- map_buffer("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  -- map_buffer("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
  -- map_buffer("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
end

return M
