return function()
  local utils = require("envutils")
  local G = utils:globals()

  local codelldb_dir = utils:path_concat({G.nvim_data_dir, "mason", "packages", "codelldb", "extension"})
  local codelldb_path = utils:path_concat({codelldb_dir, "adapter", "codelldb"}) .. (G.is_win and ".exe" or "")
  local liblldb_bin_path = utils:path_concat({(G.is_win and "bin" or "lib"), (G.is_win and "liblldb.dll" or "liblldb")})
  local liblldb_path = utils:path_concat({codelldb_dir, "lldb", liblldb_bin_path})

  if G.is_linux then liblldb_path = liblldb_path .. ".so" end
  if G.is_mac then liblldb_path = liblldb_path .. ".dylib" end


  vim.g.rustaceanvim = function()
    local cfg = require("rustaceanvim.config")
    return {
      server = {
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<C-space>", function() vim.cmd.RustLsp({'hover', 'actions'}) end, { silent = true, buffer = bufnr, desc = "rust hover actions"  })
          vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp('codeAction') end, { silent = true, buffer = bufnr, desc = "rust code action group" })
        end
      },
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      },
    }
  end
end
