filetype on
syntax on
if filereadable("/usr/share/vim/google/google.vim")
  source /usr/share/vim/google/google.vim
  Glug youcompleteme-google
  Glug relatedfiles
  Glug outline-window
endif
set ignorecase
set encoding=utf-8
set number
set modeline modelines=5
set tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
set showmatch " shows matching parenthes (good for lisp)
set printoptions+=duplex:off
let g:tex_flavor = "latex"
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

if exists(":Guifont")
  Guifont Monospace:h9
endif
