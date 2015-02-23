
fun! PydocCustom()
    let s:cmd = g:trv_grep ." " . g:trv_grepOptions . " " . s:strng . " " . g:trv_dictionary
    let @a = '' 
    let @a = system(s:cmd)
    if @a != ''
        if s:not_exist_translation_window || winnr('$') == 1
            leftabove vnew
            let s:not_exist_translation_window = 0
            let s:sav_winnr = winnr() 

            setlocal modifiable
            setlocal noswapfile
            setlocal buftype=nowrite
            setlocal bufhidden=delete
            setlocal nowrap
            iabclear <buffer>

            
            nmap <buffer><C-space> <C-w>o:call s:CloseGate()<cr>
        else " if exists previous translation window
            " then how to go to that window by number got using bufwinnr
            exe "normal \<C-w>" . s:sav_winnr . "w"
            setlocal modifiable
        endif
        
        " call s:SetLocalKeyMappings()
        exe "%d"
        normal "ap
        setlocal nomodifiable
        let @a = '' 
        exe "normal \<C-w>p"
    endif
    " let s:txt =         "Press 'q' to finish.\n\n"
    " let s:txt = s:txt . "Translation of " . s:strng . ":\n\n"
    " put! = s:txt


    " delete temp-file only if we run under windows
    " unix: on exit of vim this file is deleted automatically
    if has('win32')
        call delete(s:tmpfile) 
    endif
endfun
