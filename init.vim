filetype on
syntax on
if filereadable("/usr/share/vim/google/google.vim")
  source /usr/share/vim/google/google.vim
  Glug youcompleteme-google
  Glug relatedfiles
  Glug outline-window
  Glug google-csimporter
endif
packadd! taglist
set ignorecase
set encoding=utf-8
set number
set modeline modelines=5
set tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
set showmatch " shows matching parenthes (good for lisp)
set printoptions+=duplex:off
let g:tex_flavor = "latex"
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_list_stop_completion = ['<TAB>', '<Enter>']
augroup filetype
  au BufRead,BufNewFile *.flex,*.jflex    set filetype=jflex
augroup END
au Syntax jflex    so ~/.vim/syntax/jflex.vim

noremap q <Nop>
noremap Q q

set rtp+=/usr/lib/google-golang/misc/vim

nmap <F4> :call OpenFileFromClipboard()
imap <F4> :call OpenFileFromClipboard()
filetype on
filetype plugin on
filetype indent on

set mouse=a
"Fix select-to-copy in neovim-qt, and also in neovim from the command-line.
vmap <LeftRelease> "*ygv
vmap <2-LeftMouse> <2-LeftMouse>"*ygv
nmap <2-LeftMouse> <2-LeftMouse>"*ygv
vmap <3-LeftMouse> <3-LeftMouse>"*ygv

if exists(":Guifont")
  Guifont Monospace:h9
endif
