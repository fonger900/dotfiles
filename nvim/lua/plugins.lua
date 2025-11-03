return {
	-- =====================
	-- Theme & UI
	-- =====================
	{
		-- Catppuccin theme
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
	{ 
		-- Icons for various plugins
		"nvim-tree/nvim-web-devicons" 
	},
	{
		-- Statusline
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},

	{
		-- File explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
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
		-- Treesitter for syntax highlighting and more
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
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
					"bash",
					"yaml",
					"markdown",
					"dockerfile",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- =====================
	-- LSP
	-- =====================
	{ 
		-- LSP installer
		"williamboman/mason.nvim", config = true 
	},
	{ 
		-- Bridge between mason and lspconfig
		"williamboman/mason-lspconfig.nvim" 
	},
	{ 
		-- LSP configuration framework
		"neovim/nvim-lspconfig" 
	},
	{
		-- UI for LSP
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
	{ "hrsh7th/nvim-cmp" }, -- Autocompletion engine
	{ "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
	{ "hrsh7th/cmp-buffer" }, -- Buffer source for nvim-cmp
	{ "hrsh7th/cmp-path" }, -- Path source for nvim-cmp
	{ "L3MON4D3/LuaSnip" }, -- Snippet engine
	{ "saadparwaiz1/cmp_luasnip" }, -- Snippet source for nvim-cmp

	-- =====================
	-- Git
	-- =====================
	{ 
		-- Git signs in the gutter
		"lewis6991/gitsigns.nvim", config = true 
	},
	{ 
		-- Git wrapper
		"tpope/vim-fugitive" 
	},

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
		-- Formatter plugin
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				vue = { "prettier" },
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true })
			end, { noremap = true, silent = true })
		end,
	},

	-- =====================
	-- Linting
	-- =====================
	{
		-- Linter plugin
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				python = { "ruff" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				vue = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- =====================
	-- UI
	-- =====================
	{ 
		-- Better UI for vim.ui.select and vim.ui.input
		"stevearc/dressing.nvim", opts = {} 
	},

	-- =====================
	-- Navigation
	-- =====================
	{
		-- Enhanced f/F/t/T motions
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	-- =====================
	-- Quality of Life
	-- =====================
	{
		-- Keybinding hints
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		-- Easy commenting
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		-- Autopairs for brackets, quotes, etc.
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		-- Tabline
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup()
		end,
	},
}
