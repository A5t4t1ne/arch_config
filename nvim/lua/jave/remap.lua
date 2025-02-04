local colemak = true -- not fully supported, some keys are not rebound yet

vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- project navigation --
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>pe", function()
	require('swenv.api').pick_venv()
end, { desc = "switch python venv" })

-- movement --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

if colemak then
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "n", "<Left>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "e", "<Down>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "i", "<Up>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "o", "<Right>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "E", "<Down>zz", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "I", "<Up>zz", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "O", "L", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "h", "", { noremap = true })


	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "e", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "l", "i", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "L", "I", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "e", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "m", "o", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "M", "O", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "j", "n", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "J", "N", { noremap = true })

	-- override explorer keybinds --
	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'netrw',
		callback = function()
			local opts = { buffer = true, noremap = true }
			vim.keymap.set('n', 'n', '<Left>', opts)
			vim.keymap.set('n', 'e', '<Down>', opts)
			vim.keymap.set('n', 'i', '<Up>', opts)
			vim.keymap.set('n', 'o', '<Right>', opts)
		end
	})


	vim.keymap.set('n', '<C-w>n', '<C-w>h', { noremap = true }) -- Left
	vim.keymap.set('n', '<C-w>e', '<C-w>j', { noremap = true }) -- Down
	vim.keymap.set('n', '<C-w>i', '<C-w>k', { noremap = true }) -- Up
	vim.keymap.set('n', '<C-w>o', '<C-w>l', { noremap = true }) -- Right


	vim.keymap.set('n', "<C-n>", function() require("harpoon"):list():select(1) end,
		{ noremap = true, silent = true, desc = "harpoon select 1" })
	vim.keymap.set('n', "<C-e>", function() require("harpoon"):list():select(2) end,
		{ noremap = true, silent = true, desc = "harpoon select 2" })
	vim.keymap.set('n', "<C-i>", function() require("harpoon"):list():select(3) end,
		{ noremap = true, silent = true, desc = "harpoon select 3" })
	vim.keymap.set('n', "<C-o>", function() require("harpoon"):list():select(4) end,
		{ noremap = true, silent = true, desc = "harpoon select 4" })

	vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

	vim.keymap.set({ "n" }, "<A-e>", "o<Esc>", { noremap = true })
	vim.keymap.set({ "n" }, "<A-i>", "O<Esc>", { noremap = true })
else
	vim.keymap.set("n", "n", "nzz")

	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "j", "<Left>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "k", "<Down>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "l", "<Up>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "ö", "<Right>", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "K", "<Down>zz", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "L", "<Up>zz", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "é", "L", { noremap = true })
	vim.keymap.set({ 'n', 'v', 'x', 's', 'o', 't' }, "h", "", { noremap = true })

	vim.keymap.set({ 'n' }, "<C-w>j", "<C-w>h", { noremap = true })
	vim.keymap.set({ 'n' }, "<C-w>k", "<C-w>j", { noremap = true })
	vim.keymap.set({ 'n' }, "<C-w>l", "<C-w>k", { noremap = true })
	vim.keymap.set({ 'n' }, "<C-w>ö", "<C-w>l", { noremap = true })

	vim.api.nvim_set_keymap('n', 'h', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

	vim.keymap.set({ "n" }, "<A-k>", "o<Esc>", { noremap = true })
	vim.keymap.set({ "n" }, "<A-l>", "O<Esc>", { noremap = true })
end


-- editing --
vim.keymap.set("v", "<leader>p", "\"_dP")                     -- paste without overwriting clipboard
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<C-c><cmd>w<cr>") -- save

-- plugins-specific --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>tt', '<cmd>Telescope<CR>')
vim.keymap.set('n', '<leader>td', '<cmd>Telescope diagnostics<CR>')


-- LSP --
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',
	{ noremap = true, silent = true })

-- Running file --
vim.keymap.set('n', '<leader>r', function()
	local filetype = vim.bo.filetype
	local cmd = ''

	if filetype == 'python' then
		cmd = 'python3 %'
	elseif filetype == 'javascript' then
		cmd = 'node %'
	elseif filetype == 'sh' then
		cmd = 'bash %'
	elseif filetype == 'ruby' then
		cmd = 'ruby %'
	elseif filetype == 'rust' then
		cmd = 'cargo run'
	else
		print('No run command configured for filetype: ' .. filetype)
		return
	end

	vim.cmd('! ' .. cmd)
end, { noremap = true, silent = true, desc = 'Run current file' })
