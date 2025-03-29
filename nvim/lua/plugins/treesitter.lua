return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"html",
					"javascript",
					"java",
					"json",
					"lua",
					"python",
					"rust",
					"yaml",
					"latex",
					"csharp",
					"C#",
					"cs",
					"typst",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				ignore_install = {},
				modules = {},
			})
		end,
	},

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
		pattern = { "*.typ" },
		callback = function()
			vim.cmd("TSEnable highlight")
		end
	})
}
