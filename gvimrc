if hostname() == 'lorax.cam.corp.google.com'
  set guifont=Monospace\ 10
else
  set guifont=Monospace\ 9
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
