-- Get completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Keybindings for LSP
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Set up mason
require("mason").setup()

-- List of LSP servers to install
local servers = {
    "pyright",
    "tailwindcss",
    "html",
    "cssls",
    "vue_ls",
    "denols",
    "ts_ls",
}

-- Get the lspconfig module
local lspconfig = require("lspconfig")

-- Set up mason-lspconfig
require("mason-lspconfig").setup({
    ensure_installed = servers,
    handlers = {
        -- Default handler for servers
        function (server_name)
            local opts = {
                on_attach = on_attach,
                capabilities = capabilities,
            }
            -- Special setup for denols
            if server_name == "denols" then
                opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
            end
            -- Special setup for tsserver
            if server_name == "ts_ls" then
                opts.root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json")
            end
            -- Set up the server
            lspconfig[server_name].setup(opts)
        end,
    }
})