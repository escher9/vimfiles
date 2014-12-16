fun! AllClose(dir)
    let current_window_num = winnr() 
    let cmd_dir = 'wincmd ' . a:dir
    exe cmd_dir
    let to_right_or_not = winnr() 
    while to_right_or_not != current_window_num
        exe 'wincmd q'
        exe cmd_dir
        let to_right_or_not = winnr() 
        if a:dir == 'h'
            let current_window_num -= 1
        endif
    endwhile
endfun
nmap ql :call AllClose('l')<CR>
nmap qh :call AllClose('h')<CR>
