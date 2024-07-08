local lsp_zero = require('lsp-zero')

lsp_zero.preset('recommended')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


-- Configure autocompletion
local cmp = require('cmp')
local lspkind = require('lspkind')
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
	{ name = 'ultisnips' },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = function() 
	      return math.floor(0.45 * vim.o.columns) 
      end, 
                     -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...', -- shows when not enough space
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
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
	}
})
