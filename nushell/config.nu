# config.nu
#
# Installed by:
# version = "0.108.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

use functions/
source conf.d/index.nu

# setup theme
if ($nu.default-config-dir | path join "themes/catppuccin/catppuccin_mocha.nu" | path exists) {
  source themes/catppuccin/catppuccin_mocha.nu
}

# setup prompt
if not ((which starship | is-empty) or ($nu.data-dir | path join "vendor/autoload/starship.nu" | path exists)) {
  mkdir ($nu.data-dir | path join "vendor/autoload")
  starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

# import package manager
#
use plugins/nupm/nupm
$env.NUPM_HOME = ($env.XDG_CONFIG_HOME | path join "nushell/plugins")
$env.NU_LIB_DIRS = [
  ($env.NUPM_HOME | path join "modules")
]

$env.PATH = (
  $env.PATH
    | prepend ($env.NUPM_HOME | path join "scripts")
    | uniq
)
