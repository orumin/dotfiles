export EDITOR=vim
export PAGER=less
export LV="-Ou8 -c -l"
export BLOCKSIZE=K

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

    export VTE_CJK_WIDTH=auto

    # work arround for totem error(intel_do_flush_locked failed: No such file or directory)
    #export LIBGL_DRI3_DISABLE=1
    export LIBVA_DRIVER_NAME=i965
    export VDPAU_DRIVER=va_gl

    #source /home/orumin/scripts/infinality-settings.sh
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
