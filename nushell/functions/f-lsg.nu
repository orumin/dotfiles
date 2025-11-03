#!/usr/bin/env nu

export def lsg [] {
    ls | sort-by type name -i | grid -c -i | str trim
}
