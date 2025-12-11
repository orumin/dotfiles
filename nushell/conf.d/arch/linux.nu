#!/usr/bin/env nu

let is_wsl: bool = (uname | get kernel-release | str contains "WSL")

if $is_wsl {
  print ('Is this WSL?: ' + ($is_wsl | into string))
  $env.config.shell_integration.osc133 = false
}
