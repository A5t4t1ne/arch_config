return {
	{
		"folke/tokyonight.nvim",
		name = "Tokyo Night",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight-night")

			-- transparent background for the main window and floats
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
}
