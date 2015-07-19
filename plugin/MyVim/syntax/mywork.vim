fun! SetMyPallete()
    hi MyOrange      guifg=Orange  guibg=NONE
    hi MyCyan        guifg=Cyan    guibg=NONE
    hi MyRed         guifg=Red     guibg=NONE
    hi MyRedmore     guifg=Black   guibg=Yellow
    hi MyGreen       guifg=Green   guibg=NONE
    hi BlackGreen    guifg=Green   guibg=Black
    hi MyBlue        guifg=Blue    guibg=NONE
    hi MyYellow      guifg=Yellow  guibg=NONE
    hi MyPink        guifg=Pink    guibg=NONE
    hi MyMagenta     guifg=Magenta guibg=NONE
    hi MyRedPink     guifg=#de0fa3 guibg=NONE
    hi MyDate        guifg=Blue    guibg=Cyan
    hi MyNOTE        guifg=Black   guibg=Orange

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
    call matchadd("BlackGreen", " o ")
    call matchadd("MyRedmore" , " x ")
endfun
call SetMyPallete()
