return {
  {
    "himanoa/ttene.nvim",
    branch = "rewrite_with_lua",
    event = { "InsertEnter" },
    config = function()
      local utils = require("envutils")
      local G = utils:globals()
      local opt = {
        cmd = "mpv",
        voices_dir = utils:path_concat({G.nvim_data_dir, "ttene"})
      }
      require("ttene").setup(opt)
    end,
    cond = false
  },
  {
    "giusgad/pets.nvim",
    cmd = {
      "PetsNew",
      "PetsNewCustom",
      "PetsList",
      "PetsKill",
      "PetsKillAll",
      "PetsRemove",
      "PetsRemoveAll",
      "PetsPauseToggle",
      "PetsHideToggle",
      "PetsIdleToggle",
      "PetsSleepToggle",
    },
    dependencies = {
      "giusgad/hologram.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      row = 8,
      col = 8
    }
  },
}
