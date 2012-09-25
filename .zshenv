export	EDITOR=vim
export	PAGER=lv
export  LV=-Ou8
export	BLOCKSIZE=K

export BROWSER=opera-next


PROMPTTTY=`tty | sed -e 's/\/dev\///'`
PROMPT="%b%{[32m%}%n%{[m%}@%{[32m%}%m%{[m%}<%B${PROMPTTTY}%b>
$ "
RPROMPT=" %B%{[33m%}[%39<...<%~]%b%{[m%}"
SPROMPT="correct: %R -> %r ? "
