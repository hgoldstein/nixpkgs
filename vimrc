set number

set sw=2
set ts=2
set smarttab
set expandtab
set nohlsearch

color kolor

let g:deoplete#enable_at_startup = 1

let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ 'haskell': ['haskell-language-server-wrapper', '--lsp']
\ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
