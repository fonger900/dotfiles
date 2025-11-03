local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  -- Enable snippet support
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Keybindings for completion
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll up in the documentation window
    ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll down in the documentation window
    ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
    ["<C-e>"] = cmp.mapping.abort(), -- Close the completion window
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  }),
  -- Completion sources
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP symbols
    { name = "luasnip" }, -- Snippets
    { name = "buffer" }, -- Words from the current buffer
    { name = "path" }, -- Filesystem paths
  }),
})
