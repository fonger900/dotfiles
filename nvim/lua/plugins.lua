return {
	-- =====================
	-- Theme & UI
	-- =====================
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim", -- 👈 cần cho v3.x
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = true,
					},
				},
			})
		end,
	},
	-- =====================
	-- Syntax Highlight
	-- =====================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"python",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"html",
					"css",
					"sql",
					"vue",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- =====================
	-- LSP
	-- =====================
	{ "williamboman/mason.nvim", config = true },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lspsaga").setup({})
		end,
	},

	-- =====================
	-- Autocomplete
	-- =====================
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- =====================
	-- Git
	-- =====================
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "tpope/vim-fugitive" },

	-- =====================
	-- Fuzzy Finder
	-- =====================
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup()
		end,
	},

	-- =====================
	-- Format
	-- =====================
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true })
			end, { noremap = true, silent = true })
		end,
	},
}
