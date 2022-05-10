set guifont=Monospace\ 10
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
