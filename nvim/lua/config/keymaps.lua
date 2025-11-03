local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = ' '

-- Save & quit
keymap('n', '<leader>w', ':w<CR>', { desc = 'Save' })
keymap('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
keymap('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Split windows
keymap('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically' })
keymap('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally' })

-- Navigate windows
keymap('n', '<C-h>', '<C-w>h', { desc = 'Navigate to the window on the left' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Navigate to the window on the right' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Navigate to the window below' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Navigate to the window above' })

-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live grep' })
keymap('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Find buffers' })

-- Buffer navigation
keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- NeoTree
keymap('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })
