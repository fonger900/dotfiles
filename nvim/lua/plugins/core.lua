-- Core UI and utility plugins
return {
  -- Required dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "tpope/vim-repeat",      event = "VeryLazy" },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        mason = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override = {
        zsh = { icon = "", color = "#428850", name = "Zsh" },
        [".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" },
      },
    },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "mason" },
    },
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",   desc = "Toggle pin" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      },
    },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>",                 desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
    },
    opts = {
      direction = "float",
      float_opts = { border = "curved" },
    },
  },

  -- Enhanced yank
  {
    "gbprod/yanky.nvim",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
    opts = {
      ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
    },
    keys = {
      { "<leader>p", function() vim.cmd("YankyRingHistory") end, desc = "Yank History" },
      { "y",         "<Plug>(YankyYank)",                        mode = { "n", "x" } },
      { "p",         "<Plug>(YankyPutAfter)",                    mode = { "n", "x" } },
      { "P",         "<Plug>(YankyPutBefore)",                   mode = { "n", "x" } },
    },
  },

  -- Quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>H", function() require("harpoon"):list():append() end,                                 desc = "Harpoon file" },
      { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end,                                desc = "Harpoon 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end,                                desc = "Harpoon 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end,                                desc = "Harpoon 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end,                                desc = "Harpoon 4" },
    },
  },

  -- Enhanced UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    keys = { "<C-n>", "<C-Down>", "<C-Up>" },
  },
}
