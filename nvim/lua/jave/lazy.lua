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
	{
		"folke/tokyonight.nvim",
		name = "Tokyo Night",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	-- telescope --
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
			{ "<leader>ps", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
			{ "<C-p>",      "<cmd>Telescope git_files<cr>",   desc = "Find git files" },
			{ '<leader>tt', '<cmd>Telescope<CR>',             desc = "Open telescope" },
			{ '<leader>td', '<cmd>Telescope diagnostics<CR>', desc = "Run telescope diagnostics" },
		}
	},

	-- treesitter --
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
			},
		},
	},

	-- fonts and icons --
	{ 'nvim-tree/nvim-web-devicons', name = "devicons" },

	-- harpoon --
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = {
			{ "<leader>a", function() require("harpoon"):list():add() end,     desc = "harpoon file", },
			{
				"<leader>A",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			-- { "<C-S-p>",   function() require("harpoon"):list():prev() end,    desc = "harpoon previous file", },
			-- { "<C-n>",     function() require("harpoon"):list():next() end,    desc = "harpoon next file", },
			{ "<C-j>",     function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
			{ "<C-k>",     function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
			{ "<C-l>",     function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
			{ "<C-ö>",     function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
		},
	},

	-- ZenMode --
	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", },
		},
	},

	-- VimBeGood --
	{ "ThePrimeagen/vim-be-good", },

	-- UndoTree --
	{ "mbbill/undotree", },

	-- vim-fugitive --
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", vim.cmd.Git },
		},
	},

	-- lsp --
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
	{
		'VonHeikemen/lsp-zero.nvim',
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
		}
	},
	{ 'neovim/nvim-lspconfig', },
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		},
	},
	{ 'mfussenegger/nvim-jdtls' },
	{ 'neovim/nvim-lspconfig', },
	{ "williamboman/mason.nvim", },
	{ "williamboman/mason-lspconfig.nvim", },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && ./install.sh",
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
		},
	},
	{
		"preservim/vim-markdown",
		ft = "markdown",
		dependencies = {
			'godlygeek/tabular',
			'elzr/vim-json',
			'plasticboy/vim-markdown',
		},
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_conceal = 1
			-- vim.g.tex_conceal = ""
			-- vim.g.vim_markdown_math = 1

			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_toml_frontmatter = 1
			vim.g.vim_markdown_json_frontmatter = 1
		end,
	},
	{
		'vim-pandoc/vim-pandoc-syntax',
		ft = { "markdown", "pandoc" },
		config = function()
			vim.g.vim_markdown_conceal = 0
		end,
		init = function()
			vim.api.nvim_create_augroup("pandoc_syntax", { clear = true })
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
				pattern = "*.md",
				group = "pandoc_syntax",
				callback = function()
					vim.bo.filetype = "markdown.pandoc"
				end,
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
	{
		"AckslD/swenv.nvim",
	},
	{
		"ahmedkhalf/project.nvim",
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			vim.keymap.set('n', '<leader>dc', function() dap.continue() end,
				{ noremap = true, silent = true, desc = 'DAP continue' })
			vim.keymap.set('n', '<leader>do', function() dap.step_over() end,
				{ noremap = true, silent = true, desc = 'DAP step over' })
			vim.keymap.set('n', '<leader>di', function() dap.step_into() end,
				{ noremap = true, silent = true, desc = 'DAP step into' })
			vim.keymap.set('n', '<leader>du', function() dap.step_out() end,
				{ noremap = true, silent = true, desc = 'DAP step out' })
			vim.keymap.set('n', '<leader>dt', function() dap.toggle_breakpoint() end,
				{ noremap = true, silent = true, desc = 'DAP toggle breakpoint' })
			vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
				{ noremap = true, silent = true, desc = 'DAP set conditional breakpoint' })
			vim.keymap.set('n', '<leader>lp',
				function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				{ noremap = true, silent = true, desc = 'DAP set log point' })
			vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end,
				{ noremap = true, silent = true, desc = 'DAP open REPL' })
			vim.keymap.set('n', '<leader>dl', function() dap.run_last() end,
				{ noremap = true, silent = true, desc = 'DAP run last' })
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "honza/vim-snippets", }, -- seems like an engine for snippets
	{
		'L3MON4D3/LuaSnip',
		dependencies = { 'rafamadriz/friendly-snippets' },
	},
	{
		'Kicamon/markdown-table-mode.nvim',
		config = function()
			require('markdown-table-mode').setup()
		end
	},

	{
		'linux-cultist/venv-selector.nvim',
		branch = "regexp",
		dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
		opts = {
			-- Your options go here
			-- name = "venv",
			-- auto_refresh = false
		},
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ '<leader>vs', '<cmd>VenvSelect<cr>' },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ '<leader>vc', '<cmd>VenvSelectCached<cr>' },
		},
	},


	-- typst --
	{
		'chomosuke/typst-preview.nvim',
		ft = 'typst',
		version = '1.*',
		config = function()
			require 'typst-preview'.setup {}
		end,
	},
	{
		"chomosuke/typst-preview.nvim",
		keys = {
			{ '<leader>tp', '<cmd>TypstPreview<CR>' },
			{ '<leader>ts', '<cmd>TypstPreviewStop<CR>' },
		},
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "html", "css", "json", "markdown" },
					}),
					null_ls.builtins.formatting.nginx_beautifier,
				},
			})
		end,
		dependencies = { "williamboman/mason.nvim" },
	},

	-- csharp --
	{
		"iabdelkareem/csharp.nvim",
		dependencies = {
			"williamboman/mason.nvim", -- Required, automatically installs omnisharp
			"mfussenegger/nvim-dap",
			"Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
		},
		config = function()
			require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
			require("csharp").setup()
		end
	}
})
