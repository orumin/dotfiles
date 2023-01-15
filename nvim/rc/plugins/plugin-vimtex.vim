let g:tex_flavor = 'latex'

if has("mac")
    let g:vimtex_view_method = 'skim'
else
    let g:vimtex_view_method = 'general'
    let g:vimtex_view_general_viewer = 'fwdevince'
    let g:vimtex_view_general_options = '@pdf @line @tex'
endif

let g:vimtex_compiler_latexmk = {
    \ 'options': [
    \   '-pdfdvi',
    \   '-file-line-error',
    \   '-halt-on-error',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \   '-synctex=1',
    \],
\}
