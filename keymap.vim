" mapc
nmap do :tabnew<CR>
nmap ! :tabclose<CR>

nmap cdd :cd %:p:h<CR>:cd<CR>
nmap cdc :cd<CR>
nmap cdp :cd $DRIVE/Workspace/Python/Project1<CR>:cd<CR>
fun! PutString()
	exe "normal i$$"
endfun

"configuration"#######################################################
nmap <leader>zo ggvGzoM
nmap <leader><leader>zo ggvGzoggvGzoggM

"resource mark.vim"
nmap <leader>,r :source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>

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
" nnoremap <silent><C-End> :call Resize(+1)<CR>:call SizeDisp()<CR>
" nnoremap <C-End> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1)', '')<CR>:echo &guifont<CR>
" \ :set guifont<CR>
nnoremap <silent><C-Home> :call Resize(-1)<CR>
" nnoremap <silent><C-Home> :call Resize(-1)<CR>:call SizeDisp()<CR>
" nnoremap <C-Home> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1)', '')<CR>:echo &guifont<CR>

"Series Alt"#############################################################

"Series Shift"#############################################################
nmap <S-Left>   2<C-w><
nmap <S-Right>  2<C-w>>
nmap <S-Up>     1<C-w>+
nmap <S-Down>   1<C-w>-
nmap <leader>,s ko---------------------------------------------------------------------------------<CR><ESC>dd
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove  new<CR>
nmap <leader>sj :rightbelow new<CR>

"Series double leader"###############################################
"for pyclewn debug for C file (use :Pyclewn pdb<CR> for python debug)
nmap <leader><leader>1 :o ./doc/TODO_LIST.txt<CR>
nmap <leader><leader>2 :o ./doc/READING.txt<CR>
nmap <leader><leader>3 :o ./doc/REPORT.txt<CR>
map `p :TagbarToggle<CR>
" map `p :TagbarToggle<CR>:NERDTreeToggle<CR><C-w>l
" map `p :TlistToggle<CR>
map T :TaskList<CR>jjfT

nmap [p 300<C-w><z0<CR>
nmap [o 300<C-w>>z100<CR>
nmap <M-k> z.5kz.
nmap <M-j> z.5jz.
" nmap <A-K> z.15kz.
" nmap <A-J> z.15jz.
" not work!

nmap d0 ,,3,,2,,1
nmap d9 ,`<C-h><C-i>d0<C-i>M

nmap <A-h> 3b
nmap <A-l> 3w


command! XZ %!xxd
command! XZZ %!xxd -r


nmap <S-ESC> :TMiniBufExplorer<CR>
let $MYKEYS='~/vimfiles/plugin/MyVim/keymap.vim'
let $MYENV='~/vimfiles/plugin/MyVim/prgenv.vim'
" let $MYKEYS='C:\Vim\vimfiles\plugin\MyVim\keymap.vim'
" let $MYENV='C:\Vim\vimfiles\plugin\MyVim\prgenv.vim'
" nmap <C-F7> :tabnew $MYENV<CR>
nmap yC v$y
nmap ,/? :set guifont<CR>
" nmap <F1> :set guifont=Fixedsys:h11<CR>:colorscheme oceandeep<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
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
" nmap <F2> :set guifont=Fixedsys:h11<CR>:colorscheme mydarkblue<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" nmap <F3> :set guifont=Fixedsys:h11<CR>:colorscheme zellner<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?

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
nmap <S-F3> :colorscheme midnight<CR> :call keymap#RecoverMarkAndCyan()<cr>
nmap <S-F4> :colorscheme hybrid<CR>:call keymap#RecoverMarkAndCyan()<cr>
" nmap <S-F5> :colorscheme slate<CR>:call keymap#RecoverMarkAndCyan()<cr>
" nmap <S-F1> :set guifont=Monaco:h12<CR>:colorscheme oceandeep<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" nmap <S-F2> :set guifont=Monaco:h12<CR>:colorscheme darkblue<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" nmap <S-F3> :set guifont=Monaco:h12<CR>:colorscheme zellner<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" nmap <S-F4> :set guifont=fixedsys:h11<CR>:colorscheme peachpuff<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" nmap <S-F5> :set guifont=Monaco:h12:w6.5<CR>:colorscheme darkblue<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" nmap <S-F6> :set guifont=Bitstream\ Vera\ Sans\ Mono:h13<CR>:colorscheme darkblue<CR>:source $VIMRUNTIME/../vimfiles/plugin/mark.vim<CR>,/?
" set guifont=Monaco:h12:w6.5

map ,a`  :set guifont<CR>
map ,a1 :runtime! syntax/ruby.vim<CR>
map ,s1 :runtime! syntax/perl.vim<CR>
map ,s2 :runtime! syntax/python.vim<CR>
map ,s3 :runtime! syntax/c.vim<CR>

au Bufenter *.\(avl\|mass\|dat\|txt\) set expandtab
nmap ,<TAB> :set expandtab! expandtab?<CR>
" nmap E :e!<CR>
nmap du :cd..<CR>

nmap ,<F1> :tabnew C:\Documents and Settings\escher9\.ve_favorite<CR>
" nmap ,<F1> :tabnew C:\Documents and Settings\Administrator\.ve_favorite<CR>

" gvim prompt trigger ??제?莫?(redraw+function)(.vimrc)[1106]
fun! OpenVE()
	" normal ,.r
	if g:ToggleTransparent == 1
		call ToggleTransparent()
		let again = 1
	endif
	VE
	if again
		call ToggleTransparent()
	endif
	" simalt ~x
endf

fun! CD1()
	cd $DRIVE/Workspace/Python/Project1
	redraw
endf
fun! CD2()
	cd $DRIVE/Workspace/FlightControl
	redraw
endf
fun! CD3()
	cd $DRIVE/Workspace/EfficientPath
	redraw
endf
fun! CD4()
	cd $DRIVE/Workspace/MissileGuidance
	redraw
endf
fun! CD5()
	cd $DRIVE/Workspace/DataVis
	redraw
endf

nmap <silent><leader>`` :VE<CR><CR>:cd<CR>
" nmap <leader>`` :call OpenVE()<CR><CR>:cd<CR>

nmap <leader>11 :call CD1()<CR>:cd<CR>
nmap <leader>1` ,11,``

nmap <leader>22 :call CD2()<CR>:cd<CR>
nmap <leader>2` ,22,``

nmap <leader>33 :call CD3()<CR>:cd<CR>
nmap <leader>3` ,33,``

nmap <leader>44 :call CD4()<CR>:cd<CR>
nmap <leader>4` ,44,``

nmap <leader>55 :call CD5()<CR>:cd<CR>
nmap <leader>5` ,55,``

nmap du :cd ..<CR>:cd<CR>

let @R='o   Meeting 13:00 ( 3 Order / 2 Note )o   1r -    2r -    3r -    4r -    5r - kkkkl'


fun! Set_font_Sans()
	set guifont=Bitstream_Vera_Sans_Mono:h12
endf
fun! Set_font_monaCo()
	set guifont=Monaco:h12
endf
fun! Set_font_Fixed()
	set guifont=Fixedsys:h12
endf

nmap ,fe :call Set_font_Sans()<CR>,mw
nmap ,fw :call Set_font_monaCo()<CR>,mw
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

nmap \rr :cd %:h<CR>:RopeOpenProject<CR>

nmap ,3 :cd %:h<CR>:w<CR>:!C:\Python33\python %<CR>

" nmap ,pr :cd %:p:h<CR>:!cd<CR>:!copy C:\pytags<CR>:!pysmell . -x *<CR>
nmap <A-L> :tabnew $HOME/.ve_favorite<CR>
fun! ToggleSetList()
	if &list == 0
		set list
		" highlight term=standout ctermbg=Grey guibg=#ffddcc
	else
		set invlist
	endif
endf

nmap Z :call ToggleSetList()<CR>
noremap <C-F10> :set hlsearch! hlsearch?<CR>

nmap '<A-`> :source ~/vim_session0<cr> 
nmap '<A-1> :source ~/vim_session1<cr> 
nmap '<A-2> :source ~/vim_session2<cr> 
nmap '<A-3> :source ~/vim_session3<cr> 
nmap '<A-4> :source ~/vim_session4<cr> 
nmap <leader><A-`> :mksession! ~/vim_session0<cr> " Quick write session with F2 
nmap <leader><A-1> :mksession! ~/vim_session1<cr>                               
nmap <leader><A-2> :mksession! ~/vim_session2<cr>                               
nmap <leader><A-3> :mksession! ~/vim_session3<cr>                               
nmap <leader><A-4> :mksession! ~/vim_session4<cr> " Quick write session with F2 

nmap \\\ :Calendar<CR>
nmap \\<bs> \\\Q

nmap `<A-k> <F21>gE
nmap `<A-j> <F21>w
nmap \\w <C-w>=         " even windows
" nmap == <C-w>=
imap `0 <C-[>:q!<CR>
nmap `0 :q!<CR>
fun! RangeCount() range
	echo $range.count
endf
vmap ,b :call RangeCount()<CR>

nmap `' :ConqueTermSplit python<CR>
nmap `; :ConqueTermVSplit cmd<CR>
imap `q <C-[>:q!<CR>

command! -nargs=1 CS ConqueTermSplit <args>
command! -nargs=1 CV ConqueTermVSplit <args>

nmap \= 1GVG=

" copy like windows method
nmap <C-c> "*yy
vmap <C-c> "*yy

" paste like windows method
" nmap <A-q> "*p
" nmap <A-v> "*p
vmap <C-v> "*p
imap <C-v> <ESC>"*p

" nmap 11 ^w
" nmap 99 $b
nmap <A-`> :silent !start explorer /select,%:p<CR>
nmap <A-F1> :cd %:p:h<CR>:silent !start cmd<CR>
inoremap <F1> <ESC><F1>
inoremap <A-F1> <ESC><A-F1>
nmap <silent>,pf      :call prgenv#SelectOmnifuncPython()<CR>
command! OmniPythonFunc call prgenv#SelectOmnifuncPython()
" nmap ,pf :echo &omnifunc<CR>

func! ClearBuzzAndIdent()
	let save_pos = getpos('.')
	normal ggVG==

	call Flick()

	call setpos('.',save_pos)
endf

nmap `<space> :call ClearBuzzAndIdent()<CR>
imap `<space> <C-[>`<space>

fun! Flick()
	normal @p
endf

command! Q close!

vnoremap `p :!python<CR>

fun! SaveBackup()
	let b:backup_count = exists('b:backup_count') ? b:backup_count + 1 : 1
	echo 'Save Backup file : ' . b:backup_count . 'th save!'
	sleep 250m
	return writefile(getline(1,'$'), bufname('%') . '~' . b:backup_count)
endf

" nmap <leader>ww :call SaveBackup()<CR>:w!<CR>:echo 'Non-assertive save'<CR>
" imap wwww <C-[><leader>ww

fun! WriteOn(arg) range
	" echo a:arg
	" echo a:arg
	" echo a:arg
	if a:arg == 2
		w! ++enc=chinese
		" echo '[ CAUTION ] : Assertive Save!'
		" echo 'Simple Chinese encode written'
	elseif a:arg == 1
		w! ++enc=cp949
		" echo '[ CAUTION ] : Assertive Save!'
		" echo 'Korean(cp949) encode written'
	else
		w!
		" echo '[ CAUTION ] : Assertive Save!'
		" echo 'no change'
		" set enc
	endif
	" sleep 250m
endfun
" nmap W :w!<CR>
nmap <leader>w :w!<CR>

fun! RemapPageMoving()
    nmap <F3> <C-PageDown>
    nmap <F2> <C-PageUp>
endfun
" nmap <silent>W :w!<CR>:redraw<CR>:call RemapPageMoving()<CR>
" nmap <leader>w :call WriteOn($buf.count)<CR>
" nmap W :call WriteOn($buf.count)<CR><CR>

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

fun! QuitAll()
	call WorkAroundTransDrag('off')
	" silent xall!
	silent qa! " stronger than xall
endf

nmap <A-F21> :call QuitAll()<CR>
imap <A-F21> <C-[>:call QuitAll()<CR>
"
" nmap <A-F12> :xall<CR>
" nmap <A-F12> :qa!<CR>
" imap <A-F12> <C-[>:qa!<CR>

fun! Save()
	let g:save_pos = getpos('.')
endf
fun! Restore()
	call setpos('.',g:save_pos)
endf
nmap ,s, :call Save()<CR>
nmap ,\, :call Restore()<CR>
let @p=",s,ggVG,\,"

" nmap <space> @p
" vmap <space> ==
" nmap ,rr :source $MYVIMRC<CR>
vmap <A-\> :Align=<CR>
" Open and close all the three plugins on the same time



command! H helptags $VIMRUNTIME/../vimfiles/doc

let g:ToggleTransparent = 1
fun! ToggleTransparent()
	if g:ToggleTransparent == 0
		" call libcallnr("vimtweak.dll","SetAlpha",190)
		call libcallnr("vimtweak.dll","SetAlpha",200)
		let g:ToggleTransparent = 1
	elseif g:ToggleTransparent == 1
		call libcallnr("vimtweak.dll","SetAlpha",255)
		let g:ToggleTransparent = 0
	endif
endfun
nmap <silent> <A-F8> :call ToggleTransparent()<CR>

silent nmap <A-Delete> :sign unplace *<CR>

" nnoremap <A-`> :silent !start explorer c:\vim\vimfiles\plugin\MyVim<CR>

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

" no more usable -> minibufexpl"
nmap <A-PageDown> <C-Tab>
nmap <A-PageUp> <C-S-Tab>
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
" call RecallEscCustomMap()
" au BufNewFile,BufRead,Bufenter,BufReadPost,BufWrite,BufWritePost * call RecallEscCustomMap()
nmap <C-Insert> :only!<CR>
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
" nmap <C-F12> :call ToggleAutoCloseMathInLaTeX()<CR><Plug>ToggleAutoCloseMappings
nmap `<F12> <Plug>ToggleAutoCloseMappings
fun! RemindMapping()
	echo 'map   < F12   > : set wrap! wrap?<CR>'
	echo 'map   < F11   > : set nu! nu?<CR>'
	echo 'nmap  < F1    > : silent !start explorer /select,%:p<CR>'
	echo 'nmap  < A-F1  > : silent !start cmd<CR>'
	echo 'nmap  < A-`   > : silent !start explorer c:\vim\vimfiles\plugin<CR>'
	echo 'nmap <S-F7> <C-[>:syntax on<CR>'

	echo 'inoremap <C-j> <C-[>:call EscapeSmart()<CR>a'
	echo 'inoremap <C-l> <C-[>'
	echo 'vnoremap <C-l> <C-[>'
	echo 'inoremap <C-o> <S-bs>'
	echo 'inoremap <C-n> <C-[>^i'
	echo 'inoremap <C-h> <bs>'
	echo 'inoremap <C-u> <del>'
	echo 'inoremap <space>eq <C-[>a = '
	echo 'inoremap <space>ei <C-[>a != '
	echo 'inoremap <space>ee <C-[>a == '
	echo 'inoremap <space>rr <C-[>a <'
	echo 'inoremap <space>ll <C-[>a >'
	echo 'inoremap <space>er <C-[>a <='
	echo 'inoremap <space>el <C-[>a >='
	echo 'inoremap <space>e` <C-[>a =~ '

endfun!          
nmap <leader>help :call RemindMapping()<CR>

nmap [q :let @e=''<CR>qe
nmap ,q @e
nmap D viwd
nmap Y wbve<C-c>
" nmap ,4 :tabnew ./doc/email.txt<CR>

" vmap si s(i_<esc>f)
" au FileType mako vmap si s"i${ _(<esc>2f"a) }<esc>
" // The switch of the Source Explorer                                         "
" nmap cc :call togglelang#ToggleLanguage("<args>")<CR>
""nmap cc :call togglelang#ToggleLanguage($buf.count)<CR>

nmap <silent>,e :call prgenv#Execute($buf.count)<CR>

command! FF echo &ft
nmap <S-F12> :FF<CR>
" nmap <silent><F5> :make<CR>
" nmap <silent><F5> :call prgenv#Make()<CR>
au Syntax tex nmap <silent><A-F21> :silent !del *.aux<CR>
" nmap <silent>tm :call prgenv#TagMake()<CR>cdc
" nmap <silent>ts :call prgenv#TagMake()<CR>cdc
" nmap ,tags :call prgenv#TagMake()<CR>cdc
nmap <leader><C-d> :call prgenv#Debug()<CR>
nmap <silent><A-F9> :call prgenv#CscopePythonSettingOrigin()<CR>
" nmap <A-F9> :call prgenv#CscopePythonSettingOrigin($buf.count)<CR>
" map <C-F9> :call CscopePythonSettingVariation()<CR>
"
nmap <S-F7> <C-[>:syntax on<CR>
nmap <C-F8> :SrcExplToggle<CR>
nnoremap <C-F9> :b <C-Z>
map <C-F11> :set nu! nu?<CR>
map <C-F12> :set wrap! wrap?<CR>
nmap <A-F10> :tabnew $MYVIMRC<CR>
nmap <A-F11> :tabnew $MYKEYS<CR>
nmap <A-F12> :tabnew $MYENV<CR>


" nmap ti f)i
" nmap tdi f)hdi(i
" nmap to F)i
" nmap tdo F)hdi(i

nmap <A-Right> :cnext<CR>
nmap <A-Left>  :cprev<CR>
nmap <A-Down>  :clast<CR>
nmap <A-Up>    :cfirst<CR>
nmap <C-Right> :cnfile<CR>
nmap <C-Left>  :cpfile<CR>
nmap <C-Down>  :cnewer<CR>
nmap <C-Up>    :colder<CR>

map <A-J> j<C-e>
map <A-K> k<C-y>
nmap <C-z> <C-x><Right><Left>
nmap <leader>sp :sp<CR>
nmap <leader>vp :vs<CR>

nmap \p :set spell!<CR>

"{{{
let s:hash_quote = { ')' : ['(',')'], 
                    \']' : ['[',']'], 
                    \'}' : ['{','}'],  
                    \'"' : ['"','"'], 
                    \"'" : ["'","'"] }
fun! AssistEncloseWithAutoclose(arg)
    exec 'let @"=""'
    let opening = s:hash_quote[a:arg][0] 
    let closing = s:hash_quote[a:arg][1] 
    let comm = "normal gvc". opening ."\<C-r>\""
    if exists('g:autoclose_on')
        if g:autoclose_on
            exe comm
        else
            exe comm . closing
        endif
    else
        exe comm . closing
    endif
endfun
" au syntax tex vmap <buffer>S $"}}}
" au syntax tex vmap <buffer><M-s> c$<C-r>"$<ESC>h
au syntax tex vmap <buffer>S c$<C-r>"$<ESC>
" vmap ' c'<C-r>"<ESC>
" vmap " c"<C-r>"<ESC>
" vmap `' c"<C-r>"<ESC>
vmap ' :call AssistEncloseWithAutoclose("'")<CR>
vmap " :call AssistEncloseWithAutoclose('"')<CR>
" vmap <space>] c[ <C-r>"] <ESC>%%
" vmap <space>) c( <C-r>") <ESC>%%
" vmap <space>} c{ <C-r>"} <ESC>%%
vmap ) :call AssistEncloseWithAutoclose(")")<CR>
vmap ] :call AssistEncloseWithAutoclose("]")<CR>
vmap } :call AssistEncloseWithAutoclose("}")<CR>
" vmap ) c(<C-r>")<ESC>%%
" vmap } c{<C-r>"}<ESC>%%
" vmap ] c[<C-r>"]<ESC>%%


