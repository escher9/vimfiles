let g:pydbgexetoggle_on = 1
fun! PydbgEXEtoggle()
    if g:pydbgexetoggle_on
        mksession! ~/vim_session99
        tabo!
        Dbg .
        let g:pydbgexetoggle_on = 0
        call Pydbgmap()
    else
        Dbg quit
        let g:pydbgexetoggle_on = 1
        " sleep 5m
        call UnPydbgmap()
    endif
    " let g:pydbgexetoggle_on = 1 ? 0 : 1
endfun

fun! UnPydbgmap()
    " exe 'nunmap <C-F5>'
    exe 'nunmap <F2>'
    exe 'nunmap <F3>'
    exe 'nunmap <F4>'
    exe 'nunmap <F5>'
    exe 'nunmap <F6>'
    exe 'nunmap <F7>'
    exe 'nunmap <F8>'
    exe 'nunmap <F9>'
    exe 'nunmap <F10>'
    exe 'nunmap <a-w>'

    exe 'iunmap <F2>'
    exe 'iunmap <F3>'
    exe 'iunmap <F4>'
    exe 'iunmap <F5>'
    exe 'iunmap <F6>'
    exe 'iunmap <F7>'
    exe 'iunmap <F8>'
    exe 'iunmap <F9>'
    exe 'iunmap <F10>'
    " exe 'iunmap <a-w>'
    redraw 
    echo 'reset key and recover session'
    " bwipeout
    source ~/vim_session99
endfun
let g:switchup_on = 0
fun! Switchup()
    if g:switchup_on == 0
        redraw
        echo '[on] holdon watch | Free your Hand, I will hold watch!'
        let g:switchup_on = 1
    else
        redraw
        echo '[off] holdon watch'
        let g:switchup_on = 0
    endif
    if g:pydbgexetoggle_on == 0
        call Pydbgmap()
    endif
endfun

fun! CallDbgpy(number,action)
    
    let watchhold  = ''
    if g:switchup_on && (a:number == 5 || a:number == 6 || a:number == 7)
        let watchhold = '<F4>'
    endif

    exe 'nmap <F' . string(a:number) . '> :Dbg ' . a:action . '<CR>' . watchhold
    exe 'imap <F' . string(a:number) . '> <ESC><f' . string(a:number) . '>'
endfun

fun! Pydbgmap()

    call CallDbgpy(2  , ' down  ' )
    call CallDbgpy(3  , ' up    ' )
    call CallDbgpy(4  , ' watch ' )
    call CallDbgpy(5  , ' run   ' )
    call CallDbgpy(6  , ' into  ' )
    call CallDbgpy(7  , ' over  ' )
    call CallDbgpy(8  , ' break ' )
    call CallDbgpy(9  , ' out   ' )
    call CallDbgpy(10 , ' here  ' )

    " nmap <F4>   :Dbg watch<CR>
    " nmap <F5>   :Dbg run<CR>zz
    " nmap <F6>   :Dbg into<CR>zz
    " nmap <F7>   :Dbg over<CR>zz<F4>
    " nmap <F8>   :Dbg break<CR>
    " nmap <F9>   :Dbg out<CR>zz
    " nmap <F10>  :Dbg here<CR>zz
    " nmap <F12>  :Dbg up<CR>zz
    " nmap <F11>  :Dbg down<CR>zz
    nmap <A-w> :call CopyPasteWord()<cr>
" 
    " imap <F4>  <esc><f4>
    " imap <F5>  <esc><f5> 
    " imap <F6>  <esc><f6> 
    " imap <F7>  <esc><f7> 
    " imap <F8>  <esc><f8> 
    " imap <F9>  <esc><f9> 
    " imap <F10> <esc><f10>
    " imap <F11> <esc><f11>
    " imap <F12> <esc><f12>
    " imap w     <esc>w
    " imap <S-F1> <esc><S-f1>
endfun
fun! CopyPasteWord()
    normal viwy
    sleep 10m
    Dbg watch
    normal o
    normal p
    normal <<
    sleep 10m
    Dbg watch
endfun
au syntax python nmap <C-F5> :call PydbgEXEtoggle()<CR> 
au syntax python nmap <C-F21> :call Switchup()<cr>
