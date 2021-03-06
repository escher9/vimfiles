fun! QuitAll(dir)
    let current_window_nr = winbufnr(0) 
    let cmd_dir = 'wincmd ' . a:dir
    let starting_window_rel_nr = winnr() 

    " init movement
    exe cmd_dir
    let other_window_nr = winbufnr(0) 

    " while 1
        " if current_window_nr == other_window_nr
            " if starting_window_rel_nr != winnr()
                " exe 'q!'
                " exe cmd_dir
            " else
                " break
            " endif
            " let other_window_nr = winbufnr(0) 
        " elseif current_window_nr != other_window_nr
            " exe 'q!'
            " exe cmd_dir
            " let other_window_nr = winbufnr(0) 
        " else
            " break
        " endif
    " endwhile
    while current_window_nr == other_window_nr
        if starting_window_rel_nr != winnr() && winnr() != 1
            exe 'q!'
            exe cmd_dir
        else
            break
        endif
        let other_window_nr = winbufnr(0) 
    endwhile
    while current_window_nr != other_window_nr && winnr() != 1
        exe 'q!'
        exe cmd_dir
        let other_window_nr = winbufnr(0) 
    endwhile
    exe 'wincmd p'
endfun
" fun! QuitAll(dir)
    " let current_window_num = winnr() 
    " let cmd_dir = 'wincmd ' . a:dir
    " exe cmd_dir
    " let to_right_or_not = winnr() 
    " if a:dir == 'k' || a:dir == 'h'
        " let erased_win_nr = 0 
        " while erased_win_nr < current_window_num-1
            " exe 'q!'
            " exe cmd_dir
            " let erased_win_nr += 1
        " endwhile
    " else
        " while to_right_or_not != current_window_num
            " exe 'q!'
            " " exe 'wincmd q'
            " exe cmd_dir
            " if winnr() < current_window_num
                " exe 'wincmd j'
                " break
            " endif
            " let to_right_or_not = winnr() 
            " if a:dir == 'h' || a:dir == 'k'
                " let current_window_num -= 1
            " endif
        " endwhile
    " endif
" endfun
nmap <C-w><C-l> :call QuitAll('l')<CR>
nmap <C-w><C-h> :call QuitAll('h')<CR>
nmap <C-w><C-j> :call QuitAll('j')<CR>
nmap <C-w><C-k> :call QuitAll('k')<CR>
