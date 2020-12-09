set ostype (uname)

switch $ostype
    case Darwin
        if test -z (which ls | grep Gentoo)
            alias ls='ls -G -w'
            set -x LSCOLORS fxgxcxdxcxegedabagacad
        else
            alias ls='ls --color'
            set -x LS_COLORS 'no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;32:do=01;32:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;33:*.jpeg=01;33:*.gif=01;33:*.bmp=01;33:*.pbm=01;33:*.pgm=01;33:*.ppm=01;33:*.tga=01;33:*.xbm=01;33:*.xpm=01;33:*.tif=01;33:*.tiff=01;33:*.png=01;33:*.svg=01;33:*.mng=01;33:*.pcx=01;33:*.mov=01;33:*.mpg=01;33:*.mpeg=01;33:*.m2v=01;33:*.m2ts=01;33:*.mkv=01;33:*.ogm=01;33:*.mp4=01;33:*.m4v=01;33:*.mp4v=01;33:*.vob=01;33:*.qt=01;33:*.nuv=01;33:*.wmv=01;33:*.asf=01;33:*.rm=01;33:*.rmvb=01;33:*.flc=01;33:*.avi=01;33:*.fli=01;33:*.gl=01;33:*.dl=01;33:*.xcf=01;33:*.xwd=01;33:*.yuv=01;33:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:'
        end

    case FreeBSD
        alias ls='ls -G -w'
        set -x LSCOLORS fxgxcxdxcxegedabagacad

    case Linux
        alias gcc='gcc -fdiagnostics-color'
        alias ls='ls --color'
        # set dircolors
        set -x LS_COLORS 'no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;32:do=01;32:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;33:*.jpeg=01;33:*.gif=01;33:*.bmp=01;33:*.pbm=01;33:*.pgm=01;33:*.ppm=01;33:*.tga=01;33:*.xbm=01;33:*.xpm=01;33:*.tif=01;33:*.tiff=01;33:*.png=01;33:*.svg=01;33:*.mng=01;33:*.pcx=01;33:*.mov=01;33:*.mpg=01;33:*.mpeg=01;33:*.m2v=01;33:*.m2ts=01;33:*.mkv=01;33:*.ogm=01;33:*.mp4=01;33:*.m4v=01;33:*.mp4v=01;33:*.vob=01;33:*.qt=01;33:*.nuv=01;33:*.wmv=01;33:*.asf=01;33:*.rm=01;33:*.rmvb=01;33:*.flc=01;33:*.avi=01;33:*.fli=01;33:*.gl=01;33:*.dl=01;33:*.xcf=01;33:*.xwd=01;33:*.yuv=01;33:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:'
    end
