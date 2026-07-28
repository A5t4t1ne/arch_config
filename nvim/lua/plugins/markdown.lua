return {
	{
		"preservim/vim-markdown",
		ft = { "markdown", "markdown.pandoc" },
		dependencies = {
			"godlygeek/tabular",
			"elzr/vim-json",
		},
		init = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_toml_frontmatter = 1
			vim.g.vim_markdown_json_frontmatter = 1
		end,
	},
	{
		"vim-pandoc/vim-pandoc-syntax",
		ft = { "markdown", "pandoc" },
		init = function()
			vim.g.vim_markdown_conceal = 2

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
				pattern = "*.md",
				callback = function()
					vim.bo.filetype = "markdown.pandoc"
				end,
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown", "markdown.pandoc" },
		build = "cd app && ./install.sh",
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
		},
	},
	{
		"Kicamon/markdown-table-mode.nvim",
		ft = { "markdown", "markdown.pandoc" },
		opts = {},
	},
}
