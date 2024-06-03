vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- project navigation --
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ps", function()
	require("telescope.builtin").live_grep()
end, { desc = "telscope Live Grep" })

vim.keymap.set("n", "<leader>pe", function()
	require('swenv.api').pick_venv()
end, { desc = "switch python venv" })

-- movement --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "j", "<Left>", {noremap = true}) -- { 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "<Down>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "l", "<Up>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "ö", "<Right>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "J", "H", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "é", "L", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "h", "", {noremap = true})

vim.keymap.set({ 'n' }, "<C-w>j", "<C-w>h", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>k", "<C-w>j", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>l", "<C-w>k", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>ö", "<C-w>l", {noremap = true})

-- editing --
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<C-c><cmd>w<cr>")


-- plugins-specific --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
