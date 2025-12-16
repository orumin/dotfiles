#!/usr/bin/env nu

source arch.nu
source environment.nu
source basis.nu

source alias.nu
source keybindings.nu

const secret_path = if ($nu.config-path | path dirname | path join 'conf.d/secrets.nu' | path exists) {
    $nu.config-path | path dirname | path join 'conf.d/secrets.nu'
} else { null }
source $secret_path
