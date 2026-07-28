return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
			{ "<leader>tt", "<cmd>Telescope<CR>", desc = "Open telescope" },
			{ "<leader>td", "<cmd>Telescope diagnostics<CR>", desc = "Run telescope diagnostics" },
		},
		opts = {
			defaults = {
				preview = {
					timeout = 501,
				},
			},
			pickers = {
				live_grep = {
					additional_args = function(_)
						return { "--hidden", "--glob", "!{.git,node_modules,vendor,docs,*.egg-info,.venv}/**" }
					end,
				},
			},
		},
	},
}
