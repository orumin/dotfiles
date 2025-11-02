#!/usr/bin/env nu

$env.config.keybindings = $env.config.keybindings | append {
  name: HistoryHintComplete
  modifier: control
  keycode: char_f
  mode: vi_insert
  event: { send: HistoryHintComplete }
}

$env.config.keybindings = $env.config.keybindings | append {
  name: HistoryHintWordComplete
  modifier: alt
  keycode: char_f
  mode: vi_insert
  event: { send: HistoryHintWordComplete }
}
