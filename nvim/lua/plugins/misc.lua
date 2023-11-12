return {
  {
    "orumin/ttene.nvim",
    branch = "rewrite_with_lua",
    event = { "InsertEnter" },
    config = true,
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
