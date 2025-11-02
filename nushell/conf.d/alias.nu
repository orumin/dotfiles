#!/usr/bin/env nu

if ($env.XDG_CURRENT_DESKTOP? == "gnome") {
  alias xdg-open = gio open
}

if (which nvim | is-not-empty) {
  alias vim = nvim
}

alias info = info --vi-keys
alias lsg = functions lsg
