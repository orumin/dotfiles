call ddc#custom#patch_global('completionMenu', 'pum.vim')

inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

call pum#set_option('setline_insert', v:true)
"autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

"call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'vsnip', 'file', 'dictionary'])
call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'file', 'dictionary'])
call ddc#custom#patch_global('sourceOptions', {
     \ '_': {
       \   'matchers': ['matcher_head'],
       \   'sorters': ['sorter_rank'],
       \   'converters': ['converter_remove_overlap'],
       \ },
       \ 'around': {'mark': 'A'},
       \ 'file': { 'mark': 'F', 'isVolatile': v:true, 'forceCompletionPattern': '\S/\S*'},
       \ 'nvim-lsp': {'mark': 'lsp', 'forceCompletionPattern': "\\.|:\\s*|->", 'ignoreCase': v:true},
       \ 'dictionary': {'matchers': ['matcher_editdistance'], 'sorters': [], 'maxCandidates': 6, 'mark': 'D', 'minAutoCompleteLength': 3},
       \ })
"       \ 'vsnip': {'mark': 'V', 'dup': v:true},

call ddc#custom#patch_global('sourceParams', {
     \ 'around': {'maxSize': 500},
     \ 'file': {'smartCase': v:true},
     \ })

call ddc#enable()
