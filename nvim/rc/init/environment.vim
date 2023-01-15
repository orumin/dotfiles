if has('win32') || has('win64')
    let $PATH='D:/Program Files (x86)/Git/bin;'.$PATH
    let $PATH='D:/MinGW/msys/1.0/bin;'.$PATH
    let $PATH='D:/MinGW/bin;'.$PATH
    let $PATH=expand('$VIM/vimfiles/bin').';'.$PATH
    set runtimepath^=$HOME/.vim
    set runtimepath+=$HOME/.vim/after
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
