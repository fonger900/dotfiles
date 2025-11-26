-- =============================================
-- Flutter Development Plugins
-- =============================================

return {
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for nice UI
    },
    config = function()
      local flutter_path = vim.fn.expand("$HOME/flutter/bin")
      require("flutter-tools").setup({
        flutter_path = flutter_path,
        lsp = {
          dart_sdk_path = vim.fs.joinpath(flutter_path, "cache", "dart-sdk"),
          cmd = { vim.fs.joinpath(flutter_path, "dart"), "language-server", "--protocol=lsp" },
        },
      })
    end,
    ft = "dart",
  },
}
