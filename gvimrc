if has("gui_gtk2")
   set guifont=Monospace\ 9
else
   set guifont=-misc-fixed-medium-r-semicondensed-*-*-120-*-*-c-*-iso10646-1
endif

set lines=25 columns=84

function GTKLP()
   call system('gtklp ' . v:fname_in)
   call delete(v:fname_in)
   return v:shell_error
endfunc
function Kprinter()
   call system('kprinter ' . v:fname_in)
   call delete(v:fname_in)
   return v:shell_error
endfunc
