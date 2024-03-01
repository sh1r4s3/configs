" Load plugins with
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Plug 'sainnhe/sonokai'
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/gtags.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rootkiter/vim-hexedit'
Plug 'sjbach/lusty'
Plug 'tpope/vim-fugitive'
Plug 'masukomi/vim-markdown-folding'
call plug#end()

"
if has ('termguicolors')
    set termguicolors
endif
set background=dark
set cursorline

" The configuration options should be placed before `colorscheme sonokai`.
" let g:sonokai_style = 'maia'
" let g:sonokai_enable_italic = 0
" let g:sonokai_disable_italic_comment = 1

" colorscheme sonokai
colorscheme dracula

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#searchcount#enabled = 0
let g:airline_theme='dracula'

runtime ftplugin/man.vim

" Backup and swap files
set nobackup
set directory=$HOME/.vim/swp//

let g:lsp_auto_enable = 0
" LSP: register servers
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['cpp', 'c'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"
set backspace=indent,eol,start
set number
set relativenumber
set incsearch
set nowrapscan
set hlsearch
set iskeyword&
set mouse=a
set clipboard=unnamed
set textwidth=78
set formatoptions=croq1jp
set modeline

" Indentation
set shiftwidth=4
set expandtab
set cinoptions=(0,j1,ws,Ws
filetype indent on

" Make some special characters visible
set listchars=trail:·,tab:❭…
set vb t_vb= " Turn off visual bell, error flash
set list

" Spell checking
set spell spelllang=en,ru

fun! s:AddChangeLog()
  let curtime = strftime("%a %b %d %Y")
  put ='* '.curtime.' Nikita Ermakov <arei@altlinux.org> '
endfun

function s:manv(manpage, number = -1)
  let g:ft_man_open_mode = 'vert'
  if number >= 0
    Man number manpage
  else
    Man manpage
  endif
endfunction
command Manv -nargs=+ call s:manv

highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\S\+\zs\s\+$/
match ExtraWhitespace /\zs\s\+$/

" for lusty explorer
set hidden
noremap cf :LustyFilesystemExplorer<Enter>

" KeyMap
noremap cp :CtrlPBuffer<Enter>
nnoremap <Left> :tabp<Enter>
nnoremap <Right> :tabn<Enter>

" Fold shell
set nofoldenable
set foldmethod=marker
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
syntax enable

" vim-markdown-folding
set nocompatible
if has("autocmd")
    filetype plugin indent on
endif
autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

" To read:
" 'cpoptions'
" 'relativenumber'
