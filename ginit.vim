set mouse=a

if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Liberation Mono:h10
endif

if exists(':GuiTabline')
    GuiTabline 1
endif

if exists(':GuiPopupmenu')
    GuiPopupmenu 1
endif

if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

set title

colorscheme github


nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
