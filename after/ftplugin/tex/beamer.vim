if search('\\begin{frame}','cn',1000) > 0 || search('\\frame{','cn',1000) > 0
   let g:Tex_IgnoredWarnings = "LaTeX Font Warning\n" . g:Tex_IgnoredWarnings 
   exec "TCLevel ".(g:Tex_IgnoreLevel + 1)

endif
