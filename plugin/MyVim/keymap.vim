
nmap do :tabnew<CR>
nmap ! :tabclose<CR>

fun! Resize(arg)
	if a:arg == +1
		silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1)', '')
	elseif a:arg == -1
		silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1)', '')
	endif
    redraw
	if len(&guifont) == 10
		echo '| ' . &guifont . ' |'
	else
		echo '| ' . &guifont . ' |'
	endif
endfun

nnoremap <silent><C-End> :call Resize(+1)<CR>
nnoremap <silent><C-Home> :call Resize(-1)<CR>

"Series Shift"#############################################################
nmap <S-Left>   2<C-w><
nmap <S-Right>  2<C-w>>
nmap <M-S-Left>   10<C-w><
nmap <M-S-Right>  10<C-w>>
nmap <S-Up>     1<C-w>+
nmap <S-Down>   1<C-w>-
nmap <M-S-Up>     5<C-w>+
nmap <M-S-Down>   5<C-w>-
nmap `h :leftabove  vnew<CR>
nmap `l :rightbelow vnew<CR>
nmap `k :leftabove  new<CR>
nmap `j :rightbelow new<CR>

"Series double leader"###############################################
map `p :TagbarToggle<CR>
map [t :TaskList<CR>jjfT

" nmap [p 300<C-w><z0<CR>
" nmap [o 300<C-w>>z100<CR>

command! XZ %!xxd
command! XZZ %!xxd -r

let $MYKEYS='~/vimfiles/plugin/MyVim/keymap.vim'
let $MYENV='~/vimfiles/plugin/MyVim/prgenv.vim'
nmap yC v$y
fun! FontSelect(arg)
	" call WorkAroundTransDrag('off')
	if a:arg == 'fix'
		set guifont=Fixedsys:h9
	elseif a:arg == 'mon'
        " set guifont=Inconsolata_for_Powerline:h9
        set guifont=Monaco:h9
	elseif a:arg == 'bit'
		set guifont=Bitstream_Vera_Sans_Mono:h9
	endif
	source $VIMRUNTIME/../vimfiles/plugin/mark.vim
	redraw!
	echo &guifont
	" call WorkAroundTransDrag('on')
endfun
nmap <A-F5> :call FontSelect('fix')<CR>
nmap <A-F6> :call FontSelect('mon')<CR>
nmap <A-F7> :call FontSelect('bit')<CR>

fun! keymap#RecoverMarkAndCyan()
    source ~/vimfiles/plugin/mark.vim
    " source $VIMRUNTIME/../vimfiles/plugin/mark.vim
    " color of the current tag in the status line (bold cyan on black)
    highlight User1 gui=bold guifg=cyan guibg=black
    " color of the modified flag in the status line (bold black on red)
    highlight User2 gui=bold guifg=black guibg=red
endfun
nmap <S-F1> :colorscheme oceandeep<CR>:call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F2> :colorscheme solarized<CR>:set background=light<CR>:call keymap#RecoverMarkAndCyan()<cr>
nmap <leader><S-F2> :colorscheme solarized<CR>:set background=dark<CR>:call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F3> :colorscheme molokai<CR> :call keymap#RecoverMarkAndCyan()<cr>
" nmap <S-F3> :colorscheme midnight<CR> :call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F4> :colorscheme hybrid<CR>:call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F5> :colorscheme default<CR>:call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F6> :colorscheme peachpuff<CR>:call keymap#RecoverMarkAndCyan()<cr>

au Bufenter *.\(avl\|mass\|dat\|txt\) set expandtab
nmap ,<TAB> :set expandtab! expandtab?<CR>
nmap du :cd..<CR><space>
" nmap dU :cd..<CR><space>

fun! Omni_pysmell()
	set omnifunc=pysmell#Complete
endf
fun! Omni_rope()
	set omnifunc=RopeOmni
endf
fun! Omni_python()
	set omnifunc=pythoncomplete#Complete
endf

nmap ,p1 :call Omni_rope()<CR>:set omnifunc<CR>
nmap ,p2 :call Omni_pysmell()<CR>:set omnifunc<CR>
nmap ,p3 :call Omni_python()<CR>:set omnifunc<CR>

fun! ToggleSetList()
	if &list == 0
		set list
		" highlight term=standout ctermbg=Grey guibg=#ffddcc
	else
		set invlist
	endif
endf

nmap Z :call ToggleSetList()<CR>
noremap <C-F10> :let @/=""<CR>

nmap '<A-`> :source ~/vim_session0<cr>
nmap <leader><A-`> :mksession! ~/vim_session0<cr> " Quick write session with F2

nmap \` :Calendar<CR>

fun! RangeCount() range
	echo $range.count
endf
vmap ,b :call RangeCount()<CR>

nmap <M-'> :ConqueTermVSplit python<CR>
" nmap `' :ConqueTermVSplit python<CR>
nmap `; `l:VimShellCurrentDir<CR>
" nmap `; `l:VimShellCurrentDir<CR>

command! -nargs=1 CS ConqueTermSplit <args>
command! -nargs=1 CV ConqueTermVSplit <args>

fun! EnglishLangua()
    let $LANG='en'
