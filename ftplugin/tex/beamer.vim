" more in after/ftplugin/tex/beamer.vim
if search('\\begin{frame}','cn',1000) > 0 || search('\\frame{','cn',1000) > 0
   let g:Tex_DefaultTargetFormat='pdf'
end
