#!/usr/bin/env nu

let ostype: string = (uname | get operating-system)
let kernel_release = (uname | get kernel-release)
let is_wsl: bool = ($ostype == "Linux" and ($kernel_release | str contains --ignore-case "microsoft"))
let is_wsl_2: bool = $is_wsl and ($kernel_release | str contains "WSL2")

$env.XDG_CONFIG_HOME = ($env.HOME | path join .config)
$env.XDG_CACHE_HOME = ($env.HOME | path join .cache)

$env.N_PREFIX = ($env.HOME | path join node)
$env.GO_HOME = ($env.HOME | path join go)
$env.CABAL_HOME = ($env.HOME | path join .cabal)
$env.OPAM_HOME = ($env.HOME | path join .opam)
$env.CARGO_HOME = ($env.HOME | path join .cargo)
$env.NODE_HOME = ($env.HOME | path join node)
$env.NIMBLE_HOME = ($env.HOME | path join .nimble)
$env.LUAROCKS_HOME = ($env.HOME | path join .luarocks)
$env.DENO_INSTALL = ($env.HOME | path join .deno)

# below is outdated way to prepend to PATH
# nushell 0.60+ supports structured environment like fish-shell
#
#$env.PATH = (
#  $env.PATH
#  | split row (char esep)
#  | prepend ($env.HOME + "/.cargo/bin")
#  | ...
#  | uniq
#)

def contain-path [
  needle: string
  --ignore-case (-i)
]: nothing -> bool {
  if $ignore_case {
    $env.PATH | any {|p| ($p | str contains --ignore-case $needle)}
  } else {
    $env.PATH | any {|p| ($p | str contains $needle)}
  }
}

#if not (contain-path "/snap/bin") {
#  $env.path = ($env.PATH | prepend /snap/bin)
#}

if (contain-path --ignore-case "Gentoo") or ($kernel_release | str contains --ignore-case "gentoo") {
  $env.PATH = ($env.PATH | prepend /usr/sbin | prepend /sbin)
}

$env.PATH = (
  $env.PATH
  | prepend /snap/bin
  | prepend ($env.HOME | path join ".local/bin")
  | prepend ($env.HOME | path join "bin")
  | prepend ($env.HOME | path join "brew/bin")
  | prepend ($env.CARGO_HOME | path join "bin")
  | prepend ($env.NODE_HOME | path join "bin")
  | prepend ($env.NODE_HOME | path join "npm-packages/bin")
  | prepend ($env.GO_HOME | path join "bin")
  | prepend ($env.CABAL_HOME | path join "bin")
  | prepend ($env.OPAM_HOME | path join "bin")
  | prepend ($env.NIMBLE_HOME | path join "bin")
  | prepend ($env.LUAROCKS_HOME | path join "bin")
  | prepend ($env.DENO_INSTALL | path join "bin")
  | uniq
)

if (which nvim | is-not-empty) {
  $env.EDITOR = 'nvim'
  $env.MANPAGER = 'nvim +Man!'
} else if (which vim | is-not-empty) {
  $env.EDITOR = 'vim'
} else {
  $env.EDITOR = 'vi'
}

if (which bat | is-not-empty) {
  $env.MANPAGER = "sh -c 'sed -u -e \"s/\\x1B[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
}

$env.PAGER = 'less'

if (which lesspipe | is-not-empty) {
  let lesspipe_path: string = (which lesspipe | get path).0
  $env.LESSOPEN = '| ' + $lesspipe_path + ' %s'
  $env.LESSCLOSE = $lesspipe_path + ' %s %s'
}

$env.MINICOM = '-l -L -w -c on -a on'

if $is_wsl_2 {
  $env.DISPLAY = ':0'
  $env.COLORTERM = 'truecolor'
}

if ($env.WEZTERM_EXECUTABLE? | is-not-empty) and ($env.HOME | path join ".terminfo/w/wezterm" | path exists) {
  $env.TERM = 'wezterm'
}

if ($env.DISPLAY? | is-empty) and ($env.WAYLAND_DISPLAY? | is-empty) {
  if (which carbonyl | is-not-empty) {
    $env.BROWSER = 'carbonyl'
  } else {
    $env.BROWSER = 'w3m'
  }
} else {
    $env.BROWSER = 'vivaldi'
}