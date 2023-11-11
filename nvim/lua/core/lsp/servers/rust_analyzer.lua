return function(opts)
  local utils = require("envutils")
  local G = utils:globals()
  local rt = require("rust-tools")
  local rt_executor = require("rust-tools.executors").termopen
  local rt_dap = require("rust-tools.dap")

  local codelldb_dir = utils:path_concat({G.nvim_data_dir, "mason", "packages", "codelldb", "extension"})
  local codelldb_path = utils:path_concat({codelldb_dir, "adapter", "codelldb"}) .. (G.is_win and ".exe" or "")
  local liblldb_bin_path = utils:path_concat({(G.is_win and "bin" or "lib"), (G.is_win and "liblldb.dll" or "liblldb")})
  local liblldb_path = utils:path_concat({codelldb_dir, "lldb", liblldb_bin_path})

  if G.is_linux then liblldb_path = liblldb_path .. ".so" end
  if G.is_mac then liblldb_path = liblldb_path .. ".dylib" end

  local rust_tools_opts = require("configs.plugin.lsp.servers.rust_analyzer_conf")

  rust_tools_opts.tools.executor = rt_executor

  rust_tools_opts.server.capabilities = opts.capabilities
  rust_tools_opts.server.on_attach = function (_, bufnr)
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "rust hover actions"  })
    vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "rust code action group" })
  end

  rust_tools_opts.dap.adapter = rt_dap.get_codelldb_adapter(codelldb_path, liblldb_path)

  rt.setup(rust_tools_opts)
end
