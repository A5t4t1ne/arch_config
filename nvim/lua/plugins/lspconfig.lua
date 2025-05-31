local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)


-- Configure autocompletion
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

-- Load snippets from vim-snippets
require("luasnip.loaders.from_snipmate").lazy_load()

cmp.setup({
	fields = { 'kind', 'abbr', 'menu' },
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		-- ['<Tab>'] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = lspkind.cmp_format({
			mode = 'symbol', -- show only symbol annotations
			maxwidth = function()
				return math.floor(0.45 * vim.o.columns)
			end,
			ellipsis_char = '...', -- shows when not enough space
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				-- Add the source name to the menu
				vim_item.menu = "[" .. entry.source.name .. "]"

				return vim_item
			end,
		}),
		expandable_indicator = true, -- Show an indicator when an item can be expanded
	},
})

-- An example nvim-lspconfig capabilities setting
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = lsp_zero.on_attach

-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
capabilities.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}

local servers = {
	clangd = {},
	gopls = {},
	-- texlab = {},
	marksman = {},
	rust_analyzer = {},
	lua_ls = {},
	ruff = {},
	pyright = {
		settings = {
			pyright = {
				ignoreExternal = true,
			},
		},
	},
	ruby_lsp = {},
	tinymist = {
		settings = {
			formatterMode = "typstfmt", -- or "typstyle"
			formatterPrintWidth = 80,
			formatterIndentSize = 4,
		}
	},
	sorbet = {},
}


require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	handlers = {
		function(server_name)
			local lspconfig = require('lspconfig')
			if server_name == "tinymist" then
				lspconfig.tinymist.setup({
					settings = {
						-- formatterMode = "typstfmt",
						formatterMode = "typstyle",
						exportPdf = "onType",
						semanticTokens = "disable",

						formatterPrintWidth = 80,
						formatterIndentSize = 4,
					},

					capabilities = capabilities,
					on_attach = lsp_zero.on_attach,
				})
			elseif server_name == "arduino_language_server" then
				lspconfig.arduino_language_server.setup({
					cmd = {
						"arduino-language-server",
						"-cli-config", "/home/dave/.arduino15/arduino-cli.yaml",
						"-fqbn", "esp32:esp32:nodemcu-32s"
					},
					filetypes = { "arduino" },
					root_dir = require('lspconfig.util').root_pattern("*.ino", "sketch.yaml"),
				})
			elseif server_name == "ruby_lsp" then
				require('lspconfig').ruby_lsp.setup({
					cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
					capabilities = capabilities,
					on_attach = lsp_zero.on_attach,
					filetypes = (servers[server_name] or {}).filetypes,
				})
			else
				require('lspconfig')[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name] or {},
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end
		end,

		-- texlab = function()
		-- 	require('lspconfig').texlab.setup({
		-- 		settings = {
		-- 			texlab = {
		-- 				auxDirectory = ".",
		-- 				bibtexFormatter = "texlab",
		-- 				chktexOpts = {
		-- 					lint = {
		-- 						enabledWarnings = { "code", "math" },
		-- 					},
		-- 				},
		-- 				formatterLineLength = 80,
		-- 			},
		-- 		},
		-- 	})
		-- end
	}
})


-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "TelescopePrompt",
-- 	callback = function()
-- 		vim.b.ltex_enabled = false -- disable ltex for telescope
-- 	end,
-- })


-- This is necessary so that tinymist knows which is the main file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "main.typ",
	callback = function()
		vim.lsp.buf.execute_command({
			command = 'tinymist.pinMain',
			arguments = { vim.api.nvim_buf_get_name(0) }
		})
	end,
})