endfun
command! English call EnglishLangua()
nmap [<C-e> :English<CR>
nmap <silent>,pf      :call prgenv#SelectOmnifuncPython()<CR>
command! OmniPythonFunc call prgenv#SelectOmnifuncPython()
command! Q close!

vnoremap `p :!python<CR>

fun! SaveBackup()
	let b:backup_count = exists('b:backup_count') ? b:backup_count + 1 : 1
	echo 'Save Backup file : ' . b:backup_count . 'th save!'
	sleep 250m
	return writefile(getline(1,'$'), bufname('%') . '~' . b:backup_count)
endf

fun! RemapPageMoving()
    nmap <F3> <C-PageDown>
    nmap <F2> <C-PageUp>
endfun
fun! WorkAroundTransDrag(arg)
	if a:arg == 'off'
		if g:ToggleTransparent == 1
			call ToggleTransparent()
		endif
	elseif a:arg == 'on'
		if g:ToggleTransparent == 0
			call ToggleTransparent()
		endif
	endif
endfun

vmap <A-\> :Align=<CR><M-0>

command! H helptags $VIMRUNTIME/../vimfiles/doc

let g:ToggleTransparent = 1
fun! ToggleTransparent()
	if g:ToggleTransparent == 0
        " call libcallnr("vimtweak.dll","SetAlpha",180)
        call libcallnr("vimtweak.dll","SetAlpha",225)
		let g:ToggleTransparent = 1
	elseif g:ToggleTransparent == 1
		call libcallnr("vimtweak.dll","SetAlpha",255)
		let g:ToggleTransparent = 0
	endif
endfun
nmap <silent> <A-F8> :call ToggleTransparent()<CR>

function! <SID>StripTrailingWhitespace()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>
vmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>

fun! RecallEscCustomMap()

	inoremap <A-.> <C-[>
	vnoremap <A-.> <C-[>

	inoremap <C-b> <Del>
	" inoremap <C-n> <C-[>^i
	inoremap <C-a> <C-[>$a

	au syntax tex imap <buffer><leader><space>eq <C-[>a \phantom{1}=\phantom{1}
	au syntax tex imap <buffer><leader><space>le <C-[>a \phantom{1}\ge\phantom{1}
	au syntax tex imap <buffer><leader><space>re <C-[>a \phantom{1}\le\phantom{1}
	au syntax tex imap <buffer><leader>le <C-[>a \ge
	au syntax tex imap <buffer><leader>re <C-[>a \le
    au syntax tex imap tt \textrm{
    au syntax tex imap ii \indent
    au syntax tex imap fp \frac{
    au syntax tex imap jjj \\<ESC>o
	" endif

	" fnamemodify
endfun
nmap <C-Delete> :tabo!<CR>

nmap <silent>,pr   :call prgenv#MakePYSMELLSbeReady()<CR>
command! PYSMELLTAGS call prgenv#MakePYSMELLSbeReady()

let g:switch_on = 1
fun! ToggleAutoComplete()
	if g:switch_on && &ft is 'python'
		exe 'iunmap <buffer> <expr> <Space>'
		exe 'iunmap <buffer> <expr> .'
		let g:switch_on = 0
		echo 'Turn off autocomplete'
	elseif !g:switch_on && &ft is 'python'
		imap <buffer> <expr> <Space> python_ftplugin#auto_complete(' ')
		imap <buffer> <expr> . python_ftplugin#auto_complete('.')
		let g:switch_on = 1
		echo 'Turn on autocomplete'
	else
		echo 'nothing changed'
	endif
endfun

nmap `<F7> :call ToggleAutoComplete()<CR>
nmap `<F12> <Plug>ToggleAutoCloseMappings

nmap <silent>,e :call prgenv#Execute($buf.count)<CR>

command! FF echo &ft
nmap <S-F12> :FF<CR>
au Syntax tex nmap<buffer> <silent><A-F21> :silent !del *.aux<CR>
" nmap <leader><C-d> :call prgenv#Debug()<CR>
nmap <silent><A-F9> :call prgenv#CscopePythonSettingOrigin()<CR>
"
nmap <S-F7> <C-[>:syntax on<CR>
nmap <C-F8> :SrcExplToggle<CR>
map <C-F11> :set nu! nu?<CR>
map <C-F12> :set wrap! wrap?<CR>
nmap <A-F10> :e $MYVIMRC<CR>
nmap <A-F11> :e $MYKEYS<CR>
nmap <A-F12> :e $MYENV<CR>

" nmap <A-Right> :cnext<CR>
" nmap <A-Left>  :cprev<CR>
" nmap <A-Down>  :clast<CR>
" nmap <A-Up>    :cfirst<CR>
" nmap <C-Right> :cnfile<CR>
" nmap <C-Left>  :cpfile<CR>
" nmap <C-Down>  :cnewer<CR>
" nmap <C-Up>    :colder<CR>

nmap <C-z> <C-x><Right><Left>
nmap <leader>sp :sp<CR>
nmap <leader>vp :vs<CR>

nmap \s :set spell!<CR>

"{{{
let s:hash_quote = { ')' : ['(',')'],
                    \']' : ['[',']'],
                    \'}' : ['{','}'],
                    \'>' : ['<','>'],
                    \'$' : ['$','$'],
                    \'"' : ['"','"'],
                    \"'" : ["'","'"] }
fun! AssistEncloseWithAutoclose(arg)
    exec 'let @"=""'
    let opening = s:hash_quote[a:arg][0]
    let closing = s:hash_quote[a:arg][1]
    let comm = "normal gvc". opening ."\<C-r>\""
    " if exists('g:autoclose_on')"{{{
        " if g:autoclose_on
            " exe comm
        " else
            " exe comm . closing
        " endif
    " else
    "   exe comm . closing
    " endif"}}}
    exe comm . closing
endfun
au syntax tex vmap <buffer>S c$<C-r>"$<ESC>
vmap `' :call AssistEncloseWithAutoclose("'")<CR>
vmap `; :call AssistEncloseWithAutoclose('"')<CR>
vmap `0 :call AssistEncloseWithAutoclose(")")<CR>
vmap `] :call AssistEncloseWithAutoclose("]")<CR>
vmap `[ :call AssistEncloseWithAutoclose("}")<CR>
vmap `. :call AssistEncloseWithAutoclose(">")<CR>
vmap `4 :call AssistEncloseWithAutoclose("$")<CR>
vmap `j :call AssistEncloseWithAutoclose(")")<CR>%i
" vmap `k :call AssistEncloseWithAutoclose("]")<CR>%i
" vmap `l :call AssistEncloseWithAutoclose("}")<CR>%i

imap <M-0> ()<Left>
imap <M-9> ()<Left>
imap `k ()<Left>
imap <M-4> $$<Left>
imap <M->> <><Left>
imap <M-<> <><Left>
imap <M-]> []<Left>
imap <M-[> {}<Left>
imap <M-'> ''<Left>
imap <M-;> ""<Left>
nmap <C-\><C-\> :Align&<CR>
imap <C-o><C-o> <ESC>o
" imap <C-o><C-o> <ESC><C-e>o

 

" '"<[{()}]>"'
" 'abc'
" "abc"
" (abc)
" [abc]
" {<abc>}


fun! Imapset()
	au syntax tex imap <buffer>wf $
	au syntax tex imap <buffer>// \\<C-j><CR>
	imap <C-o><C-i> <ESC>O
	imap <C-o><C-o> <ESC><C-e>o

	" imap qj <M-(>
	" imap ql <M-{>
	" imap qk <M-[>
	" imap qi <M-<>

	imap ;j <M-9>
	imap ;h <M-[>
	imap ;k <M-]>
	" imap ;i <
	" au syntax tex imap <buffer>;f (
	" au syntax tex imap <buffer>;3 {
	" au syntax tex imap <buffer>;g _
	" au syntax tex imap <buffer>;g _
    " imap `k <M-">
	" imap `j <M-'>
	" imap <C-p> <Del>

	" imap r; :
	" imap `; :
	" imap <tab>; :
	" imap ;n _
	imap ;m _
    imap ;;m __

    imap ;q  Q
    imap ;w  W
    imap ;e  E
    imap ;r  R
    imap ;a  A
    imap ;s  S
    imap ;d  D
    imap ;f  F
    imap ;z  Z
    imap ;x  X
    imap ;c  C
    imap ;v  V
    imap ;t  T
    imap ;g  G
    imap ;b  B
    imap ;y  Y

    imap `u  U
    imap `o  O

	call RecallEscCustomMap()
endfun!
vmap <silent><leader><C-k> :call MakeBufferSpace('visual')<CR>
fun! MakeBufferSpace(mode)
	let col_left  = col("'<")
	let col_right = col("'>")
	let lin_left  = line("'<")
	let lin_right = line("'>")
	let sav_pos   = getpos('.')
	let left  = [lin_left,col_left]
	let right = [lin_right,col_right]
	if a:mode is 'visual'
		call cursor(left)
	elseif a:mode is 'normal'
		call setpos('.',sav_pos)
	endif
	normal i
	if a:mode is 'visual'
		call cursor(right)
	elseif a:mode is 'normal'
		call setpos('.',sav_pos)
	endif
	normal l
	normal a
endfun
fun! SmallerThan(arg)
	if a:arg == 1
		let space = " "
	else
		let space = ""
	endif
	return space . "\>" . space
endfun
fun! HaveOpen()
	let matching = match(getline('.'),'<')
	if matching == -1
		return 0
	else
		return 1
	endif
endfun
call Imapset()

nmap <silent>\x :call prgenv#GetFoo()<CR>:exe "/" . Foo<CR>
nmap <silent>\g :call prgenv#VimgrepEXE()<CR>

fun! SetCursorLine()
    hi CursorLine   cterm = NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    hi CursorColumn cterm = NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    set cursorline! cursorcolumn!
endfun
nnoremap <Leader><F4> :call SetCursorLine()<CR>
" nnoremap <Leader><F4> :set cursorline! cursorcolumn!<CR>

fun! SetTags()

    cd %:p:h
    let s:limit = 3000

let filecnt = 0
python << endpython
import os,vim
import glob

walker = os.walk('./')
files  = 0

limit  = vim.eval("s:limit")
# print limit, 'what'
to_include_set = vim.eval("g:tag_include_ext_set").split()
#to_include_set = '.py','.c'
cnt = 0
#for root,dir,files in walker:
for _,_,files in walker:
    for f in files:
        if any( f.endswith(x) for x in to_include_set):
            cnt += 1
        # filecnt += len([f for f in files if files.endswith('*.py')]) #dir[2] is the list of files in the directory

    if cnt > int(limit):
        print 'warning : too many...'
        break

vim.command('let filecnt=%i'%cnt)

endpython

    if filereadable('./tags')
        silent !del tags
    endif

    " echo filecnt
    if filecnt < s:limit
        let syscmd = 'ctags -R'
        " let syscmd = 'python '. $PYTHON_TOOLS_SCRIPTS . '/ptags.py'
        let sysrun = system(syscmd)
        echo sysrun
        if filereadable('./tags')
            echo 'Exuberant (recursively)Tagging done!  ( with file count : ' . filecnt . ')'
            " sleep 800m
            " redraw
            set tags+=./tags
        else
            echo '(fail -- maybe due to too many files)Tagging missed!(or cancelled)'
        endif
        return
    else
python << endpython
msg    = "[Tagging fail] -- maybe due to too many files more than %i! (or cancelled)" % int(limit)
vim.command!('let s:msg = "%s"'%msg)
endpython
        echo s:msg.'[ok]'
        " sleep 800m
        " redraw
    endif
    " echo 'Sorry! It has no name, name it first!'
endfun

nmap <silent><leader><C-t> :call SetTags()<CR>

" set grepprg=zsh\ -c\ 'grep\ -nH\ $*'
" map <s-F5> :execute "grep /" . expand("<cword>") . "/j **" <Bar> copen<CR>

map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>

" Open and close all the three plugins on the same time
let s:toggle = 0

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

nmap <A-e> :E<CR>

fun! AltMap()
    nmap <A-k> z.5kz.
    nmap <A-j> z.5jz.
    " nmap <A-h> 3b
    " nmap <A-l> 3w

    nmap <A-F12> :tabnew $MYENV<CR>
    " nmap <A-F12> :tabnew C:\Vim\vimfiles\plugin\MyVim\pydbgmap.vim<CR>
    nmap <A-F11> :tabnew $MYKEYS<CR>
    nmap <A-F10> :tabnew $MYVIMRC<CR>

    nmap <A-F5> :call FontSelect('fix')<CR>
    nmap <A-F6> :call FontSelect('mon')<CR>
    nmap <A-F7> :call FontSelect('bit')<CR>
    nmap <A-L> :tabnew $HOME/.ve_favorite<CR>
    nmap <A-1> :mksession! ~/vim_session1<cr> " Quick write session with F2
    nmap <A-2> :mksession! ~/vim_session2<cr> " Quick write session with F2
    nmap <A-3> :mksession! ~/vim_session3<cr> " Quick write session with F2
    nmap <A-4> :mksession! ~/vim_session4<cr> " Quick write session with F2
    nmap <A-7> :source ~/vim_session1<cr>     " And load session with F3
    nmap <A-8> :source ~/vim_session2<cr>     " And load session with F3
    nmap <A-9> :source ~/vim_session3<cr>     " And load session with F3
    nmap <A-0> :source ~/vim_session4<cr>     " And load session with F3
    nmap `<A-k> <F21>gE
    nmap `<A-j> <F21>w
    nmap <A-F1> :cd %:p:h<CR>:silent !start cmd<CR>
    inoremap <A-F1> <ESC><A-F1>
    nmap <A-F21> :call QuitAll()<CR>
    imap <A-F21> <C-[>:call QuitAll()<CR>
    vmap <A-\> :Align=<CR>
    nmap <silent> <A-F8> :call ToggleTransparent()<CR>
    nnoremap <A-`> :silent !start explorer c:\vim\vimfiles\plugin\MyVim<CR>
    silent nmap <A-Delete> :sign unplace *<CR>
    " nmap <A-PageDown> <C-Tab>
    " nmap <A-PageUp> <C-S-Tab>
    inoremap <A-.> <C-[>
    vnoremap <A-.> <C-[>
    " au Syntax tex nmap <silent><A-F21> :silent !del *.aux<CR>
    nmap <silent><A-F9> :call prgenv#CscopePythonSettingOrigin()<CR>
    nmap <A-Right> :cnext<CR>
    nmap <A-Left>  :cprev<CR>
    nmap <A-Down>  :clast<CR>
    nmap <A-Up>    :cfirst<CR>
    nmap <A-e> :E<CR>
    " vmap <A-q> V"Ayy
    " nmap <A-q> "Ayy

    " nmap <A-w> viw
	" imap <A-p> <ESC>pa
endfun

fun! ConfirmClear()
    let a = input('This will blow up your registers data, are you sure? (g)o : ')
    if a == 'g'
        call RegClear()
        redraw
        echo 'Cleaned up registers~ (except windows copy & paste)'
    endif
endfun
fun! RegClear()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
" unlet regs
endfun
nmap ,<C-r> :call ConfirmClear()<cr>
" nmap ,<C-r> :call RegClear()<cr>

vmap <A-q> V"Ayy
nmap <A-q> "Ayy

fun! EncToggle()

    let currentenc = &enc
    if &enc == 'cp949'
        set enc=utf-8
    elseif &enc == 'utf-8'
        set enc=cp949
    endif
    call AltMap()
    redraw
    echo currentenc . ' -> ' . &enc
endfun
nmap <leader><C-g> :call EncToggle()<CR>

nmap <leader><F1> <S-F2><A-F6>
nmap <leader><F2> <S-F3><A-F7>

let g:easy_move_toggle_on = 1
fun! EasyMoveToggle(arg) range
    if a:arg == 0
        let jumpnumber = 5
    else
        let jumpnumber = a:arg
    endif
    let s:anee = 0
    if g:easy_move_toggle_on
        let s:anee = 1
        exe 'nmap j '.(jumpnumber).'<Down>zz'
        exe 'nmap k '.(jumpnumber).'<Up>zz'

        let g:easy_move_toggle_on = 0
        redraw
        echo '[ON] Easy moving ON!'
        exe 'nmap j'
    else
        let s:anee = -1
        unmap j
        unmap k
        let g:easy_move_toggle_on = 1
        redraw
        echo '[OFF] Easy moving OFF!'
        " exe 'nmap j'
    endif
endfun
" nmap <leader><C-w> :call AltMap()<cr>

fun! RemoveVM() " remove carets
    %s/
$//g
endfun
command! RemoveCarets call RemoveVM()

nnoremap <F2> <C-PageUp>
nnoremap <F3> <C-PageDown>

fun! RemapFreqUse()
    nnoremap <F2> <C-PageUp>
    nnoremap <F3> <C-PageDown>
    nnoremap <silent><A-F9> :call prgenv#CscopePythonSettingOrigin()<CR>
endfun
" " au SwapExists * if (!hasmapto(":python debugger.close()<CR>") && !hasmapto("<C-PageUp>") && !hasmapto(":Dbg  into  <CR>"))| call RemapFreqUse() | endif
au CursorHold * if (!hasmapto(":python debugger.close()<CR>") && !hasmapto("<C-PageUp>") && !hasmapto(":Dbg  into  <CR>"))| call RemapFreqUse() | endif

" nmap <M-p> :cprevious<CR>
" nmap <M-n> :cnext<CR>


nmap <C-S-F11> :call RltvNmbrToggle()<CR>
let g:rltv_enable_toggle=1
fun! RltvNmbrToggle()
    if g:rltv_enable_toggle
        RltvNmbr
    else
        RltvNmbr!
    endif
    let g:rltv_enable_toggle=!g:rltv_enable_toggle
endfun

nmap gp :set guifont=*<cr>
" nmap <leader><C-f> :set guifont=*<cr>

imap <C-r><C-r> ♣

fun! DisplayEncFenc()
    redraw
    set enc
    set fenc
endfun
nmap <leader><C-k> :call DisplayEncFenc()<CR>

command! E Explore
cmap kr Breakpoint


"cmap c conditional
imap TT TODO

" cmap go Go
nmap go :Go<space>
nmap gl :GitClearStart<space>
" cmap git G
nmap git :G<C-z>

fun! s:GitCustomtest()
cd %:p:h
python << EOF
import os, vim
git = os.system("git rev-parse")
vim.command('let gittest=%i'%git)
EOF
    return gittest
endfun

" cmap R RltvNmbr
fun! s:GoUpdate(theme)
    let gittest = s:GitCustomtest()
    echo 'gittest ' . gittest
    if gittest == 0
        echo 'now adding all and pushing @github...'
        let a = system("Go " . a:theme)
        echo a
    else
        echo "no git repository"
        return
    endif
endfun
fun! s:Gresetfunc()
    !rm .git/index
    !git reset
endfun
fun! s:GitCustom(opt,repo,theme)
    cd %:p:h
    let s:process = 0
    if a:opt == 'init'
        let z = system("git init")
        echo z
        let a = system("git remote rm origin")
        echo a
        let b = system("git remote add origin git@github.com:escher9/" . a:repo . ".git")
        echo b
        let c = system("git add * --ignore-removal")
        echo c
        let s:process = 1

    elseif a:opt == 'add'
        let to_add = a:repo
        let a = system("git add " . to_add)
        echo a
        let s:process = 1

    elseif a:opt == 'rm'
        let to_remove = a:repo
        let a = system("chmod 777 -R " . to_remove)
        echo a
        let a = system("git rm " . to_remove)  " not repo truely is deleted file name
        echo a
        let b = system("git add * --ignore-removal")
        echo b
        let s:process = 1
    else
        echo "No such command allowed!"
    endif
    if s:process
        let c = system("git commit -m ". a:theme)
        echo c
        let d = system("git push origin master")
        echo d
    endif
endfun
command! -nargs=1 Go call s:GoUpdate(<f-args>)
command! -nargs=* GitCustom call s:GitCustom(<f-args>)
command! -nargs=* MakeGitCustom !makegit <f-args>
command! Greset call s:Gresetfunc()<CR>


fun! s:GitClearStart(repo_name,commit_msg)
    cd %:p:h
    call system('del /q .git')
    call system('git init')
    let @A = system('git remote add origin git@github.com:escher9/'.a:repo_name.'.git')
    call system('git config --global core.excludesfile ~/.gitignore_global --replace-all')
    call system('git add * --all')
    let @A = system('git commit -m "'.a:commit_msg.'"')
    let @A = system('git push origin master')
    rightbelow vnew
    normal "ap
    let @a = ""
endfun
command! -nargs=* GitClearStart call s:GitClearStart(<f-args>)

map <A-h> <Left>
imap <A-h> <Left>
map <A-l> <Right>
imap <A-l> <Right>

" imap <A-j> <Down>
" imap <A-k> <Up>

imap <A-q> <ESC>l
vmap <A-q> <ESC>l
" imap <A-[> <ESC>l
" vmap <A-[> <ESC>l
imap <C-[> <ESC>l
imap <A-d> <Del>
map <A-d> <Del>

nmap vil ^v$h


inoremap <C-\> <C-R>=ListTODO()<CR>
"
func! ListTODO(  )"{{{
	let MyKeyword = [
				\'TODO',
				\'DONE',
				\'NOTE',
				\'SOLVED',
				\'PENDING',
				\'PROBLEM',
				\'FIX',
				\'XXX',
				\'WHAT',
				\'WHY',
				\'WHEN',
				\'WHERE',
				\'ORDER',
				\'DIARY',
				\'OBJECT'
				\]

	call complete(col('.'), MyKeyword)
	return ''
endfunc"}}}
nmap Q :q!<CR>


function! ToggleQuickFix()
    if exists("g:qwindow")
        lclose
        unlet g:qwindow
    else
        try
            lopen 10
            let g:qwindow = 1
        catch
            echo "No Errors found!"
        endtry
    endif
endfunction

nmap <script> <silent> <M-F2> :call ToggleQuickFix()<CR>

nmap <M-w> :w!<CR>





" function! CleverTab()
  " if pumvisible()
    " return "\<C-N>"
  " endif
  " if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    " return "\<Tab>"
  " elseif exists('&omnifunc') && &omnifunc != ''
    " return "\<C-X>\<C-O>"
  " else
    " return "\<C-N>"
  " endif
" endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>


inoremap <expr> <C-d> pumvisible() ? "\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>\<C-n>" : "\<C-d>"
inoremap <expr> <c-u> pumvisible() ? "\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>\<C-p>" : "\<C-u>"


au BufReadPost _vimrc set filetype=vimrc
au BufReadPost _vimrc set syntax=vim
au filetype vimrc nmap <buffer>]p 141gg:BundleSearch<CR><C-w>p

nmap vim :w!<CR>,sl:VimFilerCurrentDir<CR>
nmap vmp :verbose map<space>
nmap con :Breakpoint conditional<space>
nmap vp <C-v>iw
" nmap vp wbviw

nmap mc :MarkClear<CR>
nmap dp ciw

fun! AddLine()
    exec "normal "
    call append(line('.')-1,'') "or try this ===> m`O<ESC>``
endfun
imap <C-o><C-u> <ESC>:call AddLine()<cr><Left>a

au filetype python imap lj self.


fun! OpenIPython()
    " silent call asynccommand#run("start /b ipython qtconsole --ip=127.0.0.1")
    hi MyOrange  guifg  = Orange  guibg=Black
    hi MyCyan    guifg  = Cyan    guibg=Black
    hi MyGreen   guifg  = Green   guibg=Black
    hi MyYellow  guifg  = Yellow  guibg=Black
    hi MyPink    guifg  = Pink    guibg=Black
    hi MyNOTE    guifg  = Black   guibg=Orange
    silent! call system("start /b ipython qtconsole --ip=127.0.0.1")
    let l:total         = 60
    let l:bar           = ""
    redraw
    for i in range(l:total)
        " let l:bar = l:bar . "."
        if i%4         == 1
            let l:bar   = "-"
        elseif i%4     == 2
            let l:bar   = "\\"
        elseif i%4     == 3
            let l:bar   = "|"
        elseif i%4     == 0
            let l:bar   = "/"
        endif
        redraw
        echohl MyCyan | echo "calling..." . l:bar .  " IP[y]:" | echohl None
        sleep 20m
    endfor
    if &ft is 'python'
        redraw
        echohl MyNOTE | echo "Connecting to IPython..." |echohl None
        IPython
        redraw
        echohl MyYellow | echo "Vim is connected up with IPython. " | echohl None
        echohl MyGreen  | echo "(qtconsole --ip=127.0.0.1)"         | echohl None
    endif
endfun
nmap `<M-i><M-i> :call OpenIPython()<CR>
command! I call OpenIPython()<CR>
" " connect
" nmap <silent>`<M-p> :IPython<CR>

fun! OpenNetw()
    botright vs
    E
endfun
nmap [e :call OpenNetw()<cr>
nmap <M-2> :VimFiler<cr>
nmap <M-3> :E<cr>
" nmap [e :botright vs<CR>:E<CR>:nmap <buffer>q :q!<CR><C
nmap \q :q!<CR>

imap <C-o><C-p> <ESC>A
imap <C-o><C-k> <ESC>I


nmap <C-S-CR> O<esc><C-e>j




let s:browser = '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"'
function! HandleURL(in_the_vim)
    let l:nofounduri = 1
    if a:in_the_vim
        let l:uri = matchstr(getline("."), '[a-z]*:\/\/[^ \">,;]*')
        let l:cmd = 'W3m ' . l:uri
        exe l:cmd
        let l:nofounduri = 0
    else
        let l:uri = '"'.matchstr(getline("."), '[a-z]*:\/\/[^ \">,;]*').'"'
        let l:cmd = s:browser." ".l:uri
        silent call asynccommand#run(l:cmd)
        redraw
        let l:nofounduri = 0
    endif
    if l:nofounduri
        echo "No URI found in line."
    endif
endfunction
map <silent>`uu :call HandleURL(0)<cr>
map <silent>`ii :call HandleURL(1)<cr>

" fun! Translate()
    " let s:toknow = expand("<cword>")
    " let s:findword = "https://translate.google.co.kr/?hl=ko\#en/ko/" . s:toknow
    " call HandleURL(s:findword,0)
" endfun
" map <silent>\t :call Translate()<cr>


command! MsModeEnable set guioptions+=a
command! MsModeDisable set guioptions-=a
let g:msmodetoggle = 1
fun! ToggleMsMode()
    redraw
    if g:msmodetoggle
        MsModeEnable
        echo "[MS] copy & paste"
    else
        MsModeDisable
        echo "[VIM] yank & paste"
    endif
    let g:msmodetoggle = !g:msmodetoggle
endfun
nmap [<C-v> :call ToggleMsMode()<cr>

noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

command! ClearTrailing %s/\s\+$//e
fun! ClearTrailingReturn()
    let s:beforepos = getpos('.')
    ClearTrailing
    let s:afterpos = getpos('.')
    if s:beforepos != s:afterpos
        exe "normal "
        echo 'trailing out'
    else
        echo 'no trailing'
    endif
endfun
nmap <M-0> :call ClearTrailingReturn()<cr>
" nmap <M-0> :ClearTrailing<cr><C-o>
"
vmap al :Align = ( ) ,<space>

" fun! SwitchJediNeocomplete()
    " let g:jedi#show_call_signatures = !g:jedi#show_call_signatures
    " let g:jedi#completions_enabled = g:jedi#show_call_signatures
    " if g:jedi#show_call_signatures
        " echo 'jedi assist [on] / NeoComplete{Disable}'
        " NeoCompleteDisable
        " set omnifunc=jedi#completions
    " else
        " echo 'jedi assist [off] / NeoComplete{Enable}'
        " NeoCompleteEnable
        " set omnifunc=pythoncomplete#Complete
    " endif
" endfun

" command! SwitchJediNeocomplete call SwitchJediNeocomplete()

command! StartEclim silent call asynccommand#run("eclimd.bat")
nmap \<M-`> :ProjectTree <C-Z>

command! FullScreenToggle call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 1)
nmap <M-\> :FullScreenToggle<CR>
nmap \<M-F1> :cd %:p:h<CR>:silent !start cmd<CR>


command! RecordMyworks e C:\Users\Administrator\footprint\miscellaneous.mywork
nmap <M-BS> :RecordMyworks<cr>zozz
nmap <M-`> :Unite bookmark<CR>
nmap [<M-`> :UniteBookmarkAdd<CR>
" autoclose toggle
" nmap <F21> :call CoreExample()<CR>
nmap <M--> :NeoCompleteToggle<cr>
nmap `<M-BS> :silent !start explorer /select,%:p<CR>
nmap `. :call PoponOnDotToggle()<CR>
imap `l )<CR>


nmap \f :n <C-Z>
nmap \b :b <C-Z>


" fun! OnDot()
    " " let searchword = getline('.')[col('.')-2]
    " let col_prev = col('.')-2
    " if getline('.')[col_prev] =~#"[a-zA-Z_]"
        " return ".\<C-X>\<C-U>"
    " else
        " return "."
    " endif
" endfun
" fun! OnTab()
    " return "\<C-X>\<C-U>"
" endfun
" let g:popup_on_dot = 1
" fun! PoponOnDotToggle()
    " let g:popup_on_dot = !g:popup_on_dot
    " if g:popup_on_dot
        " inoremap <silent>. <C-R>=OnDot()<CR>
        " " inoremap <silent><TAB> <C-R>=OnTab()<CR>
        " redraw
        " echo 'Popup on dot [ON]'
    " else
        " iunmap .
        " " iunmap <TAB>
        " redraw
        " echo 'Popup on dot [OFF]'
    " endif
" endfun
" inoremap <silent>. <C-R>=OnDot()<CR>

fun! FixPos()
    return getpos('.')
endfun
fun! GrepRecursive(arg)
" fun! GrepRecursive(arg) range
    let l:word = expand('<cword>')
    let l:upper_degree = ''
    for i in range(a:arg)
        let l:upper_degree = l:upper_degree . '../'
    endfor
    let l:ext = expand('%:e')
    if l:ext == ''
        let l:ext = 'py'
    endif
    let l:vimcmd = 'vimgrep /'.l:word.'/ '.l:upper_degree.'**/*.'.l:ext
    exe l:vimcmd
    cw
    " nmap <buffer>q :call setqflist([])<cr>:q!<CR>:sign unplace *<CR>
endfun
nmap K :call GrepRecursive(0)<cr>
nmap 1K :call GrepRecursive(1)<cr>
nmap 2K :call GrepRecursive(2)<cr>
nmap 3K :call GrepRecursive(3)<cr>
nmap 4K :call GrepRecursive(4)<cr>
" nmap K :exe 'vimgrep /<c-r><c-w>/ **/*'.expand('%:e')<CR>:cw<CR>

nmap <C-w><C-space> :sign unplace *<CR>:call setqflist([])<cr>:only!<CR>
nmap <CR> :ccl<CR>:sign unplace *<CR>:cd<CR>
silent nmap <A-Delete> :sign unplace *<CR>:call setqflist([])<CR>
fun! AlternativeK()
    let word = expand('<cword>')
    exe 'help ' . word
endfun
au filetype vim nmap<buffer> ? :call AlternativeK()<cr>
nmap - :q!<CR>
nmap _ :vs#<CR>
nmap `_ :sp#<CR>

let g:stretchtoggle = 1
fun! Exists_RightSplit()
    let thiswin = winnr()
    exe "wincmd l"
    let rightwin = winnr()
    if thiswin == rightwin
        return 0
    else
        exe "wincmd p"
        return 1
    endif
endfun
fun! StretchToggle(dist)
    if g:stretchtoggle
       " if Exists_RightSplit()
       exe a:dist . "wincmd>"
       " endif
       exe a:dist . "wincmd+"
    else
       exe "wincmd="
    endif
    let g:stretchtoggle = !g:stretchtoggle
endfun
nmap <M-2> :call StretchToggle(70)<CR>
nmap <M-1> :call StretchToggle(140)<CR>

" call arpeggio#map('n','',1,'fh','<C-w>=')
" call arpeggio#map('n" ','',1,'fl','9<S-right>')

let g:diffthistoggle=1
fun! DiffToggle()
    if g:diffthistoggle
        diffthis
    else
        diffoff
    endif
    let g:diffthistoggle=!g:diffthistoggle
endfun
nmap <F12> :call DiffToggle()<cr>

nmap <M-n> 17h
imap <M-n> <ESC>17hi
nmap <M-p> 17l
imap <M-p> <ESC>17li
nmap <M-N> ^
imap <M-N> <ESC>^i
nmap <M-P> g_
imap <M-P> <ESC>$i
nmap `<M-n> ^
imap `<M-n> <ESC>^i
nmap `<M-p> g_
imap `<M-p> <ESC>$i

vmap <M-n> 17h
vmap <M-p> 17l
vmap <M-N> ^
vmap <M-P> g_
vmap `<M-n> ^
vmap `<M-p> g_

" fun! Dwi()
    " let cur_word = expand("<cword>")
    " echo cur_word
" endfun
" nmap cp :call Dwi()<cr>
nmap cp dwi<C-p>
" nmap <tab> zz -> same with <C-i> don't use like this!!

nmap <M-;> :

" swap for the equal sign
nmap <silent><M-/> V:s/\s\+$//e<CR>V:s/\([^=]*\)\s*=\s*\([^$]*\)/\2 = \1<CR>==:let @/=""<CR><M-0>V:al<CR>
" s/\([^ =]*\)\([ ]*\)=[ ]*\([^;]*\);/\3 = \1;/<CR>
vmap <silent><M-/> :s/\([^=]*\)\s*=\s*\([^$]*\)/\2 = \1<CR>==:let @/=""<CR><M-0>

" fun SwapLHSandRHS()
    " let
"
" endfun


nmap ,,S o-------------------------------------------------------------------------------------------------------<ESC>k<Home>
nmap ,,s O-------------------------------------------------------------------------------------------------------<ESC>j<Home>

" imap `j <ESC>:call Openr()<cr>
imap `j <M-{><cr><C-o><C-i>
" fun! Openr()
    " startinsert!
" endf
"

fun! HighlightRecover()
    hi DbgCurrentSign term=reverse ctermfg=15 ctermbg=12 guifg=#ffffff guibg=#ff0000
    hi DbgCurrentLine term=reverse ctermfg=15 ctermbg=12 guifg=#ffffff guibg=#ff0000
    hi DbgBreaktSign term=reverse ctermfg=15 ctermbg=10 guifg=#ffffff guibg=#00ff00
    hi DbgBreaktLine term=reverse ctermfg=15 ctermbg=10 guifg=#ffffff guibg=#00ff00
    hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

    " hi airline_c1_inactive ctermfg=239 ctermbg=236 guifg=#4e4e4e guibg=#303030
    " hi airline_y_to_airline_z_bold term=bold cterm=bold gui=bold guifg=#dfff00 guibg=#444444
    " hi airline_y_to_airline_z_red ctermfg=160 guifg=#ff0000 guibg=#444444
    " hi airline_c_to_airline_x_bold term=bold cterm=bold gui=bold guifg=#202020 guibg=#202020
    " hi airline_c_to_airline_x_red ctermfg=160 guifg=#ff0000 guibg=#202020
    " hi airline_a_to_airline_b_bold term=bold cterm=bold gui=bold guifg=#dfff00 guibg=#444444
    " hi airline_a_to_airline_b_red ctermfg=160 guifg=#ff0000 guibg=#444444
    " hi airline_x_to_airline_y_bold term=bold cterm=bold gui=bold guifg=#444444 guibg=#202020
    " hi airline_x_to_airline_y_red ctermfg=160 guifg=#ff0000 guibg=#202020
    " hi airline_b_to_airline_c_bold term=bold cterm=bold gui=bold guifg=#444444 guibg=#202020
    " hi airline_b_to_airline_c_red ctermfg=160 guifg=#ff0000 guibg=#202020
    " hi airline_z_to_airline_warning_red term=bold cterm=bold gui=bold guifg=#df5f00 guibg=#dfff00
    " hi airline_z_to_airline_warning_red ctermfg=160 guifg=#ff0000 guibg=#dfff00
    " hi airline_tabsel_to_airline_tabfill guifg=#dfff00 guibg=#202020
    " hi airline_tabfill_to_airline_tabtype guifg=#ffaf00 guibg=#202020
endf
command! HighlightRecover call HighlightRecover()
nmap ,4 :HighlightRecover<CR>


nmap <M-J> o<ESC>k
nmap <M-K> <C-e>O<ESC>j

let g:current_encoding_toggle = 1
fun! ConvertEncoding(current_encoding_toggle)
    let g:current_encoding_toggle = a:current_encoding_toggle
    if g:current_encoding_toggle
        set enc=utf8
    else
        set enc=cp949
    endif
endfun
nmap <S-space> :call ConvertEncoding(!g:current_encoding_toggle)<CR>:set enc<CR>

nmap <M-[> :bprevious<CR>
nmap <M-]> :bnext<CR>

nmap d. ves

nmap [b :b <C-z>
nmap [f :f <C-z>
fun! CopyAll()
    let sav_line = line('.')
    normal ggVGy
    exe 'normal ' . sav_line . 'gg'
endfun
nmap [<C-r> :call CopyAll()<CR>
map <M-`><M-j> <Plug>(easymotion-eol-j)
map <M-`><M-k> <Plug>(easymotion-eol-k)
" map <M-`><M-j> <Plug>(easymotion-sol-j)
" map <M-`><M-k> <Plug>(easymotion-sol-k)

map <M-`><M-l> <Plug>(easymotion-wl)
map <M-`><M-h> <Plug>(easymotion-bl)

nmap <M-j> 5j
nmap <M-k> 5k
nmap <M-l> 10l
nmap <M-h> 10h
command! AUTOEXEC call asynccommand#run('explorer.exe "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"')
nmap <M-F21> :AUTOEXEC<CR>


fun! SelectAll()
    normal ggVG
    " exec "normal "
endf
nmap [s :call SelectAll()<CR>

nmap <space> z.
" nmap <space> zz5<C-e>
" nmap <BS> zz5<C-e>

nmap [<F5> :so $VIMRUNTIME/syntax/2html.vim<CR>


autocmd filetype python set expandtab
autocmd BufWrite *.py retab


nmap <M-Right> :cnext<CR>
nmap <M-Left> :cprev<CR>

vmap <C-i> :I<CR>

" nmap <ESC> :NeoCompleteToggle<CR>
"
nmap [c C<C-[>
vmap [c C<C-[>


" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nmap gap vip<CR>=
nmap <C-cr> vip<CR>=

nmap gj <C-v>]v:I<CR>
nmap gk <C-v>[v:I<CR>
" nnoremap ,tt ^"=strftime("%c")<CR>Po
" nnoremap ,tt ^"=strftime("%c")<CR>Po
" nnoremap ,tt :echo strftime("%c")<CR>
" nmap [<M-\> <C-R>=strftime("%c %a")<CR><CR>
imap <M-\> <C-R>=strftime("%c %a")<CR><CR>
nmap [<M-\> ^"=strftime("%c %a")<CR>Po

let g:show_time_on = 0
augroup ShowTime
    au CursorHoldI,CursorMovedI,CursorMoved,CursorHold * if g:show_time_on | echo strftime("%c %a") | endif
augroup END     
fun! ShowTimeToggle()
    let g:show_time_on = !g:show_time_on
    if !g:show_time_on
        redraw!
    endif
endfun
nmap T :silent call ShowTimeToggle()<cr>

let g:MakeEclimToggleOn = 1 
fun! EclimToggle()
    if g:MakeEclimToggleOn
        EclimEnable
        echo '(Eclim Enabled) ... you can open projects.'
    else
        EclimDisable
        echo '(Eclim Disabled) ... but you can still open projects!'
    endif
    let g:MakeEclimToggleOn = !g:MakeEclimToggleOn
endfun
nmap tj :call EclimToggle()<CR>

nmap 0 :q!<cr>

command! EX cd C:\Program Files\Dassault Systemes\B21\win_b64\code\command
command! D cd C:\Users\Administrator\Desktop
command! W cd C:\Workspace

nmap <C-space> q:

nmap <M-space> :q!<CR>
imap <M-space> <ESC>:q!<CR>



imap <C-l> -><C-x><C-o>

let g:findkeytoggled = 1
fun! FindKeyToggle()
    if g:findkeytoggled
        nmap ; :r!
        echo '; => ;r!'
        let g:findkeytoggled = 0
    else
        nunmap ;
        echo '; => (next search)'
        let g:findkeytoggled = 1
    endif
endfun

nmap `; :call FindKeyToggle()<cr>
