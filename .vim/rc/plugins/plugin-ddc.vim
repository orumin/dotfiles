inoremap <silent><expr> <TAB>
     \ pumvisible() ? '<C-n>' :
     \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
     \ '<TAB>' : ddc#manual_complete()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'file'])
call ddc#custom#patch_global('sourceOptions', {
     \ '_': {
       \   'matchers': ['matcher_head'],
       \   'sorters': ['sorter_rank'],
       \ },
       \ 'around': {'mark': 'A'},
       \ 'file': {
       \   'mark': 'F',
       \   'isVolatile': v:true,
       \   'forceCompletionPattern': '\S/\S*',
       \ },
       \ 'nvim-lsp': {
       \ 'mark': 'LSP',
       \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
       \ },
       \ })

call ddc#custom#patch_global('sourceParams', {
     \ 'around': {'maxSize': 500},
     \ 'file': {'smartCase': v:true},
     \ })

call ddc#enable()
