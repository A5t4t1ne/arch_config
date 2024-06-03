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
-- vim.opt.conceallevel = 0

-- vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
-- vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
-- vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
-- vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})

vim.opt.signcolumn = "number"

-- Set the background color for floating windows
vim.cmd[[colorscheme tokyonight-night]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Disable virtual text for warnings and lower severities
vim.diagnostic.config({
    virtual_text = false
})

