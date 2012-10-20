export	EDITOR=vim
export	PAGER=lv
export  LV=-Ou8
export	BLOCKSIZE=K

export BROWSER=opera
export PSPDEV="/opt/pspsdk"
export CCACHE_PATH="/usr/bin"
export CCACHE_DIR="/dev/shm"


PROMPTTTY=`tty | sed -e 's/\/dev\///'`
PROMPT="%b%{[32m%}%n%{[m%}@%{[32m%}%m%{[m%}<%B${PROMPTTTY}%b>
%(?..%{[44m%}%?)%{[m%}%(!.#.$) "
RPROMPT=" %B%(?.%{[33m%}[%39<...<%~]%b%{[m%}.:()"
SPROMPT="correct: %R -> %r ? "
