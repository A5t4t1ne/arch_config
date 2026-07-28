return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
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
				"ruby",
				"yaml",
				"latex",
				"c_sharp",
				"typst",
				"toml",
				"go",
			})

			-- start highlighting/indent for any buffer with an installed parser
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					local started = pcall(vim.treesitter.start)
					if started then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
