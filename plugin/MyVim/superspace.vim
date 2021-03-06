fun! SuperSpace(arg)
	let sav_pos = getpos('.')
	let inquote = 0

    if &ft == 'python' && a:arg == '^'
        let expr = '**'
    else
        let expr = a:arg 
    endif
	normal h
	let [slin,scol] = searchpairpos('(','',')','n')
	let [tlin,tcol] = searchpairpos("'","","'","n")
	let [qlin,qcol] = searchpairpos('"','','"','n')
	normal l

	if [slin,scol] != [0,0]
		let inquote = 1
	endif
	if sav_pos[2] == col('$')
		normal A 
		call setpos('.',sav_pos)
	endif
    let same_line_condition = (slin==line('.')) 
	if inquote && same_line_condition 
		let mapspace = expr
	else
		let mapspace = ' ' . expr . ' '
	endif
	return mapspace
endfun
imap <C-space> <c-r>=SuperSpace('=')<CR>
au filetype tex imap <C-space> <c-r>=SuperSpace('=')<CR>
au filetype tex imap <M-space> <c-r>=SuperSpace('&=')<CR>
let g:toggle_imapjoper = 1
fun! Imapjoper()
    if g:toggle_imapjoper
        imap jd <c-r>=SuperSpace('+')<CR>
        imap jf <c-r>=SuperSpace('*')<CR>
        imap jt <c-r>=SuperSpace('^')<CR>
        imap js <c-r>=SuperSpace('-')<CR>
        imap jg <c-r>=SuperSpace('%')<CR>
        imap jq \
        imap ja <c-r>=SuperSpace('/')<CR>
        imap j<C-Space> <c-r>=SuperSpace('==')<CR>
        echo 'easy type operator j on'
        let g:toggle_imapjoper = 0
    else
        iunmap jd
        iunmap jf
        iunmap jt
        iunmap js
        iunmap jg
        iunmap jq
        iunmap ja
        echo '!!easy type operator j off'
        let g:toggle_imapjoper = 1
    endif
endfun
command! ImapJ call Imapjoper()
silent imap <A-j> <ESC>:ImapJ<CR>i
" silent nmap <A-J> :ImapJ<CR>
