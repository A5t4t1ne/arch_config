return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}

			dap.adapters.coreclr = {
				type = "executable",
				command = "/usr/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch local project",
					request = "launch",
					program = function()
						return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>dc", dap.continue, { silent = true, desc = "DAP continue" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { silent = true, desc = "DAP step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { silent = true, desc = "DAP step into" })
			vim.keymap.set("n", "<leader>du", dap.step_out, { silent = true, desc = "DAP step out" })
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { silent = true, desc = "DAP toggle breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { silent = true, desc = "DAP set conditional breakpoint" })
			vim.keymap.set("n", "<leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { silent = true, desc = "DAP set log point" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { silent = true, desc = "DAP open REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { silent = true, desc = "DAP run last" })
		end,
	},
}
