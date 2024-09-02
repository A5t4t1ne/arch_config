local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)


-- Configure autocompletion
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
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

-- lsp_zero.configure('ltex', {
-- 	settings = {
-- 		ltex = {
-- 			language = "de-DE", -- Set German as the default language
-- 		},
-- 	},
-- 	filetypes = { "markdown", "tex", "latex" }, -- Specify the filetypes for ltex-ls
-- })


require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'tsserver',
		'rust_analyzer',
		'clangd',
		'java_language_server',
		'biome',
		'texlab',
		'marksman',
	},

	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
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

require("lspconfig").ltex.setup({
    on_attach = function(client, bufnr)
        -- your other on_attach code
        -- for example, set keymaps here, like
        -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        -- (see below code block for more details)
        require("ltex-utils").on_attach(bufnr)
    end,
    settings = {
        -- ltex = { your settings },
    },
})

