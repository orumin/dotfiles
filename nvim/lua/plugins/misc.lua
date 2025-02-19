return {
  -- tweet your neovim per type any character, by voice of 'Natori Sana'
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
  -- show mini pets on your neovim
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
  -- make your code to cellular automaton (lifegame, scramble, etc)
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
