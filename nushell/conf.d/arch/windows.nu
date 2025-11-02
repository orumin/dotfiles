#!/usr/bin/env nu

$env.config.shell_integration.osc133 = false
$env.COLORTERM = "truecolor"
$env.HOME = $env.USERPROFILE

$env.config.keybindings = $env.config.keybindings | append {
  modifier: control
  keycode: char_u5b
  mode: vi_insert
  event: { send: ViChangeMode mode: normal }
}