vmap `j :call AssistEncloseWithAutoclose(")")<CR>%i
vmap `k :call AssistEncloseWithAutoclose("]")<CR>%i
vmap `l :call AssistEncloseWithAutoclose("}")<CR>%i
" vmap `j c(<C-r>"<ESC>%i
" vmap `k c[<C-r>"<ESC>%i
" vmap `l c{<C-r>"<ESC>%i

vmap `i c<<C-r>"><ESC>F<i

nmap <C-\><C-\> :Align&<CR>

fun! Imapset()
"{{{
	au syntax tex imap <buffer>wf $
	au syntax tex imap <buffer>// \\<C-j><CR>
	imap <C-o><C-o> <ESC>O
	imap <C-l><C-j> <ESC>
	vmap <C-l><C-j> <ESC>
	imap <C-l><C-l> <ESC><C-e>o
	imap <C-l><C-d> <ESC>kA
    imap <C-l>j <ESC>

	imap qj (
	imap ql {
	imap qk [
	imap qi <"}}}

	imap ;j (
	imap ;h {
	imap ;k [
	" imap ;i <
	" au syntax tex imap <buffer>;f (
	" au syntax tex imap <buffer>;3 {
	" au syntax tex imap <buffer>;g _
	" au syntax tex imap <buffer>;g _
    imap `k "
	imap `j '
          
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
vmap <silent><C-k> :call MakeBufferSpace('visual')<CR>
" nmap <silent><C-k> :call MakeBufferSpace('normal')<CR>
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
	" if getline('.') =~ '<'
	" return space . "\>\>" . space
	" else
	return space . "\>" . space
	" endif
endfun
fun! HaveOpen()
	let matching = match(getline('.'),'<')
	if matching == -1
		return 0
	else         
		return 1
		" if matching < col('.') - 1
		" return 1
		" else
		" return 0
		" endif
	endif
endfun
call Imapset()
map \s <leader>\swp<C-[>h 
map \o <leader>\rwp

" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent>\x :call prgenv#GetFoo()<CR>:exe "/" . Foo<CR>
nmap <silent>\g :call prgenv#VimgrepEXE()<CR>

" fun! SmoothScroll(up)
	" if a:up
        " let scrollaction="\<C-e>"
    " else
        " let scrollaction="\<C-y>"
    " endif
    " exec "normal! " . scrollaction
    " redraw
    " let counter=1
    " while counter < &scroll
        " let counter+=1
        " " sleep 10m
		" redraw
        " exec "normal! " . scrollaction
    " endwhile
	" normal M
" endfunction
" 
" nnoremap <silent><C-U> :call SmoothScroll(0)<CR>
" nnoremap <silent><C-D> :call SmoothScroll(1)<CR>
"
" inoremap <silent><C-U> <Esc>:call SmoothScroll(0)<CR>i
" inoremap <silent><C-D> <Esc>:call SmoothScroll(1)<CR>i
" nmap <a-[> <C-PageUp>
" nmap <a-]> <C-PageDown>

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader><F4> :set cursorline! cursorcolumn!<CR>
" nmap <C-p> <C-x><C-]>

" nmap <C-i> ciw


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

# cnt = 0
# os.chdir('.')
# for file in glob.glob("*.py"):
# cnt += 1
# 
# 
# if cnt > int(limit): 
# print 'warning : too many...'
# break

# vim.command!('let filecnt=%i'%cnt)

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

" let $ZSHPATH='C:\tools\zsh\bin\'
set grepprg=zsh\ -c\ 'grep\ -nH\ $*'
map <s-F5> :execute "grep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>

" Open and close all the three plugins on the same time 
let s:toggle = 0
fun! TrinityOn()
    tabo!
    " TrinityToggleAll

    cd %:p:h
    if s:toggle == 0
        call SetTags()
    else
        let s:toggle = 0
    endif
    " TrinityToggleAll
    TrinityToggleNERDTree
    TrinityToggleSourceExplorer
    TlistToggle
    " TrinityToggleTagList
    let s:toggle = s:toggle + 1
endfun

" nmap <C-F8>   :call TrinityOn()<CR>
" 
" " Open and close the srcexpl.vim separately 
" nmap <C-F9>   :TrinityToggleSourceExplorer<CR> 
" 
" " Open and close the taglist.vim separately 
" nmap <C-F10>  :TrinityToggleTagList<CR> 


" nmap <A-K> <C-PageUp>
" nmap <A-J> <C-PageDown>
" nmap <C-9> <C-PageUp>
" nmap <C-0> <C-PageDown>

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

nmap <A-e> :E<CR>

fun! AltMap()
    nmap <A-k> z.5kz.
    nmap <A-j> z.5jz.
    nmap <A-h> 3b
    nmap <A-l> 3w

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
    map <A-J> j<C-e>
    map <A-K> k<C-y>
    nmap <A-e> :E<CR>
    vmap <A-q> V"Ayy
    nmap <A-q> "Ayy

    nmap <A-w> viw
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

" nmap ;; zz

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

" nmap <tab><tab> <C-PageUp> 
" nmap <S-tab>    <C-PageDown>   
" nmap <C-tab>    <C-PageDown>   


nmap <leader><F1> <S-F2><A-F6>
nmap <leader><F2> <S-F3><A-F7>

" nmap <A-k> z.5kz.
" nmap <A-j> z.5jz.
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
    " redraw
    " if s:anee == 0
        " echo 'NOT called!!!'.string(g:easy_move_toggle_on)
    " elseif s:anee == 1
        " echo 'ON  called!!!'
    " elseif s:anee == -1
        " echo 'off called!!!'
    " endif
endfun
" au GuiEnter * nmap <buffer><leader><C-d> :call EasyMoveToggle($buf.count)<cr>
" au syntax   * nmap <buffer><leader><C-d> :call EasyMoveToggle($buf.count)<cr>
" nmap <buffer><silent><leader><C-g> :call EasyMoveToggle($buf.count)<cr>
" nmap <C-i> ciw
nmap <leader><C-w> :call AltMap()<cr>

fun! RemoveVM() " remove carets
    %s/$//g
endfun
nmap <leader><C-v> :call RemoveVM()<cr>
" so $MyVim/pydbgmap.vim
" imap , <esc>a, 

nmap <F2> <C-PageUp> 
nmap <F3> <C-PageDown>   

fun! RemapFreqUse()
    nmap <F2> <C-PageUp> 
    nmap <F3> <C-PageDown>   
endfun
" au SwapExists * if (!hasmapto(":python debugger.close()<CR>") && !hasmapto("<C-PageUp>") && !hasmapto(":Dbg  into  <CR>"))| call RemapFreqUse() | endif
au BufWrite * if (!hasmapto(":python debugger.close()<CR>") && !hasmapto("<C-PageUp>") && !hasmapto(":Dbg  into  <CR>"))| call RemapFreqUse() | endif

" au BufNew * if hasmapto(":Dbg  into  <CR>") | call keymap#RecoverMarkAndCyan() endif
nmap <C-bs> :bwipeout<CR>

imap lj <ESC><Right>
imap ㅓㅓ <ESC><Right>
" nmap <leader>e :w<cr>:make<cr>:copen<cr><CR><C-w><C-k>
nmap <M-p> :cprevious<CR>
nmap <M-n> :cnext<CR>

    
""imap <C-;> ;<CR> not work!
nmap <C-S-F11> :RltvNmbr!<CR>
nmap <CR> :redraw!<CR>zz

command! RecordMyworks tabnew D:\Workspace\[FootPrint]\TODO_LIST.mywork
nmap <A-BS> :RecordMyworks<cr>zozz
nmap <leader><C-g> :set guifont=*<cr>

imap <C-r><C-r> ♣ 

fun! DisplayEncFenc()
    redraw!
    set enc
    set fenc
endfun
nmap <leader><C-k> :call DisplayEncFenc()<CR>

command! E Explore
cmap bp Breakpoint
nmap <C-p><C-p> /PENDING<CR>zz


"cmap c conditional
imap TT TODO 

" cmap go Go
nmap go :Go 
" cmap git G
nmap git :G

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

" map  <A-n> <Home>
" imap <A-n> <Home>
" map  <A-p> <End>
" imap <A-p> <End>
 map  <A-n> ^
 imap <A-n> <ESC>^
 map  <A-p> $
 imap <A-p> <ESC>$


imap <A-j> <Down>
imap <A-k> <Up>


imap <A-q> <ESC>l
vmap <A-q> <ESC>l
imap <A-[> <ESC>l
vmap <A-[> <ESC>l
imap <A-d> <Del>
map <A-d> <Del>

nmap vil ^v$h


map <C-g> c<CR><ESC>

inoremap <C-\> <C-R>=ListTODO()<CR>
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
nmap <M-l> viw
nmap [d :call VimFilerOpenCustomLeft()<CR>
" nmap [d :NERDTreeToggle<CR>
fun! VimFilerOpenCustomLeft()
    leftabove vnew
    VimFilerBufferDir
endfun


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

fun! PoponOnDotToggle()
    let g:jedi#popup_on_dot = !g:jedi#popup_on_dot
    if g:jedi#popup_on_dot
        echo 'Popup on dot [ON]'
    else
        echo 'Popup on dot [OFF]'
    endif
endfun

nmap ,~ :call PoponOnDotToggle()<CR>


nmap ,4 :NERDTreeFind<CR>

inoremap <expr> <M-j> pumvisible() ? "\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>" : "\<A-j>"
inoremap <expr> <M-k> pumvisible() ? "\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>" : "\<A-k>"
                                                           
inoremap <expr> <c-u> pumvisible() ? "\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>\<C-N>" : "\<c-u>"
inoremap <expr> <c-d> pumvisible() ? "\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>\<C-P>" : "\<c-d>"


inoremap <expr> <C-o> pumvisible() ? "\<C-x>\<C-o>" : "\<C-o>"

au filetype vim nmap <buffer>BB 141gg:BundleSearch<CR>
