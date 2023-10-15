local utils = require("envutils")
local G = utils:globals()

return function(opts)
  local rt = require("rust-tools")
  local rt_executor = require("rust-tools.executors").termopen
  local rt_dap = require("rust-tools.dap")

  local codelldb_dir = G.nvim_data_dir .. G.path_sep .. "mason" .. G.path_sep .. "packages" .. G.path_sep .. "codelldb" .. G.path_sep .. "extension"
  local codelldb_path = codelldb_dir .. G.path_sep .. "adapter" .. G.path_sep .. "codelldb" .. (G.is_win and ".exe" or "")
  local liblldb_path = codelldb_dir .. G.path_sep .. "lldb" .. G.path_sep .. (G.is_win and "bin" .. G.path_sep .. "liblldb.dll" or "lib" .. G.path_sep .. "liblldb")

  if G.is_linux then liblldb_path = liblldb_path .. ".so" end
  if G.is_mac then liblldb_path = liblldb_path .. ".dylib" end

  local rust_tools_opts = {
    tools = {
      executor = rt_executor,
      on_initialized = nil,
      reload_workspace_from_cargo_toml = true,
      inlay_hints = { auto = false }
    },
    server = {},
    dap = {}
  }

  rust_tools_opts.server.autostart = true
  rust_tools_opts.server.capabilities = opts.capabilities
  rust_tools_opts.server.on_attach = function (_, bufnr)
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "rust hover actions"  })
    vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "rust code action group" })
  end

  rust_tools_opts.dap.adapter = rt_dap.get_codelldb_adapter(codelldb_path, liblldb_path)

  rt.setup(rust_tools_opts)
end
