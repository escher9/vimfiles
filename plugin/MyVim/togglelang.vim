fun SetChineseAbbr()
	set enc=chinese
	set guifont=MingLiU:h12
endfun
fun SetKorean_utf8()
	set enc=utf-8
	" set fencs=utf-8,cp949,iso-8859-1
	set guifont=Monaco:h12:w6.5
endfun
fun SetKorean_cp949()
	set enc=cp949
	" set fencs=utf-8,cp949,iso-8859-1
	set guifont=Monaco:h12:w6.5
endfun
fun togglelang#ToggleLanguage(arg) range
	if a:arg == 2  
		call SetChineseAbbr()
	elseif a:arg == 1  
		call SetKorean_cp949()
	else
		call SetKorean_utf8()
	endif
endfun
" autocmd FileType tex set enc=utf-8
