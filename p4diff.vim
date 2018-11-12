" Vim script to be used for g4 diff.
" Opens a tab for each pair of files.
"
" Use these environment variables:
" P4DIFF        "vim -fRX '+so $HOME/.vim/p4diff.vim'"
" G4MULTIDIFF   1

augroup g4file
  au!
  au BufRead ?\+#[0-9]\+  exe "doau filetypedetect BufRead " . fnameescape(substitute(expand("<afile>"), '#[0-9]\+$', '', ''))
augroup END

"set columns=205
set lazyredraw
set splitright  " put new version right of the old version

let s:idx = 0
while s:idx < argc()
  if argv(s:idx) != ':'
    if s:idx > 2
      tabnew
    endif
    exe "silent edit " . fnameescape(argv(s:idx))
    let s:idx += 1
    exe "silent vertical diffsplit " . fnameescape(argv(s:idx))
    wincmd =
  endif
  let s:idx += 1
endwhile

" GTK resizing doesn't work very well when the tab pages labels appear.
" Reduce the number of lines here.
set lines-=2

" Go to first tab page
tabrewind

" redraw now
set nolazyredraw
redraw

" Increase the width so that GTK gets the resizing done.
" Also provides room for the diff column and vertical separator.
"set columns=205
