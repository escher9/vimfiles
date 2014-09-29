nmap do :tabnew<CR>
nmap ! :tabclose<CR>

fun! Resize(arg)
	if a:arg == +1
		silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1)', '')
	elseif a:arg == -1
		silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1)', '')
	endif
    redraw!
	if len(&guifont) == 10
		echo '+------------+'
		echo '| ' . &guifont . ' |'
		echo '+------------+'
	else
		echo '+-----------+'
		echo '| ' . &guifont . ' |'
		echo '+-----------+'
	endif
endfun

nnoremap <silent><C-End> :call Resize(+1)<CR>
nnoremap <silent><C-Home> :call Resize(-1)<CR>

"Series Shift"#############################################################
nmap <S-Left>   2<C-w><
nmap <S-Right>  2<C-w>>
nmap <S-Up>     1<C-w>+
nmap <S-Down>   1<C-w>-
nmap `h :leftabove  vnew<CR>
nmap `l :rightbelow vnew<CR>
nmap `k :leftabove  new<CR>
nmap `j :rightbelow new<CR>

"Series double leader"###############################################
map `p :TagbarToggle<CR>
map T :TaskList<CR>jjfT

nmap [p 300<C-w><z0<CR>
nmap [o 300<C-w>>z100<CR>

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
nmap <S-F3> :colorscheme midnight<CR> :call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F4> :colorscheme hybrid<CR>:call keymap#RecoverMarkAndCyan()<cr>

au Bufenter *.\(avl\|mass\|dat\|txt\) set expandtab
nmap ,<TAB> :set expandtab! expandtab?<CR>
nmap du :cd..<CR>

let @R='o   Meeting 13:00 ( 3 Order / 2 Note )o   1r - 

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

nmap `' :ConqueTermSplit python<CR>
nmap `; `l:VimShellCurrentDir<CR>

command! -nargs=1 CS ConqueTermSplit <args>
command! -nargs=1 CV ConqueTermVSplit <args>

fun! EnglishLangua()
    let $LANG='en'
endfun
command! English call EnglishLangua()
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

vmap <A-\> :Align=<CR>

command! H helptags $VIMRUNTIME/../vimfiles/doc

