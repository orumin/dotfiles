local utils = require("envutils")
local G = utils:globals()

local icons = {
  dap = require("configs.ui.icons").get("dap")
}

local function setup_cpp()
  local dap = require("dap")

  dap.adapters.gdb= {
    id = 'gdb',
    type = 'executable',
    command = 'gdb',
      args = { "-i", "dap" },
  }

  local cppdbg_options = nil
  local cppdbg_command = utils:path_concat({G.nvim_data_dir, "mason", "bin", "OpenDebugAD7"})
  if G.is_win then
    cppdbg_command = cppdbg_command .. ".exe"
    cppdbg_options = { detached = false }
  end
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = cppdbg_command,
    options = cppdbg_options
  }

  dap.configurations["cpp"] = {
    {
      name = "Launch file (gdb)",
      type = "gdb",
      request = "launch",
      program = function ()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Launch file (cppdbg)",
      type = "cppdbg",
      request = "launch",
      program = function ()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopAtEntry = true
    },
    {
      name = "Attach to gdbserver :1234 (cppdbg)",
      type = "cppdbg",
      request = "launch",
      MIMode = "gdb",
      miDebuggerServerAddress = "localhost:1234",
      miDebuggerPath = "/usr/bin/gdb",
      program = function ()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      text = "-enable-pretty-printing",
      description = "enable pretty printing",
      ignoreFailures = false
    }
  }

  dap.configurations["c"] = dap.configurations.cpp
  dap.configurations["rust"] = dap.configurations.cpp
end

local function setup_bash()
  local dap = require("dap")

  dap.adapters.bashdb = {
    id = 'bashdb',
    type = 'executable',
    command = utils:path_concat({G.nvim_data_dir, "mason", "bin", "bash-debug-adapter"})
  }

  local pathBashdbLib = utils:path_concat({G.nvim_data_dir, "mason", "packages", "bash-debug-adapter", "extension", "bashdb_dir"})
  dap.configurations["sh"] = {
    {
      name = "Launch file",
      type = "bashdb",
      request = "launch",
      showDebugOutput = true,
      pathBashdb = utils:path_concat({pathBashdbLib, "bashdb"}),
      pathBashdbLib = pathBashdbLib,
      trace = true,
      file = "${file}",
      program = "${file}",
      cwd = "${workspaceFolder}",
      pathCat = "cat",
      pathBash = "/bin/bash",
      pathMkfifo = "mkfifo",
      pathPkill = "pkill",
      args = {},
      env = {},
      terminalKind = "integrated"
    }
  }
end

local function setup_lua()
  local dap = require("dap")

  dap.adapters.nlua = function (callback, config)
    ---@diagnostic disable-next-line: undefined-field
    callback({type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  dap.configurations["lua"] = {
    {
      name = "Attach to running Neovim instance",
      type = "nlua",
      request = "attach"
    }
  }
end

return function ()
  require("dap")
  require("mason-nvim-dap").setup({
    automatic_installation = true,
    ensure_installed = require("configs").dap_default_servers
  })
  local dapui = require("dapui")
  local dap_virt_text = require("nvim-dap-virtual-text")

  vim.fn.sign_define("DapBreakpoint", { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = ""})
  vim.fn.sign_define("DapBreakpointCondition", { text = icons.dap.BreakpointCondition, texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
  vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = ""})

  setup_bash()
  setup_cpp()
  setup_lua()

  dapui.setup()
  dap_virt_text.setup({})
end
