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

vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})

vim.opt.signcolumn = "auto"

-- Set the background color for floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e1e" })

-- Set the background color for error messages
vim.api.nvim_set_hl(0, "ErrorMsg", { bg = "#1e1e1e" })

-- Set the background color for LSP recommendations
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#1e1e1e" })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#1e1e1e" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#1e1e1e" })


vim.api.nvim_set_hl(0, "NormalFloat", { bg = "LightBlue" })
vim.api.nvim_set_hl(0, "ErrorMsg", { bg = "LightBlue" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "LightBlue" })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "LightBlue" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "LightBlue" })

