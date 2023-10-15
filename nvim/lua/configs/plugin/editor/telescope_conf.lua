return function ()
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")
  local egrep_actions = require("telescope._extensions.egrepify.actions")

  require("telescope").setup({
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key",
          ["<C-t>"] = trouble.open_with_trouble
        },
        n = {
          ["<C-t>"] = trouble.open_with_trouble
        }
      }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
      egrepfiy = {
        -- intersect tokens in prompt ala "str1.*str2" that ONLY matches
        -- if str1 and str2 are consecutively in line with anything in between (wildcard)
        AND = true,
        permutations = false,
        lnum = true,
        lnum_hl = "EgrepifyLnum",
        col = false,
        col_hl = "EgrepifyCol",
        title = true,
        filename_hl = "EgrepifyFile",
        -- suffix = long line, see screenshot
        -- EXAMPLE ON HOW TO ADD PREFIX!
        prefixes = {
          -- ADDED ! to invert matches
          -- example prompt: ! sorter
          -- matches all lines that do not comprise sorter
          -- rg --invert-match -- sorter
          ["!"] = {
            flag = "invert-match",
          },
          -- HOW TO OPT OUT OF PREFIX
          -- ^ is not a default prefix and safe example
          ["^"] = false
        },
        -- default mappings
        mappings = {
          i = {
            -- toggle prefixes, prefixes is default
            ["<C-z>"] = egrep_actions.toggle_prefixes,
            -- toggle AND, AND is default, AND matches tokens and any chars in between
            --["<C-a>"] = egrep_actions.toggle_end,
            -- toggle permutations, permutations of tokens is opt-in
            ["<C-r>"] = egrep_actions.toggle_permutations,
          }
        }
      },
      noice = {}
    }
  })
end
