vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- movement --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }, "j", "<Left>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }, "k", "<Down>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }, "l", "<Up>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }, "ö", "<Right>", {noremap = true})

-- editing --
vim.keymap.set("v", "<leader>p", "\"_dP")


-- undotree --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
