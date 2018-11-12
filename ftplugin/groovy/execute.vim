function! Groovy_eval_vsplit() range
   let tmp = tempname()
   let src = substitute(tmp,'/\([^/]*\)$','/GroovyTemp\1.groovy',"")
   let dst = substitute(tmp,'/\([^/]*\)$','/GroovyTemp\1.output',"")
   let tmpo=&cpo
   set cpo-=F
   execute ": " . a:firstline . "," . a:lastline . "w " . src
   let &cpo=tmpo
   execute ":silent ! groovy " . src . " >> " . dst . " 2>&1 "
   execute ":redraw!"
   if getfsize(dst) > 0
      if winnr("$") == 1
	 execute ":vsplit"
      endif
      execute "normal \<C-W>l"
      execute ":e! " . dst
      execute "normal \<C-W>h"
   endif
endfunction
   
vmap <silent> <F7> :call Groovy_eval_vsplit()<cr>
nmap <silent> <F7> mzggVG<F7>`z
imap <silent> <F7> <ESC><F7>a
map <silent> <S-F7> <C-W>l:bw<cr>
imap <silent> <S-F7> <ESC><S-F7>a
