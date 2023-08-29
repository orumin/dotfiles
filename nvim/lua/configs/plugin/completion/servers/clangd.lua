local icons = {
  diagnostics = require("configs.ui.icons").get("diagnostics"),
  codicons = require("configs.ui.icons").get("codicons"),
}

local util = require("lspconfig.util")

local clangd_settings = {
  filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
  root_dir = util.root_pattern('build/compile_commands.json', '.git', 'compile_commands.json'),
  capabilities = { offsetEncoding = { "utf-16", "utf-8" } },
  single_file_support = true,
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_attach = function (_, bufnr)
    vim.wo.signcolumn = 'yes'
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "K", function()
      local cword = vim.fn.expand("<cword>")
      vim.cmd("Man " .. cword)
    end, { buffer = bufnr, desc = "search doc by keywordprg" })
    vim.keymap.set("n", "<C-k>", "<Cmd>Lspsaga hover_doc<CR>", { buffer = bufnr })

    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  end,
}

local clangd_extensions_opts = {
  inlay_hints = {
    inline = vim.fn.has("nvim-0.10") == 1,
    -- Options other than `highlight' and `priority' only work
    -- if `inline' is disabled
    -- Only show inlay hints for the current line
    only_current_line = false,
    -- Event which triggers a refersh of the inlay hints.
    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
    -- not that this may cause  higher CPU usage.
    -- This option is only respected when only_current_line and
    -- autoSetHints both are true.
    only_current_line_autocmd = "CursorHold",
    -- whether to show parameter hints with the inlay hints or not
    show_parameter_hints = true,
    -- prefix for parameter hints
    parameter_hints_prefix = "<- ",
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
    -- whether to align to the length of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- whether to align to the extreme right or not
    right_align = false,
    -- padding from the right if right_align is true
    right_align_padding = 7,
    -- The color of the hints
    highlight = "Comment",
    -- The highlight group priority for extmark
    priority = 100,
  },
  ast = {
    --[[ These are unicode, should be available in any font
          role_icons = {
               type = "🄣",
               declaration = "🄓",
               expression = "🄔",
               statement = ";",
               specifier = "🄢",
               ["template argument"] = "🆃",
          },
          kind_icons = {
              Compound = "🄲",
              Recovery = "🅁",
              TranslationUnit = "🅄",
              PackExpansion = "🄿",
              TemplateTypeParm = "🅃",
              TemplateTemplateParm = "🅃",
              TemplateParamObject = "🅃",
          },]]
    -- These require codicons (https://github.com/microsoft/vscode-codicons)
    role_icons = {
      type = icons.codicons.Type,
      declaration = icons.codicons.Declaration,
      expression = icons.codicons.Expression,
      specifier = icons.codicons.Specifier,
      statement = icons.codicons.Statement,
      ["template argument"] = icons.codicons.TemplateParam,
    },

    kind_icons = {
      Compound = icons.codicons.Compound,
      Recovery = icons.diagnostics.Error_alt,
      TranslationUnit = icons.codicons.TranslationUnit,
      PackExpansion = icons.codicons.PackExpansion,
      TemplateTypeParm = icons.codicons.TemplateParam,
      TemplateTemplateParm = icons.codicons.TemplateParam,
      TemplateParamObject = icons.codicons.TemplateParam,
    },

    highlights = {
      detail = "Comment",
    },
  },
  memory_usage = {
    border = "none",
  },
  symbol_info = {
    border = "none",
  },
}

return function(opts)
  if opts == nil then
    opts = {}
  end

  local clangd_opts = vim.tbl_deep_extend("force", {}, opts, clangd_settings)

  require("lspconfig").clangd.setup(clangd_opts)
  require("clangd_extensions").setup(clangd_extensions_opts)
end
