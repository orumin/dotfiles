local rc_dir = vim.env.XDG_CONFIG_HOME .. "/nvim/rc/plugins"
return {
  {
    "Shougo/ddu.vim",
    lazy = true,
    event = {
      "CmdlineEnter", "InsertEnter"
    },
    dependencies = {
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",
      "Shougo/ddu-source-line",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-action",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-column-filename",
      "Shougo/ddu-filter-matcher_substring",
      "matsui54/ddu-source-help",
      "matsui54/ddu-source-man",
      "matsui54/ddu-source-command_history",
      "matsui54/ddu-source-highlight",
      "matsui54/ddu-vim-ui-select",
      "shun/ddu-source-buffer",
      "shun/ddu-source-rg",
      "gamoutatsumi/ddu-source-nvim-lsp",
    },
    config = function()
      vim.cmd("source " .. rc_dir .. "/plugin-ddu.vim")
    end
  },
  {
    "Shougo/ddu-commands.vim",
    lazy = true,
    cmd = "Ddu"
  },
  {
    "Shougo/ddu-ui-ff",
  },
  {
    "Shougo/ddu-ui-filer",
  },
  {
    "Shougo/ddu-source-line",
  },
  {
    "Shougo/ddu-source-file",
  },
  {
    "Shougo/ddu-source-action",
  },
  {
    "Shougo/ddu-source-file_rec",
  },
  {
    "Shougo/ddu-kind-file",
  },
  {
    "Shougo/ddu-column-filename",
  },
  {
    "Shougo/ddu-filter-matcher_substring",
  },
  {
    "matsui54/ddu-source-help",
  },
  {
    "matsui54/ddu-source-man",
  },
  {
    "matsui54/ddu-source-command_history",
  },
  {
    "matsui54/ddu-source-highlight",
  },
  {
    "matsui54/ddu-vim-ui-select",
  },
  {
    "shun/ddu-source-buffer",
  },
  {
    "shun/ddu-source-rg",
  },
  {
    "gamoutatsumi/ddu-source-nvim-lsp",
  },
}
