#set environment variable

if type -q nvim
    set -x EDITOR nvim
else if type -q vim
    set -x EDITOR vim
else
    set -x EDITOR vi
end

set -x PAGER less
set -x LV "-Ou8 -c -l"
set -x BLOCKSIZE K
set -x VIRSH_DEFAULT_CONNECT_URI qemu:///system

set -x MINICOM "-l -L -w -c on -a on"

if test -e /home/orumin/.opam/opam-init/init.fish;
    source /home/orumin/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
end

set OSTYPE (uname)

if test -f /etc/os-release
    set -x DIST_NAME (grep '^NAME=' /etc/os-release | awk -F\" '{print $2}')
else
    set -x DIST_NAME "none"
end

set -x VENDOR (uname -r | awk -F- '{print $3}')

switch $OSTYPE
    case Linux
        set -x BROWSER vivaldi-snapshot
        set -x PSPDEV "/opt/pspsdk"
        set -x PSPSDK "$PSPDEV/psp/sdk"
        set -x VITASDK "/usr/local/vitasdk"
        set -x CCACHE_PATH "/usr/bin"
        set -x CCACHE_DIR "/tmp/ccache"
        set -x CCACHE_SIZE 2G

        set -x GDK_USE_XFT 0
        set -x QT_XFT false
        set -x MOZ_USE_XINPUT2 1
        #set -x QT_QPA_PLATFORM wayland
        #set -x QT_QPA_PLATFORMTHEME qt5ct
        set -x QT_QPA_PLATFORM xcb
        set -x QT_QPA_PLATFORMTHEME gtk3

        set -x VTE_CJK_WIDTH auto

        # work arround for totem error(intel_do_flush_locked failed: No such file or directory)
        set -x LIBVA_DRIVER_NAME i965
        set -x VDPAU_DRIVER va_gl

        set -x FREETYPE_PROPERTIES "truetype:interpreter-version=40 cff:hinting-engine=adobe autofitter:warping=1"

    case Darwin
        set -x LANG en_US.UTF-8
    end

if test (uname -v | sed -e 's/#1-\(Microsoft\).*/\1/') = "Microsoft"
    set -x DISPLAY localhost:0.0
end
