#!/usr/bin/env nu

# too sadly, nushell alias resolve at parse time, so we can't do conditional aliasing like in bash/zsh
# https://github.com/nushell/nushell/issues/5068
#
#if ($env.XDG_CURRENT_DESKTOP? == "gnome") {
#  alias xdg-open = gio open
#}
#
#if (which nvim | is-not-empty) {
#  alias vim = nvim
#}

alias vim = nvim
alias info = info --vi-keys
alias lsg = functions lsg
