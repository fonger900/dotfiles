-- ============================================================================
-- lazy.nvim Bootstrap and Setup
-- ============================================================================

local uv = vim.uv or vim.loop
local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local git_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    }

    if vim.system then
        local result = vim.system(git_cmd, { text = true }):wait()
        if result.code ~= 0 then
            error("lazy.nvim clone failed: " .. (result.stderr or result.stdout or "unknown error"))
        end
    else
        local output = fn.system(git_cmd)
        if vim.v.shell_error ~= 0 then
            error("lazy.nvim clone failed: " .. output)
        end
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins.core" },
        { import = "plugins.editor" },
        { import = "plugins.coding" },
        { import = "plugins.lsp" },
        { import = "plugins.git" },
        { import = "plugins.snacks" },
        { import = "plugins.markdown" },
        { import = "plugins.flutter" },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = false, notify = false },
    change_detection = { notify = false },
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "rplugin",
                "spellfile_plugin",
                "shada_plugin",
                "man",
                "osc52",
            },
        },
    },
    ui = { border = "rounded" },
})
