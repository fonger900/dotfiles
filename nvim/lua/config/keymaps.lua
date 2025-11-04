-- Keymaps
local keymap = require("snacks").keymap

-- Better movement
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down" })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Move lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffer navigation
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Clear search
keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- File operations
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Window splits
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split below" })
keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split right" })

-- Terminal
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go({ severity = severity }) end
end

keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })

-- LSP keymaps (to be used in LSP on_attach)
local M = {}

function M.on_attach(client, buffer)
  keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
  keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Signature help" })
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Code action" })
  keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buffer, desc = "Rename" })
end

return M
