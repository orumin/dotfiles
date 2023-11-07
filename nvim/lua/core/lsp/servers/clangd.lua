return function(opts)
  opts = opts or {}

  local lsputil = require("lspconfig.util")

  local clangd_conf = require("configs.plugin.lsp.servers.clangd_conf")

  local clangd_settings = clangd_conf.lsp_opts
  clangd_settings.root_dir = lsputil.root_pattern('build/compile_commands.json', '.git', 'compile_commands.json')
  local clangd_opts = vim.tbl_deep_extend("force", {}, opts, clangd_settings)
  require("lspconfig").clangd.setup(clangd_opts)

  local augroup = vim.api.nvim_create_augroup("CppLspAttach", {clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    pattern = clangd_settings.filetypes,
    callback = function (auopts)
      local root_dir = clangd_settings.root_dir(auopts.file)
      local ok, cmake_session = pcall(require, "cmake-tools.session")
      if ok then
        cmake_session.save({
          build_directory = "build",
          build_type = "Debug",
          cwd = root_dir
        })
      end
    end
  })

end
