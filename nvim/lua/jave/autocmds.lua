vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown", "typst" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb"
		vim.opt.textwidth = 88
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "nginx.conf", "*.nginx", "*.nginxconf" },
	command = "setfiletype nginx",
})

vim.diagnostic.config({
	virtual_text = false,
	signs = false,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
