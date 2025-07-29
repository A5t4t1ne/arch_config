require("jave.remap")
require("jave.lazy")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.vim-fugitive")
require("plugins.lspconfig")

vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.conceallevel = 2
vim.opt.wrap = true
vim.opt.textwidth = 120
vim.bo.expandtab = true

vim.opt.signcolumn = "number"

-- Set the background color for floating windows
vim.cmd [[colorscheme tokyonight-night]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown", "typst" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb"
		vim.bo.formatoptions = vim.bo.formatoptions and (vim.bo.formatoptions .. "t") or "t"
	end,
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "nginx.conf", "*.nginx", "*.nginxconf" },
  command = "setfiletype nginx",
})


-- En-/Disable virtual text for warnings and lower severities
vim.diagnostic.config({
	virtual_text = true,
	signs = false,
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
