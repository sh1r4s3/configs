" Load plugins with
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"
colorscheme space-vim-dark
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='violet'

runtime ftplugin/man.vim

" Backup and swap files
set nobackup
set directory=$HOME/.vim/swp//

"
set number
set relativenumber
set incsearch
set nowrapscan
set hlsearch
set iskeyword&
set mouse=a
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


" To read:
" 'cpoptions'
" 'relativenumber'
" 
