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
	let backspace = ''
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
	return mapspace . backspace
endfun
imap <C-space> <c-r>=SuperSpace('=')<CR>
au filetype tex imap <C-space> <c-r>=SuperSpace('=')<CR>
au filetype tex imap ;<C-space> <c-r>=SuperSpace('&=')<CR>
" au BufEnter,BufRead,BufNew *.py imap <C-space> <c-r>=SuperSpace('=')<CR>
" imap ee<C-space> <c-r>=SuperSpace('==')<CR>
" imap ff<C-space> <c-r>=SuperSpace('!=')<CR>
" imap nn<C-space> <c-r>=SuperSpace('&&')<CR>
" imap rr<C-space> <c-r>=SuperSpace('\|\|')<CR>
" imap <leader>n<C-space> <c-r>=SuperSpace('&')<CR>
" imap <leader>r<C-space> <c-r>=SuperSpace('\|')<CR>
" imap <leader>j<C-space> <c-r>=SuperSpace('>')<CR>
" imap <leader>k<C-space> <c-r>=SuperSpace('<')<CR>
" imap <leader>d<C-space> <c-r>=SuperSpace('*=')<CR>
" imap <leader>f<C-space> <c-r>=SuperSpace('+=')<CR>
" imap <leader>s<C-space> <c-r>=SuperSpace('-=')<CR>
" imap <leader>/<C-space> <c-r>=SuperSpace('/=')<CR>
" imap fj <c-r>=SuperSpace('>')<CR>
" imap fk <c-r>=SuperSpace('<')<CR>
" imap j<C-space> <c-r>=SuperSpace('>=')<CR>
" imap k<C-space> <c-r>=SuperSpace('<=')<CR>
let g:toggle_imapjoper = 1
fun Imapjoper()
    if g:toggle_imapjoper
        imap jd <c-r>=SuperSpace('+')<CR>
        imap jf <c-r>=SuperSpace('*')<CR>
        imap jt <c-r>=SuperSpace('^')<CR>
        imap js <c-r>=SuperSpace('-')<CR>
        imap jg <c-r>=SuperSpace('%')<CR>
        imap jq \
        imap ja <c-r>=SuperSpace('/')<CR>
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
command ImapJ call Imapjoper()
silent nmap <A-J> :ImapJ<CR>
                
