let g:ddc_nvim_lsp_doc_config = {
     \ 'documentation': {
     \   'enable': v:true,
     \   'border': 'single',
     \   'maxWidth': 60,
     \   'maxHeight': 30,
     \ },
     \ 'signature': {
     \   'maxHeight': 5,
     \ },
     \ }
call ddc_nvim_lsp_doc#enable()
