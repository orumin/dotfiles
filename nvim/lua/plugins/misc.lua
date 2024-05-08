return {
  {
    "himanoa/ttene.nvim",
    event = { "InsertEnter" },
    config = function()
      local configs = require("configs")
      if configs.use_ttene then
        local utils = require("envutils")
        local G = utils:globals()
        local opt = {
          cmd = "mpv",
          voices_dir = utils:path_concat({G.nvim_data_dir, "ttene"})
        }
        require("ttene").setup(opt)
      end
    end,
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
