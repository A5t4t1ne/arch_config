vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- movement --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set({ 'n', 'v' }, "j", "<Left>", {noremap = true}) -- { 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }
vim.keymap.set({ 'n', 'v' }, "k", "<Down>", {noremap = true})
vim.keymap.set({ 'n', 'v' }, "l", "<Up>", {noremap = true})
vim.keymap.set({ 'n', 'v' }, "ö", "<Right>", {noremap = true})

vim.keymap.set({ 'n' }, "<C-w>j", "<C-w>h", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>k", "<C-w>j", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>l", "<C-w>k", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>ö", "<C-w>l", {noremap = true})

-- editing --
vim.keymap.set("v", "<leader>p", "\"_dP")


-- undotree --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
