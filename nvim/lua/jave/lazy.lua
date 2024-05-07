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
	-- theme --
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"folke/which-key.nvim",
	
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
	-- {'nvim-tree/nvim-web-devicons', name = "devicons" },

	-- harpoon --
 	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = {
			{ "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file", },
			{ "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
			{ "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "harpoon previous file", },
			{ "<C-S-N>", function() require("harpoon"):list():next() end, desc = "harpoon next file", },
			{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
			{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
			{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
			{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
			{ "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
		},
	},

	-- ZenMode --
	{ 
		"folke/zen-mode.nvim", 
		opts = {},
	},
})
