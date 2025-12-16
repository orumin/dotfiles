#!/usr/bin/env nu

export def lsg [target?: path] {
    ls ($target | default .) | sort-by type name -i | grid -c -s '  ' -i | str trim
}
