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
		tag = '0.1.6',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		keys = {
			-- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
		}
	},

	-- treesitter --
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"markdown",
				"markdown_inline",
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
			{ "<C-S-p>",   function() require("harpoon"):list():prev() end,    desc = "harpoon previous file", },
			{ "<C-n>",     function() require("harpoon"):list():next() end,    desc = "harpoon next file", },
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
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'mfussenegger/nvim-jdtls' },
	{ 'neovim/nvim-lspconfig', },
	{
		'VonHeikemen/lsp-zero.nvim',
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
		}
	},
	{ "williamboman/mason.nvim", },
	{ "williamboman/mason-lspconfig.nvim", },
	{ "hrsh7th/cmp-nvim-lsp", },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", },
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
	{
		"lervag/vimtex",
		lazy = false,
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = 'zathura'
			vim.g.vimtex_compiler_method = 'latexmk'
			vim.g.vimtex_compiler_latexmk = {
				build_dir = 'build',
				callback = 1,
				continuous = 1,
				executable = 'latexmk',
				options = {
					'-pdf',
					'-outdir=build',
					'-shell-escape',
					'-verbose',
					'-file-line-error',
					'-synctex=1',
					'-interaction=nonstopmode',
				},
			}
			vim.g.vimtex_view_general_options = '--synctex-forward @line:@col:@tex build/@pdf' -- for zathura to find the pdf in the build folder
		end
	},
	{
		'SirVer/ultisnips',
		config = function()
			vim.g.UltiSnipsExpandTrigger = '<tab>'
			vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
			vim.g.UltiSnipsJumpBackwardTrigger = '<S-tab>'
		end

	},
	{ "quangnguyen30192/cmp-nvim-ultisnips", },
	{ "honza/vim-snippets", },
	{
		"jhofscheier/ltex-utils.nvim", -- for add to dictionary, ignore false positives etc.
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
		},
	},
})
