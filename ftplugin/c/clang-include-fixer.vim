"Normal mode.
nnoremap <leader>cf :let g:clang_include_fixer_query_mode=0<cr>:py3f /usr/lib/clang-include-fixer/clang-include-fixer.py<cr>
"Query mode.
nnoremap <leader>qf :let g:clang_include_fixer_query_mode=1<cr>:py3f /usr/lib/clang-include-fixer/clang-include-fixer.py<cr>
