fun! InSpace(opt)

    let pairs = [["'","'",'same'],['"','"','same'],['(',')','diff'],['{','}','diff'],['[',']','diff'],['<','>','diff']]
	let paired = 0 
    for p in pairs

		if p[2] == 'diff'
			let acol = match(getline('.'),p[0])
			let bcol = match(getline('.'),p[1])
			echo acol.bcol
			let ccol = col('.')-1
			let l_margin = abs(ccol - acol)
			let r_margin = abs(bcol - ccol) + 1
			if l_margin == r_margin
				let paired = 1 
				break
			endif
		elseif p[2] == 'same'
			for i in range(0,200)
				let f = getline('.')[col('.')-2-i]
				let b = getline('.')[col('.')-1+i]
				echo f.b
				if f == p[0] && b == p[1]
					let paired = 1 
					break
				endif
			endfor
		endif
    endfor

    if a:opt == 'spread'
      if paired
          return "\<space>\<space>\<Left>"
      else
          return "\<space>"
      endif
    elseif a:opt == 'shrink'
      if paired
          return "\<Right>\<C-h>\<C-h>"
      else
          return "\<C-h>"
      endif
    endif

endfun

imap <space> <C-R>=InSpace('spread')<CR>
imap <C-h> <C-R>=InSpace('shrink')<CR>
