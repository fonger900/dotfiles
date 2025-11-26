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
    config = true,
    ft = "dart",
  },
}
