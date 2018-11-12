" This defines a "C-style function" text object as something that is delimited
" by braces, but includes the text before the open-brace on the same line (e.g.
" a function declaration, a type name for a struct literal in Go, an if
" statement, or a for loop), and the text after the close-brace on the same line
" (e.g. a trailing comma or semicolon).
vnoremap ac :<C-u>silent! normal! f{va{V<CR>
omap ac :normal vac<CR>


" an inner "C-style function" selects the inside of the braces, even if you were
" somewhere on the line before the open-brace.
vnoremap ic :<C-u>silent! normal! f{vi{<CR>
omap ic :normal vic<CR>

" This defines a "C-style function call" text object as something that is delimited
" by parentheses, but includes the text before the open-paren on the same line (e.g.
" a function name), and the text after the close-paren on the same line " (e.g.
" a trailing comma or semicolon).
vnoremap aC :<C-u>silent! normal! f(va(V<CR>
omap aC :normal vaC<CR>


" an inner "C-style function" selects the inside of the parens, even if you were
" somewhere on the line before the open-paren.
vnoremap iC :<C-u>silent! normal! f(vi(<CR>
omap iC :normal viC<CR>
