#!/usr/bin/env nu

export def lsg [] {
    ls | sort-by type name -i | grid -c | str trim
}
