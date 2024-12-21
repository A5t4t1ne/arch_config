local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
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
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
capabilities.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}


require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'clangd',
		'texlab',
		'marksman',
		'rust_analyzer',
		'lua_ls',
		'jedi_language_server',
		'ruby_lsp',
		'sorbet',
		'ltex',
		'typst_lsp',
		'gopls',
		-- needs to be manually installed: 
		-- 'goimports',
		-- 'gofumpt',
		-- 'gomodifytags',  -- Modify struct field tags
		-- 'impl'
	},

	handlers = {
		function(server_name)
			local lspconfig = require('lspconfig')
			if server_name == "typst_lsp" then
				lspconfig.typst_lsp.setup({
					filetypes = { "typ" }, -- File type for Typst files
					cmd = { "typst-lsp" }, -- Ensure typst-lsp is in your PATH
					root_dir = lspconfig.util.root_pattern(".git", "*.typ"),
					settings = {}, -- Add Typst-specific settings if needed
				})
			else
				require('lspconfig')[server_name].setup({})
			end
		end,



		texlab = function()
			require('lspconfig').texlab.setup({
				settings = {
					texlab = {
						auxDirectory = ".",
						bibtexFormatter = "texlab",
						chktexOpts = {
							lint = {
								enabledWarnings = { "code", "math" },
							},
						},
						formatterLineLength = 80,
					},
				},
			})
		end
	}
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopePrompt",
	callback = function()
		vim.b.ltex_enabled = false -- disable ltex for telescope
	end,
})


require('lspconfig').solargraph.setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	settings = {
		solargraph = {
			diagnostics = true,
			completion = true,
			rename = true -- Explicitly enable renaming
		}
	}
}
