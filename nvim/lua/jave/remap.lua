vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- project navigation --
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- vim.keymap.set("n", "<leader>ps", function()
-- 	require("telescope.builtin").live_grep()
-- end, { desc = "telescope Live Grep" })
-- vim.keymap.set("n", '<leader>ff', function()
-- 	require('telescope.builtin').find_files()
-- end, { desc = "telescope find files" })

vim.keymap.set("n", "<leader>pe", function()
	require('swenv.api').pick_venv()
end, { desc = "switch python venv" })

-- movement --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "j", "<Left>", {noremap = true}) 
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "<Down>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "l", "<Up>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "ö", "<Right>", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "K", "<Down>zz", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "L", "<Up>zz", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "é", "L", {noremap = true})
vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "h", "", {noremap = true})

vim.keymap.set({ 'n' }, "<C-w>j", "<C-w>h", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>k", "<C-w>j", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>l", "<C-w>k", {noremap = true})
vim.keymap.set({ 'n' }, "<C-w>ö", "<C-w>l", {noremap = true})

-- editing --
vim.keymap.set("v", "<leader>p", "\"_dP") -- paste without overwriting clipboard
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<C-c><cmd>w<cr>") -- save
vim.keymap.set({ "n" }, "<A-k>", "o<Esc>", {noremap = true})
vim.keymap.set({ "n" }, "<A-l>", "O<Esc>", {noremap = true})

-- plugins-specific --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- LSP --
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'h', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })

-- Running file --
vim.keymap.set('n', '<leader>r', function()
  local filetype = vim.bo.filetype
  local cmd = ''

  if filetype == 'python' then
    cmd = 'python3'
  elseif filetype == 'javascript' then
    cmd = 'node'
  elseif filetype == 'sh' then
    cmd = 'bash'
  elseif filetype == 'ruby' then
    cmd = 'ruby'
  else
    print('No run command configured for filetype: ' .. filetype)
    return
  end

  vim.cmd('! ' .. cmd .. ' %')
end, { noremap = true, silent = true, desc = 'Run current file' })
