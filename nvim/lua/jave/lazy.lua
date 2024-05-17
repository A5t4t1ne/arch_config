local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	plugins = {
		formatter = {
			exe = "prettier",
			args = {},
			stdin = true,
		}
	},

	-- theme --
	{ "folke/tokyonight.nvim",
		name = "Tokyo Night",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	-- telescope --
	{'nvim-telescope/telescope.nvim', tag = '0.1.6',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
	}},

	-- treesitter --
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- fonts and icons --
	{'nvim-tree/nvim-web-devicons', name = "devicons" },

	-- harpoon --
 	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = {
			{ "<leader>a", function() require("harpoon"):list():add() end, desc = "harpoon file", },
			{ "<leader>A", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
			{ "<C-S-p>", function() require("harpoon"):list():prev() end, desc = "harpoon previous file", },
			{ "<C-n>", function() require("harpoon"):list():next() end, desc = "harpoon next file", },
			{ "<C-j>", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
			{ "<C-k>", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
			{ "<C-l>", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
			{ "<C-ö>", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
		},
	},

	-- ZenMode --
	{ 
		"folke/zen-mode.nvim", 
		opts = {},
	},

	-- VimBeGood --
	{ "ThePrimeagen/vim-be-good", },

	-- UndoTree --
	{ "mbbill/undotree", },

	-- Vim-Tmux-Navigator
-- 	{
-- 		"christoomey/vim-tmux-navigator",
-- 		cmd = {
-- 			"TmuxNavigateLeft",
-- 			"TmuxNavigateDown",
-- 			"TmuxNavigateUp",
-- 			"TmuxNavigateRight",
-- 			"TmuxNavigatePrevious",
-- 		},
-- 		keys = {
-- 			{ "<c-j>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
-- 			{ "<c-k>", "<cmd><C-U>TmuxNavigateDown<cr>" },
-- 			{ "<c-l>", "<cmd><C-U>TmuxNavigateUp<cr>" },
-- 			{ "<c-ö>", "<cmd><C-U>TmuxNavigateRight<cr>" },
-- 			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
-- 		},
-- 	},

	-- vim-fugitive --
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", vim.cmd.Git },
		},
	},

	-- lsp --
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/nvim-cmp'},
	{ 'mfussenegger/nvim-jdtls' },
	{ "neovim/nvim-lspconfig", },
	{ "VonHeikemen/lsp-zero.nvim", },
	-- { "hrsh7th/nvim-cmp", }, -- Autocompletion plugin
	-- { "hrsh7th/cmp-nvim-lsp", }, -- LSP source for nvim-cmp
	-- {
	-- 	"zbirenbaum/copilot-cmp", -- Copilot source for nvim-cmp
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
	{
		"zbirenbaum/copilot.lua", -- Copilot plugin
		config = function()
			require("copilot").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	{ "williamboman/mason.nvim", },
	{ "williamboman/mason-lspconfig.nvim", },
})
