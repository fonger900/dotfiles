-- =============================================
-- Snacks.nvim: modern UI, dashboard, notifier, indent, profiler, picker
-- =============================================

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    dashboard = {
      enabled = true,
      preset = "starter",
    },
    indent = {
      enabled = true,
    },
    profiler = {
      enabled = true,
    },
    picker = {
      enabled = true,
      ui = { border = "rounded" },
      sources = {
        files = { hidden = true, follow = true },
        grep = { hidden = true, follow = true },
      },
    },
  },
  config = function(_, opts)
    local Snacks = require("snacks")
    Snacks.setup(opts)

    -- Route notifications to Snacks (replaces nvim-notify)
    vim.notify = Snacks.notify

    -- Replace common Telescope mappings with Snacks picker
    local map = vim.keymap.set
    local desc = function(d) return { desc = d } end

    map("n", "<leader><space>", function() Snacks.picker.files() end, desc("Find Files"))
    map("n", "<leader>ff", function() Snacks.picker.files() end, desc("Find Files"))
    map("n", "<leader>fF", function() Snacks.picker.files({ cwd = false }) end, desc("Find Files (cwd)"))
    map("n", "<leader>fr", function() Snacks.picker.recent() end, desc("Recent"))
    map("n", "<leader>fR", function() Snacks.picker.recent({ cwd = (vim.uv or vim.loop).cwd() }) end,
      desc("Recent (cwd)"))
    map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
      desc("Find Config File"))

    map("n", "<leader>,", function() Snacks.picker.buffers() end, desc("Switch Buffer"))
    map("n", "<leader>fb", function() Snacks.picker.buffers() end, desc("Buffers"))

    map("n", "<leader>sg", function() Snacks.picker.grep() end, desc("Grep (root dir)"))
    map("n", "<leader>sG", function() Snacks.picker.grep({ cwd = false }) end, desc("Grep (cwd)"))
    map("n", "<leader>sH", function() Snacks.picker.help() end, desc("Help Pages"))
    map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, desc("Colorscheme with preview"))
    map("n", "<leader>sd", function() Snacks.picker.diagnostics({ bufnr = 0 }) end, desc("Document diagnostics"))
    map("n", "<leader>sD", function() Snacks.picker.diagnostics({ workspace = true }) end, desc("Workspace diagnostics"))

    -- Extra pickers
    map("n", "<leader>s:", function() Snacks.picker.commands() end, desc("Commands"))
    map("n", "<leader>sk", function() Snacks.picker.keymaps() end, desc("Keymaps"))
    map("n", "<leader>sr", function() Snacks.picker.registers() end, desc("Registers"))
    map("n", "<leader>sm", function() Snacks.picker.marks() end, desc("Marks"))
  end,
}
