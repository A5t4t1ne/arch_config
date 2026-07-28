return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local util = require("lspconfig.util")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
			-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
			capabilities.workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			}
			local ok_blink, blink = pcall(require, "blink.cmp")
			if ok_blink then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end

			vim.lsp.config("*", { capabilities = capabilities })

			-- servers installed & enabled automatically through mason-lspconfig
			local servers = {
				clangd = {},
				gopls = {
					settings = {
						gopls = {
							semanticTokens = true,
						},
					},
				},
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
				rubocop = {},
				ansiblels = {},
				gitlab_ci_ls = {},
				yamlls = {},
				omnisharp = {},
				tinymist = {
					settings = {
						formatterMode = "typstfmt", -- typstfmt / typstyle
						exportPdf = "none",
						semanticTokens = "disable",

						formatterPrintWidth = 80,
						formatterIndentSize = 4,
						formatterProseWrap = true,
					},
					root_dir = function(bufnr, on_dir)
						-- Necessary so chapters/chapter.typ can access a figure from a parallel dir
						local fname = vim.api.nvim_buf_get_name(bufnr)
						local root = util.root_pattern(".git", "typst.toml")(fname)
						on_dir(root or vim.fn.getcwd()) -- as fallback, use the folder of the current file
					end,
				},
			}

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_enable = true,
			})

			-- ruby_lsp is managed through asdf, not mason
			vim.lsp.config("ruby_lsp", {
				cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
			})
			vim.lsp.enable("ruby_lsp")

			-- configured but not auto-enabled (no mason package, only relevant for arduino sketches)
			vim.lsp.config("arduino_language_server", {
				cmd = {
					"arduino-language-server",
					"-cli-config", "/home/dave/.arduino15/arduino-cli.yaml",
					"-fqbn", "esp32:esp32:nodemcu-32s",
				},
				filetypes = { "arduino" },
				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local root = util.root_pattern("*.ino", "sketch.yaml")(fname)
					on_dir(root or vim.fn.getcwd())
				end,
			})

			-- Replicates lsp-zero's former default_keymaps preset
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local map = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
					end

					map("n", "K", vim.lsp.buf.hover)
					map("n", "gd", vim.lsp.buf.definition)
					map("n", "gD", vim.lsp.buf.declaration)
					map("n", "gi", vim.lsp.buf.implementation)
					map("n", "go", vim.lsp.buf.type_definition)
					map("n", "gr", vim.lsp.buf.references)
					map("n", "gs", vim.lsp.buf.signature_help)
					map("i", "<C-k>", vim.lsp.buf.signature_help)
					map("n", "<F2>", vim.lsp.buf.rename)
					map({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end)
					map("n", "<F4>", vim.lsp.buf.code_action)
					map("n", "gl", vim.diagnostic.open_float)
					map("n", "[d", vim.diagnostic.goto_prev)
					map("n", "]d", vim.diagnostic.goto_next)

					vim.bo[bufnr].formatexpr = ""
				end,
			})

			-- This is necessary so that tinymist knows which is the main file
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "main.typ",
				callback = function()
					vim.lsp.buf.execute_command({
						command = "tinymist.pinMain",
						arguments = { vim.api.nvim_buf_get_name(0) },
					})
				end,
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.gitlab-ci*.{yml,yaml}",
				callback = function()
					vim.bo.filetype = "yaml.gitlab"
				end,
			})
		end,
	},
}
