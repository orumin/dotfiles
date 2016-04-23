if has('unix')
    let g:snowdrop#libclang_directory = '/usr/lib'
    let g:snowdrop#include_paths = {
    \   'c' : [
    \       '/usr/include',
    \       '/usr/lib/gcc/x86_64-unknown-linux-gnu/5.3.0/include',
    \   ],
    \   'cpp' : [
    \       '/usr/include',
    \       '/usr/include/c++/5.3.0',
    \       '/usr/lib/gcc/x86_64-unknown-linux-gnu/5.3.0/include',
    \       '/usr/include/boost',
    \   ]
    \}
    let g:snowdrop#command_options = {
    \   'c' : '-std=c11',
    \   'cpp' : '-std=c++1z -stdlib=libc++ --pedantic-errors'
    \}
endif

