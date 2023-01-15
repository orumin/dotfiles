" http://tti.matrix.jp/blog/2016-04-19/dein-vim%E3%81%A7%E6%9C%AA%E4%BD%BF%E7%94%A8%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%AE%9A%E7%BE%A9/

" DeinnClean command
command! -bang DeinClean call s:dein_clean(<bang>0)

function! s:dein_clean(force) abort "{{{
  let del_all = a:force
  for p in dein#check_clean()
    if !del_all
      let answer = s:input(printf('Delete %s ? [y/N/a]', fnamemodify(p, ':~')))

      if type(answer) is type(0) && answer <= 0
        " Cancel (Esc or <C-c>)
        break
      endif

      if answer !~? '^\(y\%[es]\|a\%[ll]\)$'
        continue
      endif

      if answer =~? '^a\%[ll]$'
        let del_all = 1
      endif
    endif

    " Delete plugin dir
    call dein#install#_rm(p)
  endfor
endfunction "}}}

function! s:input(...) abort "{{{
  new
  cnoremap <buffer> <Esc> __CANCELED__<CR>
  try
    let input = call('input', a:000)
    let input = input =~# '__CANCELED__$' ? 0 : input
  catch /^Vim:Interrupt$/
    let input = -1
  finally
    bwipeout!
    return input
  endtry
endfunction "}}}
