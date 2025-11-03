-- =============================================
-- Utility Plugins
-- =============================================

return {
  -- Measure startuptime
  {
    "dstein64/vim-startuptime",
    enabled = false, -- replaced by Snacks Profiler
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Makes some plugins dot-repeatable
  { "tpope/vim-repeat",      event = "VeryLazy" },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>",                            desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",            desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>",       desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical Terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },

  -- (project.nvim removed; Snacks + Harpoon cover quick project navigation)

  -- Improved yank and put
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") }
    },
    opts = {
      ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
    },
    keys = {
      {
        "<leader>p",
        function()
          local ok, telescope = pcall(require, "telescope")
          if ok and telescope and telescope.extensions and telescope.extensions.yank_history then
            telescope.extensions.yank_history.yank_history({})
          else
            -- Fallback: use Yanky command if available or notify
            if vim.fn.exists(":YankyRingHistory") == 2 then
              vim.cmd([[YankyRingHistory]])
            else
              vim.notify("Yank history UI unavailable (Telescope disabled)", vim.log.levels.WARN)
            end
          end
        end,
        desc = "Open Yank History",
      },
      { "y",  "<Plug>(YankyYank)",                      mode = { "n", "x" },                           desc = "Yank text" },
      { "p",  "<Plug>(YankyPutAfter)",                  mode = { "n", "x" },                           desc = "Put yanked text after cursor" },
      { "P",  "<Plug>(YankyPutBefore)",                 mode = { "n", "x" },                           desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)",                 mode = { "n", "x" },                           desc = "Put yanked text after selection" },
      { "gP", "<Plug>(YankyGPutBefore)",                mode = { "n", "x" },                           desc = "Put yanked text before selection" },
      { "[y", "<Plug>(YankyCycleForward)",              desc = "Cycle forward through yank history" },
      { "]y", "<Plug>(YankyCycleBackward)",             desc = "Cycle backward through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)",  desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)",   desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)",  desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)",            desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)",           desc = "Put before applying a filter" },
    },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>H", function() require("harpoon"):list():append() end,                                 desc = "Harpoon file" },
      { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon quick menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end,                                desc = "Harpoon to file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end,                                desc = "Harpoon to file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end,                                desc = "Harpoon to file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end,                                desc = "Harpoon to file 4" },
    },
  },

  -- Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- Enhanced matchparen
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    keys = {
      "<C-n>",
      "<C-Down>",
      "<C-Up>",
      "<S-C-Down>",
      "<S-C-Up>",
    },
  },
}
