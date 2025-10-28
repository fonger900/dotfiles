local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "vtsls", "tailwindcss", "html", "cssls", "vue_ls" },
	automatic_installation = true,
})

local servers = { "pyright", "vtsls", "tailwindcss", "html", "cssls", "vue_ls" }

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	vim.lsp.enable(lsp)
end

vim.lsp.config('denols', {
	on_attach = on_attach,
	root_markers = { "deno.json", "deno.jsonc" },
})

vim.lsp.config('vtsls', {
	on_attach = on_attach,
	root_markers = { "package.json", "tsconfig.json" },
})
