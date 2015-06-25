let $LANG='en'
" set enc=cp949
set enc=utf8
let g:MyEnvironment = 1
let $DRIVE = "D:/"
let $TOOLS = "C:/utils/bin"
let $PYTHON_TOOLS_SCRIPTS = 'C:/Python27/Tools/Scripts'
let $MYVIM = "C:/Vim/vimfiles/plugin/MyVim"
let g:save_cursor = getpos('.')


au GUIEnter * simalt ~x
set nocompatible

source $VIMRUNTIME/vimrc_example.vim
set selectmode=mouse,key mousemodel=popup keymodel=startsel selection=inclusive
" source $VIMRUNTIME/mswin.vim
" behave mswin

command! -nargs=1 Silent | execute 'silent !'.<q-args> | execute ':redraw!'

set shortmess=a
set cmdheight=2
" set cmdheight=2

set fencs=ucs-bom,utf-8,cp949
" "---------------------------------------------------------------------------------
" fun SetAppropriateEnc()
    " set encoding=cp949
    " set fileencoding=utf-8
" endfun
" au syntax python,tex call SetAppropriateEnc()
" " ---------------------------------------------------------------------------------


set path=$Path

set diffexpr=MyDiff()
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"-------------born again since 2012-2-2--------------------------------
let mapleader=","
let g:EasyMotion_leader_key = "<F21>"

set nu
set ts=4
set ts=4
set sw=4

autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType python setlocal ts=4 sts=4 sw=4
py sys.path.append("C:\\Panda3d-1.8.0")
py sys.path.append("C:\\Panda3d-1.8.0\\bin")
py sys.path.append("c:\\Workspace\\Python")
py sys.path.append("c:\\Workspace\\Python\\Project1")

filetype plugin on
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let Tlist_Use_Right_Window = 0
" let Tlist_Ctags_Cmd = $PYTHONSCRIPTS . '/ptags.py'
let Tlist_Ctags_Cmd = 'C:/Vim/ctags58/ctags'
let g:tagbar_ctags_bin = 'C:/Vim/ctags58/ctags'

set tags=./tags

command! RE source $MYVIMRC
if has("gui_running")
    set go-=T
    set mouse=a
    set mousem=popup
    set go+=c
    set guioptions-=m
endif

" au BufRead,BufNewFile *.avl runtime! syntax/ruby.vim
" au BufRead,BufNewFile *.mass runtime! syntax/ruby.vim
" au BufRead,BufNewFile *.dat runtime! syntax/ruby.vim
" au BufRead,BufNewFile *.mdl runtime! syntax/matlab.vim

winpos 0 0
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:_
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

set guioptions+=c
" set ignorecase
set smartcase
set ve=all

set nocompatible             " be iMproved
filetype off                 " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundles/*{{{*/
Plugin 'gmarik/Vundle.vim'

" TODO My Bundles here:
Plugin 'https://github.com/dhruvasagar/vim-table-mode'
Plugin 'https://github.com/yuratomo/w3m.vim'
" Plugin 'https://github.com/ds26gte/optedvim'
" Plugin 'https://github.com/peterhoeg/vim-qml'
Plugin 'align'
" Plugin 'https://github.com/Shougo/vimfiler.vim'
" Plugin 'https://github.com/Shougo/vimproc.vim'
" Plugin 'https://github.com/Shougo/vimshell.vim'
Plugin 'https://github.com/Shougo/neocomplete.vim'
Plugin 'https://github.com/ivanov/vim-ipython'
Plugin 'https://github.com/altercation/vim-colors-solarized'
Plugin 'https://github.com/idbrii/AsyncCommand'
Plugin 'https://github.com/bling/vim-airline'
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'https://github.com/bruno-/vim-vertical-move'
Plugin 'escher9/vdebug-python'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'git://github.com/davidhalter/jedi-vim'
Plugin 'majutsushi/tagbar'
Plugin 'https://github.com/escher9/throughpairs'
Plugin 'repeat.vim'
Plugin 'Align.vim'
Plugin 'calendar.vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'Lokaltog/vim-easymotion'
" original repos on github
" -------------------------------------------------------------------------------------------------------
" Plugin 'tpope/vim-fugitive'
" Plugin 'fugitive.vim'
" Plugin 'EasyGrep'
" Plugin 'https://github.com/fs111/pydoc.vim'
" Plugin 'escher9/vim-debug'
" Plugin 'listmaps.vim'
" Plugin 'https://github.com/tpope/vim-fugitive'
" Plugin 'escher9/vdebug'
" Plugin 'Conque-Shell'
" Plugin 'Source-Explorer-srcexpl.vim'
" Plugin 'https://github.com/yakiang/excel.vim'
" Plugin 'https://github.com/wesleyche/SrcExpl'
" Plugin 'https://github.com/vim-scripts/cursoroverdictionary'
" Plugin 'unite.vim'
" Plugin 'https://github.com/kana/vim-arpeggio'
" Plugin 'https://github.com/yegappan/mru'
" Plugin 'https://github.com/ggreer/the_silver_searcher'
" Plugin 'https://github.com/rking/ag.vim'
" Plugin 'https://github.com/petdance/ack2'
" Plugin 'scrooloose/nerdtree'
" Plugin 'git://github.com/orestis/pysmell'
" Plugin 'pythonhelper'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Plugin 'tpope/vim-rails.git'
" vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" non github repos
" Plugin 'git://git.wincent.com/command-t.git'
" ..."}}}
" ---------------------------------------------------------------------------------/*}}}*/

call vundle#end()
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" ---------------------------------------------------------------------------------


" " Default: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz1234567890`'
let g:EasyMotion_do_shade = 0



let g:snips_author = 'escher9'


set autoread
set autoread<


let g:tex_flavor='latex'


" ---------------------------------------------------------------------------------
set backup              " keep a backup file
set backupext=.bak
set backupdir=$HOME/.vim/backup
" set backupdir=$HOME/.vim/backup
" Like having history
set history=100


" autocmd BufReadPost *.vb set ft=vbnet
" autocmd BufReadPost *.avl,*.mass set ft=python <Tab>
autocmd BufReadPost *.txt set ft=txt

" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType python set omnifunc=pysmell#Complete

autocmd FileType python set makeprg=python\ %
autocmd FileType ruby   set makeprg=ruby\ %
autocmd FileType make   set makeprg=make
autocmd FileType c      set makeprg=gcc\ %\ -Wall\ -ggdb\ -I.\ -L.\ -o\ %<
autocmd FileType tex    set makeprg=C:\Users\eshcer9\texlive\2013\bin\win32\pdflatex.exe\ %
autocmd FileType html   set makeprg=chrome\ %

au SwapExists * let v:swapchoice = 'e'

set wildcharm=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
" ---------------------------------------------------------------------------------done


" ---------------------------------------------------------------------------------
" colorscheme hybrid
au filetype javascript imap <buffer>;j {<CR>}<C-[>O
au filetype C imap <buffer>;j {<CR>}<C-[>O

" if exists(":Tabularize")
nmap ,TA\| :Tabularize /\|<CR>
vmap ,TA\| :Tabularize /\|<CR>
nmap ,TA= :Tabularize /=<CR>
vmap ,TA= :Tabularize /=<CR>
nmap ,TA: :Tabularize /:\zs<CR>
vmap ,TA: :Tabularize /:\zs<CR>               ,l
" endif

inoremap <silent> <Bar> <Bar><ESC>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

set expandtab
" set completeopt=longest,menuone
" set completeopt=longest,menuone
"
"
set nocompatible               " Be iMproved
" ---------------------------------------------------------------------------------done

" ---------------------------------------------------------------------------------
au syntax python retab

" au syntax python imap kk self.
" au syntax python imap ll self.
" au syntax python imap ii self.
" au syntax python imap .. self.<C-[>hla

function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)


call pathogen#helptags()


set cmdwinheight=17

" " ---------------------------------------------------------------------------------
" let g:vim_debug_disable_mappingsj = 1
" python << EOF
" import os
" import sys
" import vim
" sys.path.append("c:/python27/lib/site-packeges")
" EOF
"
" set tags+=C:/Python27/Lib/site-packages/cocos2d-0.5.5-py2.7.egg/cocos/tags
" set tags+=C:/Python27/Lib/site-packages/pyglet/tags
" set tags+=C:/python27/lib/site-packages/pygame/tags
" set tags+=C:/python27/lib/site-packages/pyqt4/tags
" " ---------------------------------------------------------------------------------
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
autocmd! BufWinEnter * nested if exists('syntax_on') && ! exists( 'b:current_syntax' ) && ! empty(&l:filetype) | syntax enable | endif

" au syntax python so C:\Users\escher9\.vim\bundle\vim-fugitive\plugin\fugitive.vim
call pathogen#runtime_append_all_bundles()
filetype off
syntax on
filetype plugin indent on
" " ---------------------------------------------------------------------------------
let g:vdebug_keymap = {
            \    "run_to_cursor"     : "<F1>",
            \    "step_over"         : "<F2>",
            \    "step_into"         : "<F3>",
            \    "step_out"          : "<F4>",
            \    "run"               : "<F5>",
            \    "eval_visual"       : "<F7>",
            \    "eval_under_cursor" : "<F8>",
            \    "close"             : "<F9>",
            \    "set_breakpoint"    : "<F10>",
            \    "get_context"       : "<F11>",
            \    "detach"            : "<F12>",
            \}
let g:vimrc_vdebug_force_ascii = 1

" let g:vdebug_pydbgp_default = $HOME . '/.vim/bundle/vdebug/pydbglib/pydbgp.py'
 " this turns off physical line wrapping (ie: automatic insertion of newlines)

" " ---------------------------------------------------------------------------------
set textwidth=200 wrapmargin=0
set statusline+=%F

fun! SetCustomColorTxt()

    hi MyOrange  guifg=Orange  guibg=NONE
    hi MyCyan    guifg=Cyan    guibg=NONE
    hi MyRed     guifg=Red     guibg=NONE
    hi MyRedmore guifg=Black   guibg=Yellow
    hi MyGreen   guifg=Green   guibg=NONE
    hi MyBlue    guifg=Blue    guibg=NONE
    hi MyYellow  guifg=Yellow  guibg=NONE
    hi MyPink    guifg=Pink    guibg=NONE
    hi MyMagenta guifg=Magenta guibg=NONE
    hi MyRedPink guifg=#de0fa3 guibg=NONE
    hi MyDate    guifg=Blue    guibg=Cyan
    hi MyNOTE    guifg=Black   guibg=Orange

    call matchadd("MyOrange" , "caution")
    call matchadd("MyOrange" , "Caution")

    call matchadd("MyGreen"   , "mon")
    call matchadd("MyGreen"   , "tue")
    call matchadd("MyGreen"   , "wed")
    call matchadd("MyGreen"   , "thu")
    call matchadd("MyYellow"  , "fri")
    call matchadd("MyCyan"    , "sat")
    call matchadd("MyRed"     , "sun")

    call matchadd("MyYellow"  , "DIARY")
    call matchadd("MyCyan"    , "SOLVED")
    call matchadd("MyOrange"  , "ORDER")
    call matchadd("MyCyan"    , "CLEAR")
    call matchadd("MyRed"     , "WHAT")
    call matchadd("MyMagenta" , "PROBLEM")
    call matchadd("MyNOTE"    , "NOTE")
    call matchadd("MyNOTE"    , "XXX")
    call matchadd("MyRedmore" , "PENDING")
    call matchadd("MyGreen"   , "DONE")
    call matchadd("MyOrange"  , "TODO")
    call matchadd("MyOrange"  , "WHY")
    call matchadd("MyCyan"    , "WHEN")
    call matchadd("MyRedPink" , "[0-9]")
    call matchadd("MyDate"    , "[0-9][0-9]]")


endfun


" let g:vdebug_pydbgp_default = 'C:\Python27\Scripts\pydbgp.py'
au BufRead,BufNewFile *.mywork setfiletype mywork
au filetype mywork silent call SetCustomColorTxt()
au BufWrite *.mywork silent call SetCustomColorTxt()

" ---------------------------------------------------------------------------------
"
let g:tagbar_left    = 1
let g:tag_include_ext_set = ".py .c"
let g:jedi#call_signature_escape = 0
let g:jedi#show_call_signatures  = 0
let g:jedi#completions_enabled   = 0
let g:jedi#completions_command   = ""

set fdm=marker
set clipboard=unnamed
set foldlevel=2

set dir=.,$TEMP

let g:multi_cursor_use_default_mapping=1


let scrolljump = 5

set autoindent
au filetype matlab setlocal commentstring=%-%s

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ---------------------------------------------------------------------------------

let g:python_highlight_all=1
if has("gui_running")"{{{
    function! ScreenFilename()
        if has('amiga')
            return "s:.vimsize"
        elseif has('win32')
            return $HOME.'\_vimsize'
        else
            return $HOME.'/.vimsize'
        endif
    endfunction

    function! ScreenRestore()
        " Restore window size (columns and lines) and position
        " from values stored in vimsize file.
        " Must set font first so columns and lines are based on font size.
        let f = ScreenFilename()
        if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
            for line in readfile(f)
                let sizepos = split(line)
                if len(sizepos) == 5 && sizepos[0] == vim_instance
                    silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
                    silent! execute "winpos ".sizepos[3]." ".sizepos[4]
                    return
                endif
            endfor
        endif
    endfunction

    function! ScreenSave()
        " Save window size and position.
        if has("gui_running") && g:screen_size_restore_pos
            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
            let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
                        \ (getwinposx()<0?0:getwinposx()) . ' ' .
                        \ (getwinposy()<0?0:getwinposy())
            let f = ScreenFilename()
            if filereadable(f)
                let lines = readfile(f)
                call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
                call add(lines, data)
            else
                let lines = [data]
            endif
            call writefile(lines, f)
        endif
    endfunction

    if !exists('g:screen_size_restore_pos')
        let g:screen_size_restore_pos = 1
    endif
    if !exists('g:screen_size_by_vim_instance')
        let g:screen_size_by_vim_instance = 1
    endif

    autocmd VimLeave * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
endif              "}}}
" ---------------------------------------------------------------------------------
cd ~
" let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#force_overwrite_completefunc = 1
au filetype python set balloonexpr=IPythonBalloonExpr()
" ---------------------------------------------------------------------------------
"
au BufEnter * silent! lcd %:p:h

" autocmd BufWrite * mkview"{{{
" fun RecoverView()
    " try
        " loadview
    " endtry
"
    " normal zz
" endfun
" autocmd BufRead * silent call RecoverView()"}}}
let g:snappytoggle = 1
fun! SnappyToggle()
    if g:snappytoggle
        set guifont=Inconsolata_for_Powerline:h11
        colorscheme molokai
        " colorscheme hybrid
        let g:snappytoggle = 0
    else
        set guifont=fixedsys
        colorscheme default
        let g:snappytoggle = 1
    endif
endfun
command! SnappyToggle call SnappyToggle()
nmap [~ :SnappyToggle<cr>

set guioptions-=a "MS copy&paset disable"

set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set completeopt+=longest
let g:EclimFileTypeValidate = 0 

"0au VimEnter * call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 1)
au VimEnter * call libcallnr("vimtweak.dll","SetAlpha",225)
set novisualbell
" set ttyfast
" set noswapfile
" set nobackup

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRUFiles'

" let g:EclimCompletionMethod = 'omnifunc'
let g:pydoc_cmd = 'C:\Python27\Lib\pydoc.py'

let g:jedi#documentation_command = '?'
let g:pep8_map='<C-F5>' 

" hi ErrorMsg NONE
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


let g:tagbar_zoomwidth = 0
let g:tagbar_foldlevel = 3
set winaltkeys=no 


" au CursorHold * exe "normal zz"

let g:trv_dictionary="~/.vim/dictionary/EK51873.TXT" 

let g:w3m#command = 'C:/w3m/w3m.exe' 

" // SrcExpl Settings
" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F12>" 

" // Set "<F3>" key for displaying the previous definition in the jump list 
let g:SrcExpl_prevDefKey = "<F3>" 

" // Set "<F4>" key for displaying the next definition in the jump list 
let g:SrcExpl_nextDefKey = "<F4>" 

" let g:arpeggio_timeoutlen = 100
let g:table_mode_realign_map = '<Leader>tr'
" au VimEnter * Arpeggio map qj <Plug>(easymotion-eol-j)
" au VimEnter * Arpeggio map qk <Plug>(easymotion-eol-k)
" au VimEnter * Arpeggio imap jo <ESC>
" au VimEnter * EclimDisable
let g:pydoc_cmd = 'python -m pydoc' 
let g:pydoc_open_cmd = 'vsplit' 
let g:pydoc_highlight=1 

" au GUIEnter * call Maximize()

let g:EclimDisabled = 1 
let g:airline#extensions#tagbar#enabled = 0
let g:neocomplete#enable_auto_close_preview = 0
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
set lazyredraw

let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
set guifont=Inconsolata_for_Powerline:h11
