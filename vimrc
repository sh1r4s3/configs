" Load plugins with
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/gtags.vim'
call plug#end()

"
if has ('termguicolors')
    set termguicolors
endif
set background=dark
"set cursorline

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#searchcount#enabled = 0
let g:airline_theme='sonokai'

runtime ftplugin/man.vim

" Backup and swap files
set nobackup
set directory=$HOME/.vim/swp//

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
set cinoptions=(0
filetype indent on

" Make some special characters visible
set listchars=tab:ᚱᚲ
set list

" Spell checking
set spell spelllang=en,ru

" Key binding
nnoremap <Left> :tabp<Enter>
nnoremap <Right> :tabn<Enter>

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

" To read:
" 'cpoptions'
" 'relativenumber'
" 
