-- =========================================================================
-- Django-specific plugins and tweaks
-- =========================================================================

return {
  -- Syntax and filetype detection for Django projects
  {
    "tpope/vim-django",
    event = { "BufReadPost", "BufNewFile" },
  },
}
