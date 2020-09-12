function! Mark()
    let mark = toupper(nr2char(getchar()))
    execute "normal! m" . mark
endfunction

function! GoToMark()
    let mark = toupper(nr2char(getchar()))

    let marks = split(execute("marks"),"\n")
    call remove(marks, 0)
    call map(marks, {key, val -> val[1]})

    if index(marks, mark) == -1
        echohl Error
        echo "E20: Mark not set"
        echohl None
        return
    endif

    let pos = getpos("'" . mark)
    if pos[0] > 0
        let win = bufwinid(pos[0])
        if win == -1
            execute "normal! '" . mark
        else
            call win_gotoid(win)
            let pos[0] = 0
            call setpos(".", pos)
        endif
    else
        call setpos(".", pos)
    endif
endfunction

nnoremap <silent> m :call Mark()<CR>
nnoremap <silent> ' :call GoToMark()<CR>