let g:ToggleTransparent = 1
fun! ToggleTransparent()
	if g:ToggleTransparent == 0
		" call libcallnr("vimtweak.dll","SetAlpha",190)
		call libcallnr("vimtweak.dll","SetAlpha",220)
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
	inoremap <C-l><C-j> <C-[>
	vnoremap <C-l><C-j> <C-[>

	inoremap <C-b> <Del>
	" inoremap <C-n> <C-[>^i
	inoremap <C-a> <C-[>$a

	au syntax tex imap <buffer><leader><space>eq <C-[>a \phantom{1}=\phantom{1}
	au syntax tex imap <buffer><leader><space>le <C-[>a \phantom{1}\ge\phantom{1}
	au syntax tex imap <buffer><leader><space>re <C-[>a \phantom{1}\le\phantom{1}
	au syntax tex imap <buffer><leader>le <C-[>a \ge
	au syntax tex imap <buffer><leader>re <C-[>a \le
    au syntax tex imap tt \textrm{
    au syntax tex imap ii \indent\indent
    au syntax tex imap fp \frac{
    au syntax tex imap jjj \\<ESC>o
	" endif

	" fnamemodify
endfun
nmap <C-Delete> :tabo!<CR>

nmap <silent>,pr   :call prgenv#MakePYSMELLSbeReady()<CR>
command! PYSMELLTAGS call prgenv#MakePYSMELLSbeReady()

imap <C-s> <C-[>ggVG
nmap <C-s> ggVG
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
nmap <leader><C-d> :call prgenv#Debug()<CR>
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

nmap \p :set spell!<CR>

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
vmap `" :call AssistEncloseWithAutoclose('"')<CR>
vmap `) :call AssistEncloseWithAutoclose(")")<CR>
vmap `] :call AssistEncloseWithAutoclose("]")<CR>
vmap `> :call AssistEncloseWithAutoclose(">")<CR>
vmap `} :call AssistEncloseWithAutoclose("}")<CR>
vmap `$ :call AssistEncloseWithAutoclose("$")<CR>
vmap `j :call AssistEncloseWithAutoclose(")")<CR>%i
vmap `k :call AssistEncloseWithAutoclose("]")<CR>%i
vmap `l :call AssistEncloseWithAutoclose("}")<CR>%i

imap <M-(> ()<Left>
imap <M-<> <><Left>
imap <M-[> []<Left>
imap <M-{> {}<Left>
imap <M-'> ''<Left>
imap <M-"> ""<Left>
nmap <C-\><C-\> :Align&<CR>

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
	imap <C-l><C-j> <ESC>
	vmap <C-l><C-j> <ESC>
	imap <C-l><C-l> <ESC><C-e>o
	imap <C-l><C-d> <ESC>kA
    imap <C-l>j <ESC>

	" imap qj <M-(>
	" imap ql <M-{>
	" imap qk <M-[>
	" imap qi <M-<>

	imap ;j <M-(>
	imap ;h <M-{>
	imap ;k <M-[>
	" imap ;i <
	" au syntax tex imap <buffer>;f (
	" au syntax tex imap <buffer>;3 {
	" au syntax tex imap <buffer>;g _
	" au syntax tex imap <buffer>;g _
    imap `k <M-">
	imap `j <M-'>
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
    imap `i  I
    imap `o  O

	imap <C-l><C-s> <C-[>^C
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

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader><F4> :set cursorline! cursorcolumn!<CR>

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

set grepprg=zsh\ -c\ 'grep\ -nH\ $*'
map <s-F5> :execute "grep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

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
    vmap <A-q> V"Ayy
    nmap <A-q> "Ayy

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
nmap <leader><C-f> :call EncToggle()<CR>

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
        redraw!
        echo '[OFF] Easy moving OFF!'
        " exe 'nmap j'
    endif
endfun
" nmap <leader><C-w> :call AltMap()<cr>

fun! RemoveVM() " remove carets
    %s/
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

nmap <M-p> :cprevious<CR>
nmap <M-n> :cnext<CR>


nmap <C-S-F11> :RltvNmbr!<CR>

nmap <leader><C-g> :set guifont=*<cr>

imap <C-r><C-r> ♣

fun! DisplayEncFenc()
    redraw!
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

map <A-h> <Left>
imap <A-h> <Left>
map <A-l> <Right>
imap <A-l> <Right>

 map  <A-n> ^
 imap <A-n> <ESC>^
 map  <A-p> $
 imap <A-p> <ESC>$


imap <A-j> <Down>
imap <A-k> <Up>


imap <A-q> <ESC>l
vmap <A-q> <ESC>l
" imap <A-[> <ESC>l
" vmap <A-[> <ESC>l
imap <C-[> <ESC>l
imap <A-d> <Del>
map <A-d> <Del>

nmap vil ^v$h


inoremap <M-`> <C-R>=ListTODO()<CR>
"
func! ListTODO(  )"{{{
	let MyKeyword = [
				\'TODO',
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
				\'ORDER'
				\'DIARY'
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
au filetype vimrc nmap <buffer>[s 141gg:BundleSearch<CR>

nmap vim :w!<CR>,sl:VimFilerCurrentDir<CR>
nmap vmp :verbose map<space>
nmap con :Breakpoint conditional<space>
nmap vp viw

nmap mc :MarkClear<CR>
imap <C-\> <C-R>=strftime("%c %a")<CR><CR>
nmap dp ciw

fun! AddLine()
    exec "normal "
    call append(line('.')-1,'') "or try this ===> m`O<ESC>``
endfun
imap <C-o><C-o> <ESC>:call AddLine()<cr>a

au filetype python imap lj self.


fun! OpenIPython()
    redraw!
    silent call system("start /b ipython qtconsole --ip=127.0.0.1") 
    redraw!
endfun
command! IPythonRun silent call OpenIPython()
" command! IPythonRun silent call system("start /b ipython qtconsole --ip=127.0.0.1")
" command! IPythonRun silent call asynccommand#run("start /b ipython qtconsole --ip=127.0.0.1")
fun! RunConnectIPython()
    IPythonRun
    sleep 3000m
    IPython
endfun
nmap <silent>`<M-i><M-i> :IPythonRun<CR>
" connect
nmap <silent>`<M-i><M-p> :IPython<CR>

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

nmap <M-r> ^f:wv$y
nmap <C-CR> o<esc>k


nmap <C-S-CR> O<esc><C-e>j




function! HandleURL()
    let s:uri = '"'.matchstr(getline("."), '[a-z]*:\/\/[^ \">,;]*').'"'
    let s:browser = '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"'
    if s:uri != '""'
        let s:cmd = s:browser." ".s:uri
        echo s:uri
        echo s:cmd
        call system(s:cmd)
        redraw
    else
        echo "No URI found in line."
    endif
endfunction
map <silent>`u :call HandleURL()<cr>



command! MsModeEnable set guioptions+=a
command! MsModeDisable set guioptions-=a
let g:msmodetoggle = 1
fun! ToggleMsMode()
    redraw!
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
vmap al :Align

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

command! FullScreenToggle call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
nmap <M-\> :FullScreenToggle<CR>
nmap \<M-F1> :cd %:p:h<CR>:silent !start cmd<CR>


command! RecordMyworks e D:\Workspace\[FootPrint]\TODO_LIST.mywork
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

nmap <silent><M-/> V:s/\s\+$//e<CR>V:s/\([^=]*\)\s*=\s*\([^$]*\)/\2 = \1<CR>==:let @/=""<CR>
vmap <silent><M-/> :s/\([^=]*\)\s*=\s*\([^$]*\)/\2 = \1<CR>==:let @/=""<CR>

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

nmap <M-j> o<ESC>k

nmap <M-k> <C-e>O<ESC>j
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
    nmap <buffer>q :call setqflist([])<cr>:q!<CR>:sign unplace *<CR>
endfun
nmap K :call GrepRecursive(0)<cr>
nmap 1K :call GrepRecursive(1)<cr>
nmap 2K :call GrepRecursive(2)<cr>
nmap 3K :call GrepRecursive(3)<cr>
nmap 4K :call GrepRecursive(4)<cr>
" nmap K :exe 'vimgrep /<c-r><c-w>/ **/*'.expand('%:e')<CR>:cw<CR>

nmap <C-space> :sign unplace *<CR>:call setqflist([])<cr>:only!<CR>
nmap <space> :ccl<CR>:sign unplace *<CR>:cd<CR>
silent nmap <A-Delete> :sign unplace *<CR>:call setqflist([])<CR> 
fun! AlternativeK()
    let word = expand('<cword>')
    exe 'help ' . word
endfun
au filetype vim nmap<buffer> ? :call AlternativeK()<cr>
nmap - :q!<CR>
nmap 0 :q!<CR>

nmap _ :vs#<CR>
nmap `_ :sp#<CR>
let g:stretchtoggle = 1 
fun! StretchToggle()
    if g:stretchtoggle
       exe "normal 97>"
    else
       exe "normal ="
       " normal <C-w>= 
    endif
    let g:stretchtoggle = !g:stretchtoggle
endfun
nmap <M-h> :call StretchToggle()<CR>

" call arpeggio#map('n','',1,'fh','<C-w>=')
" call arpeggio#map('n','',1,'fl','9<S-right>')