return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"honza/vim-snippets",
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		},
		config = function()
			-- Load snippets from vim-snippets
			require("luasnip.loaders.from_snipmate").lazy_load()

			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				keymap = {
					-- closest built-in equivalent to the previous nvim-cmp Tab/S-Tab setup
					preset = "super-tab",
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				completion = {
					documentation = { auto_show = true },
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
			})
		end,
	},
}
