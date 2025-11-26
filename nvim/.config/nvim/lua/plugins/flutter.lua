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
      require("flutter-tools").setup({
        flutter_path = "/Users/fonger/flutter/bin",
        lsp = {
          dart_sdk_path = "/Users/fonger/flutter/bin/cache/dart-sdk",
          cmd = { "/Users/fonger/flutter/bin/dart", "language-server", "--protocol=lsp" },
        },
      })
    end,
    ft = "dart",
  },
}
