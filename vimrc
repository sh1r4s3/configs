" Load plugins with
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Plug 'sainnhe/sonokai'
Plug 'sh1r4s3/vim' "'dracula/vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/gtags.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rootkiter/vim-hexedit'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'masukomi/vim-markdown-folding'
Plug 'junegunn/fzf'
Plug 'vim/killersheep'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/vim-fern-renderer-nerdfont'
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

let mapleader='\'

" Backup and swap files
set nobackup
set directory=$HOME/.vim/swp//

let g:lsp_auto_enable = 0
let g:lsp_diagnostics_enabled = 0
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
    nmap <buffer> <c-k> <plug>(lsp-hover)
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
set ttymouse=sgr
set clipboard=unnamedplus
set textwidth=78
set formatoptions=croq1jp
set modeline

" Indentation
set shiftwidth=2
set expandtab
set cinoptions=(0,j1,ws,Ws

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

" KeyMap
noremap cp :CtrlPBuffer<Enter>
nnoremap <Left> :tabp<Enter>
nnoremap <Right> :tabn<Enter>
nmap <F8> :TagbarToggle<CR>

" Fern
nmap <leader>f :Fern . -drawer -toggle<CR>
let g:fern#renderer = "nerdfont"

" Fold shell
set nofoldenable
set foldmethod=marker
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
syntax enable

" vim-markdown-folding
set nocompatible
autocmd FileType markdown setlocal foldexpr=NestedMarkdownFolds()
autocmd FileType c setlocal textwidth=0 shiftwidth=2 softtabstop=2
autocmd FileType python setlocal textwidth=0 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.schema setlocal filetype=json

" Make use of clang-format
if has('python')
  map <C-i> :pyf /usr/lib/llvm/17/share/clang/clang-format.py<cr>
  imap <C-i> <c-o>:pyf /usr/lib/llvm/17/share/clang/clang-format.py<cr>
elseif has('python3')
  map <C-i> :py3f /usr/lib/llvm/17/share/clang/clang-format.py<cr>
  imap <C-i> <c-o>:py3f /usr/lib/llvm/17/share/clang/clang-format.py<cr>
endif

" To read:
" 'cpoptions'
" 'relativenumber'
