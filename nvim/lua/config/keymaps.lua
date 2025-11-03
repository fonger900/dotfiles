-- =============================================
-- Keymaps Configuration
-- =============================================

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

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- ============================================================================
-- Leader Key Mappings
-- ============================================================================

-- File operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit without saving" })

-- Clear search highlights
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Window management
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- Tab management
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Terminal mappings
map("n", "<leader>tt", function()
  require("config.utils").terminal(nil, { cwd = require("config.utils").get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>tT", function()
  require("config.utils").terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<c-\\>", function()
  require("config.utils").terminal(nil, { cwd = require("config.utils").get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<c-_>", function()
  require("config.utils").terminal(nil, { cwd = require("config.utils").get_root() })
end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- ============================================================================
-- UI Toggles
-- ============================================================================

map("n", "<leader>ur", function()
  require("config.utils").toggle("relativenumber")
end, { desc = "Toggle Relative Number" })
map("n", "<leader>ul", function()
  require("config.utils").toggle("list")
end, { desc = "Toggle List Chars" })
map("n", "<leader>uw", function()
  require("config.utils").toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>us", function()
  require("config.utils").toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uc", function()
  require("config.utils").toggle("conceallevel", false, { 0, 2 })
end, { desc = "Toggle Conceal" })
map("n", "<leader>uh", function()
  require("config.utils").toggle.inlay_hints()
end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>ud", function()
  require("config.utils").toggle_diagnostics()
end, { desc = "Toggle Diagnostics" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uC", function()
  require("config.utils").toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<leader>uh", function()
    require("config.utils").toggle.inlay_hints()
  end, { desc = "Toggle Inlay Hints" })
end

-- ============================================================================
-- Formatting
-- ============================================================================

map({ "n", "v" }, "<leader>cf", function()
  require("config.utils").format.format({ force = true })
end, { desc = "Format" })

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
-- LSP Keymaps (will be set on LSP attach)
-- ============================================================================

local M = {}

---@param client table LSP client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  local function map_buffer(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = buffer
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- LSP actions
  map_buffer("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end, { desc = "Goto Definition" })
  map_buffer("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
  map_buffer("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  map_buffer("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end, { desc = "Goto Implementation" })
  map_buffer("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, { desc = "Goto T[y]pe Definition" })
  map_buffer("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  map_buffer("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map_buffer("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map_buffer({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  map_buffer("n", "<leader>cA", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end, { desc = "Source Action" })
  map_buffer("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

  -- LSP Saga mappings if available
  if require("config.utils").has("lspsaga.nvim") then
    map_buffer("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover Documentation" })
    map_buffer("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto Definition" })
    map_buffer("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek Definition" })
    map_buffer("n", "gr", "<cmd>Lspsaga finder<cr>", { desc = "LSP Finder" })
    map_buffer("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" })
    map_buffer("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
    map_buffer("n", "<leader>cl", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Line Diagnostics" })
    map_buffer("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Prev Diagnostic" })
    map_buffer("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic" })
    map_buffer("n", "<leader>o", "<cmd>Lspsaga outline<cr>", { desc = "Outline" })
  end
end

return M
