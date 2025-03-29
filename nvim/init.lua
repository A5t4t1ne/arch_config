require("jave.remap")
require("jave.lazy")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.vim-fugitive")
require("plugins.lspconfig")
require('plugins.ltex_ls')

vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.conceallevel = 2
vim.bo.expandtab = true

vim.opt.signcolumn = "number"
vim.wo.signcolumn = "yes"

-- Set the background color for floating windows
vim.cmd [[colorscheme tokyonight-night]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Disable virtual text for warnings and lower severities
vim.diagnostic.config({
	virtual_text = false
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
  end
})
