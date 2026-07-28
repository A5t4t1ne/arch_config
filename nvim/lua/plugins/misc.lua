return {
	-- fonts and icons --
	{ "nvim-tree/nvim-web-devicons", name = "devicons" },

	-- ZenMode --
	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>" },
		},
	},

	-- UndoTree --
	{ "mbbill/undotree" },

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}
