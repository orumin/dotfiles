#!/usr/bin/bash

if [ -n "$(command -v starship)" ]; then
    eval "$(starship init bash)"
else
    # color palette of 'catppuccin mocha'
    #my_color_rosewater="245;224;220" # "#f5e0dc"
    #my_color_flamingo="242;205;205"  # "#f2cdcd"
    #my_color_pink="245,194,231"      # "#f5c2e7"
    #my_color_mauve="203,166,247"     # "#cba6f7"
    #my_color_red="245;139;168"       # "#f38ba8"
    #my_color_maroon="235;160;172"    # "#eba0ac"
    #my_color_peach="250;179;135"     # "#fab387"
    #my_color_yellow="249;226;175"    # "#f9e2af"
    #my_color_green="166;227;161"     # "#a6e3a1"
    #my_color_teal="148;226;213"      # "#94e2d5"
    #my_color_sky="137;220;235"       # "#89dceb"
    #my_color_sapphire="116;199;236"  # "#74c7ec"
    my_color_blue="137;180;250"      # "#89b4fa"
    #my_color_lavender="180;190;254"  # "#b4befe"
    my_color_text="205;214;244"      # "#cdd6f4"
    #my_color_subtext1="186;194;222"  # "#bac2de"
    #my_color_subtext0="166;173;200"  # "#a6adc8"
    #my_color_overlay2="147;153;178"  # "#9399b2"
    #my_color_overlay1="127;132;156"  # "#7f849c"
    #my_color_overlay0="108;112;134"  # "#6c7086"
    #my_color_surface2="88;91;112"    # "#585b70"
    my_color_surface1="69;71;90"     # "#45475a"
    #my_color_surface0="49;50;68"     # "#313244"
    #my_color_base="30;30;46"         # "#1e1e2e"
    my_color_mantle="24;24;37"       # "#181825"
    #my_color_crust="17;17;27"        # "#11111b"

    color_reset="\e[0m"

    sep1=''
    sep2=''

    thm_blue="\e[38;2;${my_color_blue}m"
    thm_blue_bg="\e[48;2;${my_color_blue}m"
    thm_mantle="\e[38;2;${my_color_mantle}m"
    thm_mantle_bg="\e[48;2;${my_color_mantle}m"
    thm_gray="\e[38;2;${my_color_surface1}m"
    thm_gray_bg="\e[48;2;${my_color_surface1}m"

    prompttty=$(tty | sed -e 's|/dev/||')

    line1="\[${thm_mantle}${thm_blue_bg}\]\u \[${thm_blue}${thm_gray_bg}\]${sep2}"
    line2="\[${thm_blue}${thm_gray_bg}\] \h ${sep1} ${prompttty} \[${thm_gray}${thm_mantle_bg}\]${sep2}"
    line3="\[\e[38;2;${my_color_text}m${thm_mantle_bg}\] (\W) \[${color_reset}\]\[${thm_mantle}\]${sep2}\[${color_reset}\]"
    prompt_sign='➤ '

    PS1=$(printf "%s%s%s\n%s" "$line1" "$line2" "$line3" "$prompt_sign")

    export PS1
fi

if [ -n "$(command -v exa)" ]; then
    alias ls='exa --icons'
fi
if [ -n "$(command -v bat)" ]; then
    alias cat='bat'
fi
. "$HOME/.cargo/env"
