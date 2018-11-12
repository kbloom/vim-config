function! s:TokenReplace(line1,line2,orig,replacement)
   let l:cmd=a:line1.",".a:line2."s/\\(\\_W\\|^\\)\\@<=".a:orig."\\_W\\@=/".a:replacement."/gI"
   execute l:cmd
endfunction
command! -range -nargs=+ T call s:TokenReplace(<line1>,<line2>,<f-args>)

function! s:SearchWrapped(pattern)
   let l:pattern=substitute(a:pattern,'\s\+','\\_s\\+','g')
   let @/=l:pattern
   call search(l:pattern)
endfunction
command! -nargs=1 S call s:SearchWrapped("<args>")
nmap , :S 
