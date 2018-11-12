if v:version < 700
   finish
endif

function! OpenFileFromClipboard()
    let fn = @*
    let row = 0
    " Check for grep-style output (/some/file:lineno)
    let info = matchlist(fn, '\([^:]*\):\(\d*\)')
    " Check for Python test traceback format
    if ! len(info)
        let info = matchlist(fn, 'File \"\(.*\)\", line \(\d*\), in')
    endif
    if len(info)
        " Detected file + line number
        let fn = info[1]
        let row = info[2]
    else
        " Revert to trying each whitespace-separated token in turn.
        for s in split(fn)
            if filereadable(s)
                let fn = s
                break
            endif
        endfor
    endif
    " Check if we have a good filename.
    if ! filereadable(fn)
        echo "Could not open" fn
        return
    endif
    " Open file
    exec "e " fn
    " Jump to row
    if row
        exec ":" row
    endif
endfunction
