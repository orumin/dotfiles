return function ()
  ---@type qmk.UserConfig
  local opts = {
    name = 'LAYOUT_preonic_grid',
    layout = {
      '_ x x x x x x _ x x x x x x',
      '_ x x x x x x _ x x x x x x',
      '_ x x x x x x _ x x x x x x',
      '_ x x x x x x _ x x x x x x',
      '_ x x x x x x _ x x x x x x',
    }
  }
  require('qmk').setup(opts)
end
