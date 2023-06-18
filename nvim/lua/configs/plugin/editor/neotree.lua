local icons = {
  git = require("configs.ui.icons").get("git"),
  ui = require("configs.ui.icons").get("ui"),
}
return {
  default_component_configs = {
    indent = {
      expander_collapsed = icons.ui.ArrowClosed,
      expander_expanded = icons.ui.ArrowOpen,
    },
    icon = {
      folder_closed = icons.ui.Folder,
      folder_open = icons.ui.FolderOpen,
      folder_empty = icons.ui.EmptyFolder,
    },
    modified = {
      symbol = icons.ui.Modified,
    },
    git_status = {
      symbols = {
        added = icons.git.Add,
        modified = icons.git.Mod,
        deleted = icons.git.Remove,
        renamed = icons.git.Rename,
        untracked = icons.git.Untracked,
        ignored = icons.git.Ignore,
        unstaged = icons.git.Unstaged,
        staged = icons.git.Staged,
        conflict = icons.git.Conflict,
      },
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
  },
}
