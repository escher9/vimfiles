
function SetaSideRight()
	set lines=90
	if g:MyEnvironment
		set columns=120 "DESKTOP
	else
		set columns=50 "NOTEBOOK
	endif
	winpos 1000 0
	if getwinposx() < 900
		call SetaSideRight()
	endif
endf

function SetaSideLeft()
	winpos 0 0
	set columns=50
	set lines=90
endf

function SetaSideUp()
	winpos 0 0
	set columns=1600
	set lines=10
endf

function SetaSideDown()
	set columns=1600
	if g:MyEnvironment
		set lines=25 "DESKTOP
		winpos 0 610 "DESKTOP
	else
		set lines=10 "NOTEBOOK
		winpos 0 540 "NOTEBOOK
	endif
	if getwinposy() < 456
		call SetaSideDown()
	endif
endf

function DefaultPosSize()
	winpos 0 0
	set columns=260
	set lines=90
endf

function DefaultSize()
	winpos
	set columns=260
	set lines=90
endf

function DefaultPos()
	winpos 0 0
endf

function Maximize()
	simalt ~x
	" set columns=265
	" set lines=110
endf

function RestoreSize()
	simalt ~r
endf

function ShutDown()
	simalt ~n
endf

function To2nd()
	" winpos 1916 -4
	winpos -1084 -4
	simalt ~x
endf

nmap ,.2 :call DefaultSize()<CR>
" nmap ,.2 :call To2nd()<CR>:call Maximize()<CR>
nmap ,.` :call DefaultPosSize()<CR>:call To2nd()<CR>
" nmap ,.` :call DefaultPosSize()<CR>:call To2nd()<CR>:call Maximize()<CR>
nmap ,.3 :call Maximize()<CR>
nmap ,ssl :call SetaSideRight()<CR>
nmap ,ssh :call SetaSideLeft()<CR>
nmap ,ssk :call SetaSideUp()<CR>
nmap ,ssj :call SetaSideDown()<CR>

nmap ,.z :call ShutDown()<CR>
nmap ,.r :call DefaultPosSize()<CR>
" nmap ,.r :call DefaultPosSize()<CR>,.3
nmap ? [i


" 
" function SetaSideRight()
	" set lines=90
	" if g:MyEnvironment
		" set columns=120 "DESKTOP
	" else
		" set columns=50 "NOTEBOOK
	" endif
	" winpos 1000 0
	" if getwinposx() < 900
		" call SetaSideRight()
	" endif
" endf
" 
" function SetaSideLeft()
	" winpos 0 0
	" set columns=50
	" set lines=90
" endf
" 
" function SetaSideUp()
	" winpos 0 0
	" set columns=1600
	" set lines=10
" endf
" 
" function SetaSideDown()
	" set columns=1600
	" if g:MyEnvironment
		" set lines=25 "DESKTOP
		" winpos 0 610 "DESKTOP
	" else
		" set lines=10 "NOTEBOOK
		" winpos 0 540 "NOTEBOOK
	" endif
	" if getwinposy() < 456
		" call SetaSideDown()
	" endif
" endf
" 
" function DefaultPosSize()
	" winpos 0 0
	" set columns=260
	" set lines=90
" endf
" 
" function DefaultSize()
	" winpos
	" set columns=260
	" set lines=90
" endf
