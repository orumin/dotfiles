if [ "$(which vim)" ]; then
    export EDITOR=vim
elif [ "$(which nvim)" ]; then
    export EDITOR=nvim
else
    export EDITOR=vi
fi
export PAGER=less
export LV="-Ou8 -c -l"
export BLOCKSIZE=K
export VIRSH_DEFAULT_CONNECT_URI=qemu:///system

export MINICOM="-l -L -w -c on -a on"

case `uname` in
    Linux)
    export BROWSER=vivaldi-snapshot
    export PSPDEV="/opt/pspsdk"
    export PSPSDK="${PSPDEV}/psp/sdk"
    export VITASDK="/usr/local/vitasdk"
    export CCACHE_PATH="/usr/bin"
    export CCACHE_DIR="/tmp/ccache"
    export CCACHE_SIZE=2G

    export GDK_USE_XFT=0
    export QT_XFT=false
    export MOZ_USE_XINPUT2=1
    #export QT_QPA_PLATFORM=wayland
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
        export QT_SCREEN_SCALE_FACTORS=1
        export QT_SCALE_FACTOR=1.25
    fi

    export VTE_CJK_WIDTH=auto

    # work arround for totem error(intel_do_flush_locked failed: No such file or directory)
    #export LIBGL_DRI3_DISABLE=1
    export LIBVA_DRIVER_NAME=i965
    export VDPAU_DRIVER=va_gl

    #source /home/$USER/scripts/infinality-settings.sh
    #export FREETYPE_PROPERTIES="truetype:interpreter-version=35 cff:no-stem-darkening=1 autofitter:warping=1"
    export FREETYPE_PROPERTIES="truetype:interpreter-version=40 cff:hinting-engine=adobe autofitter:warping=1"
    ;;
    Darwin)
    export LANG=en_US.UTF-8
    ;;
esac

case $(uname -v | sed -e 's/#1-\(Microsoft\).*/\1/') in
    Microsoft)
    export DISPLAY=localhost:0.0
    ;;
esac
. "$HOME/.cargo/env"
