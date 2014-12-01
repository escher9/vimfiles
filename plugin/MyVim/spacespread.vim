fun! SpaceSpread(normal,positive)
	let cur_pos = getpos('.')
    " if getline('.')[cur_pos[2]-1] == '(' && getline('.')[cur_pos[2]] == ')' 
        " echo 'got it!!!'
        " normal a  
    " endif
    if a:normal
        normal h
    endif
    if a:positive

        normal f)i 
        normal %a 
        call setpos('.',cur_pos)
        if !a:normal
            normal l
        endif
        normal l
    else
        
        normal f)h
        if getline('.')[col('.')-1] == ' ' 
            normal x
            normal %l
            " echo col('.')
            if getline('.')[col('.')-1] == ' ' 
                normal x
            endif
        else
            call setpos('.',cur_pos)
            if !a:normal
                normal l
            endif
            return
        endif
        call setpos('.',cur_pos)
        if a:normal && !a:positive 
            normal h
        endif
    endif
endfun

if has('unix')
	set <M-l>=l
	set <M-h>=h
endif

nmap <silent><M-.> :call SpaceSpread(1,1)<cr>
nmap <silent><M-,> :call SpaceSpread(1,0)<cr>

imap <silent><M-.> <ESC>:call SpaceSpread(0,1)<cr><Left>i
imap <silent><M-,> <ESC>:call SpaceSpread(0,0)<cr><Left>i
" (  <esc>hi(  hi))
" (      h)
" " " " " " " " " " " " " " " " " " " (h (woei>)(        ())(UUUUUUU))
" " " " " " " " " " " " ((woei>)(              ()      )(UUUUUUU))
" " " " " " " " " " " " (           (woei>)(        ())(UUUUUUU) )
" " " " " " " " " " " " ((woei>)(        ())(  UUUUUUU  ))
" " " " " " " " " " " " ( (woei>)(        ())(UUUUUUU) )
" " " " " " " " " " " " ( (woei>)(        () )(UUUUUUU) )
" " " " " " " " " " " " ( (woei>)(        ())(UUUUUUU) )
" " " " " " " " " " " " " ( (          ()                       woei>                                 )(        ())(UUUUUUU) )
" ie + owie +  (woei>oei+)
" ()()   ( weoi>oiew+)     (
" ( oewi>woei+)
" ()                               ()
" ()
" (
" (  `l:)        (UUUUUUUUUU)
" ( ()
" ()( (,f(                                ),) )
" ()fun(weofijweoi+)


fun! InSpace(opt)"{{{
	let acol = match(getline('.'),'(')"{{{
	let bcol = match(getline('.'),')')
	let ccol = col('.')-1
	let l_margin = abs(ccol - acol)
	let r_margin = abs(bcol - ccol) + 1
	let condition2 = (l_margin == r_margin)"}}}

    let a = getline('.')[col('.')-2]"{{{
    let b = getline('.')[col('.')-1]
    let condition1 = (a == '(' && b == ')')"}}}

	if a:opt == 'spread'"{{{
		if condition2
		" if condition2 || condition1
			return "\<space>\<space>\<Left>"
		else
			return "\<space>"
		endif"}}}
	elseif a:opt == 'shrink'"{{{
		if condition2
			return "\<Right>\<C-h>\<C-h>"
		else
			return "\<C-h>"
		endif
	endif"}}}
endfun"}}}
imap <space> <C-R>=InSpace('spread')<CR>
imap <C-h> <C-R>=InSpace('shrink')<CR>

