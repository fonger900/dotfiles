-- ============================================================================
-- Neovim Autocommands
-- ============================================================================

local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local uv = vim.uv or vim.loop
local highlight = vim.highlight
local keymap = vim.keymap
local opt_local = vim.opt_local

local function augroup(name)
    return api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Reload files automatically when they change on disk
api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    desc = "Reload buffers when they change on disk",
    callback = function()
        if api.nvim_get_option_value("buftype", { buf = 0 }) == "nofile" then
            return
        end
        cmd.checktime()
    end,
})

-- Highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    desc = "Briefly highlight yanked text",
    callback = function()
        highlight.on_yank({
            higroup = "IncSearch",
            timeout = 200,
        })
    end,
})

-- Resize splits to equal dimensions on UI resize
api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    desc = "Keep splits balanced",
    callback = function()
        local current_tab = fn.tabpagenr()
        cmd("tabdo wincmd =")
        cmd("tabnext " .. current_tab)
    end,
})

-- Restore last known cursor position on buffer open
api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    desc = "Restore last cursor position",
    callback = function(event)
        local excluded = { "gitcommit" }
        if vim.tbl_contains(excluded, vim.bo[event.buf].filetype) or vim.b[event.buf].last_loc then
            return
        end

        local mark = api.nvim_buf_get_mark(event.buf, '"')
        if mark[1] <= 0 then
            return
        end

        local line_count = api.nvim_buf_line_count(event.buf)
        if mark[1] > line_count then
            return
        end

        vim.b[event.buf].last_loc = true
        pcall(api.nvim_win_set_cursor, 0, mark)
    end,
})

-- Close certain buffer types with q
api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = { "checkhealth", "help", "lspinfo", "man", "notify", "qf" },
    desc = "Close auxiliary buffers with q",
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        keymap.set("n", "q", "<cmd>close<cr>",
            { buffer = event.buf, silent = true, nowait = true, desc = "Close window" })
    end,
})

-- Enable wrapping and spell check for prose
api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    desc = "Enable wrapping and spell-check for text",
    callback = function()
        opt_local.wrap = true
        opt_local.spell = true
    end,
})

-- Disable concealment in JSON buffers
api.nvim_create_autocmd("FileType", {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    desc = "Disable concealment in JSON buffers",
    callback = function()
        opt_local.conceallevel = 0
    end,
})

-- Create parent directories automatically before saving
api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    desc = "Create parent directories before saving",
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end

        local file = (uv and uv.fs_realpath(event.match)) or event.match
        local dir = vim.fs.dirname(file)
        if dir and dir ~= "" then
            fn.mkdir(dir, "p")
        end
    end,
})

-- Disable automatic comment insertion on new lines
api.nvim_create_autocmd("BufEnter", {
    group = augroup("format_options"),
    pattern = "*",
    desc = "Disable automatic comment insertion",
    callback = function()
        opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Detect Django templates and set filetype accordingly
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("django_ft"),
    pattern = { "*/templates/*.html", "*/templates/**/*.html" },
    desc = "Set filetype to htmldjango for Django templates",
    callback = function(event)
        -- Only override if not already detected
        if vim.bo[event.buf].filetype == "html" or vim.bo[event.buf].filetype == "" then
            vim.bo[event.buf].filetype = "htmldjango"
        end
    end,
})

-- Detect Blade templates and set filetype accordingly
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("blade_ft"),
    pattern = { "*.blade.php" },
    desc = "Set filetype to blade for Laravel templates",
    callback = function()
        vim.bo.filetype = "blade"
    end,
})
