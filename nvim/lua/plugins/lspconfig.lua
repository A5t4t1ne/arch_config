local lsp_zero = require('lsp-zero')

lsp_zero.preset('recommended')


lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


-- Configure autocompletion
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})


cmp.setup({
  mapping = cmp_mappings,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'copilot' },
  },
})


-- require('lspconfig').rust_analyzer.setup({})
-- require('lspconfig').clangd.setup({})
-- require('lspconfig').anakin_language_server.setup({})
-- require('lspconfig').java_language_server.setup({})
-- require('lspconfig').biome.setup({})
-- require('lspconfig').texlab.setup({
-- 	settings = {
-- 		texlab = {
-- 			auxDirectory = ".",
-- 			bibtexFormatter = "texlab",
-- 			chktexOpts = {
-- 				lint = {
-- 					enabledWarnings = { "code", "math" },
-- 				},
-- 			},
-- 			formatterLineLength = 80,
-- 		},
-- 	},
-- })
-- require('lspconfig').ltex.setup({
-- 	settings = {
-- 		ltex = {
-- 			lang = "de-CH",
-- 		}
-- 	}
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
		end,
  },
})
