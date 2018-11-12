if exists("g:Tex_FoldedSections")
  "Disable a bunch of default TeX bindings that I don't want
  call IMAP ('__', '__', "tex")
  call IMAP ('()', '()', "tex")
  call IMAP ('[]', '[]', "tex")
  call IMAP ('{}', '{}', "tex")
  call IMAP ('^^', '^^', "tex")
  call IMAP ('$$', '$$', "tex")
  call IMAP ('==', '==', "tex")
  call IMAP ('~~', '~~', "tex")
  call IMAP ('=~', '=~', "tex")
  call IMAP ('::', '::', "tex")
  call IMAP ('((', '((', "tex")
  call IMAP ('[[', '[[', "tex")
  call IMAP ('{{', '{{', "tex")
  
  setlocal efm+=%E%f:%l:\ %m

  "don't let BibTex commands get caught up in the last section when 
  "folding
  let g:Tex_FoldedSections = 'bibliographystyle,'.g:Tex_FoldedSections
  let g:Tex_FoldedEnvironments = 'sidewaystable,frame,'.g:Tex_FoldedEnvironments
  "need to manually force refolding right away
  call MakeTexFolds(1)
endif
