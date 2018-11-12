set tw=70 fo=troq2 nomodeline
set comments+=n:\|
au BufRead /tmp/mutt* normal :g/^| -- $/,/^$/-1d gg
