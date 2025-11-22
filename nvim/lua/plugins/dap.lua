local dap = require("dap")

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}


dap.adapters.coreclr = {
  type = "executable",
  command = "/usr/bin/netcoredbg",
  args = {"--interpreter=vscode"},
}

dap.configurations.cs = {
  {
    type = 'coreclr';
    name = "Launch local project";
    request = 'launch';
    program = function()
      return vim.fn.input('Path to DLL: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end;
    cwd = '${workspaceFolder}';
  },
}

