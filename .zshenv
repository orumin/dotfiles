export VTK_DATA_ROOT=/usr/local/share/exmaples/vtk/VTKData
export PACKAGEROOT=ftp://ftp.jp.freebsd.org/
export PACKAGESITE=ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/amd64/package-9.0-release/Latest/
export FTP_PASSIVE_MODE=yes

export	EDITOR=vim
export	PAGER=lv
export	BLOCKSIZE=K

PROMPTTTY=`tty | sed -e 's/\/dev\///'`
PROMPT="%b%{[32m%}%n%{[m%}@%{[32m%}%m%{[m%}<%B${PROMPTTTY}%b>
$ "
RPROMPT=" %B%{[33m%}[%39<...<%~]%b%{[m%}"
SPROMPT="correct: %R -> %r ? "
