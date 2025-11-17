-- =============================================
-- Snacks Plugins
-- =============================================

---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = true,  -- Replace netrw with Snacks explorer
    },
    gh = { enabled = true }, -- GitHub CLI integration
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      ui = { border = "rounded" },
      sources = {
        files = { hidden = true, follow = true },
        grep = { hidden = true, follow = true },
      },
    },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Core pickers
    { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
    { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
    { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },

    -- Find files
    { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
    { "<leader>fF",      function() Snacks.picker.files({ cwd = false }) end,                    desc = "Find Files (cwd)" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
    { "<leader>fR",      function() Snacks.picker.recent({ cwd = vim.uv.cwd() }) end,            desc = "Recent (cwd)" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },

    -- Search/grep
    { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep (root dir)" },
    { "<leader>sG",      function() Snacks.picker.grep({ cwd = false }) end,                     desc = "Grep (cwd)" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
    { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
    { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },

    -- Diagnostics & LSP
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Workspace diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Document diagnostics" },
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },

    -- Help & info
    { "<leader>sH",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
    { "<leader>sc",      function() Snacks.picker.commands() end,                                desc = "Commands" },
    { "<leader>sr",      function() Snacks.picker.registers() end,                               desc = "Registers" },
    { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
    { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
    { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
    { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorscheme with preview" },

    -- Git
    { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },

    -- GitHub (requires GitHub CLI)
    { "<leader>ghi",     function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
    { "<leader>ghI",     function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
    { "<leader>ghp",     function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
    { "<leader>ghP",     function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },

    -- LSP navigation (replaces telescope/native LSP bindings)
    { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
    { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
    { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
    { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
    { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },

    -- Other features
    { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
    { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
    { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
    { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
    { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
    { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
    { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
    { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
    { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
    { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
    { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",             mode = { "n", "t" } },
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",             mode = { "n", "t" } },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)
    _G.Snacks = snacks

    _G.dd = function(...)
      snacks.debug.inspect(...)
    end
    _G.bt = function()
      snacks.debug.backtrace()
    end

    vim._print = function(_, ...)
      _G.dd(...)
    end

    snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    snacks.toggle.diagnostics():map("<leader>ud")
    snacks.toggle.line_number():map("<leader>ul")
    snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
      "<leader>uc")
    snacks.toggle.treesitter():map("<leader>uT")
    snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    snacks.toggle.inlay_hints():map("<leader>uh")
    snacks.toggle.indent():map("<leader>ug")
    snacks.toggle.dim():map("<leader>uD")
  end,
}
