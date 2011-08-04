hi Error           guifg=#1E0010 guibg=red
hi ErrorMsg        guifg=red guibg=#232526 gui=bold
hi MatchParen      guifg=#000000 guibg=#3E3D32 gui=bold
hi Todo            guifg=#000000 guibg=#E6DB74 gui=bold
hi clear NonText
hi NonText         guifg=#75715E
hi VertSplit       guifg=#455354  guibg=#455354
hi ColorColumn     guibg=#232526
hi CursorColumn    guibg=#232526
hi SpecialKey      guifg=#66D9EF               gui=none
hi SpecialKey      guifg=#888A85               gui=none
hi DiffText                      guibg=#080808 gui=bold

hi StatusLine       guifg=#FD971F guibg=#121212 gui=bold,reverse
hi StatusLineInsert guifg=#005000 ctermfg=white guibg=white ctermbg=22 gui=reverse
hi StatusLineNC     guifg=#455354 guibg=fg

hi Search           guibg=#A6E22E guifg=#232526

if &t_Co > 255
   hi Error           ctermfg=16 ctermbg=red
   hi ErrorMsg        ctermfg=red ctermbg=16    cterm=bold
   hi NonText         ctermfg=59
   hi clear SpellBad
   hi SpellBad        cterm=underline
   hi VertSplit       ctermfg=244 ctermbg=244   cterm=bold
   hi ColorColumn     ctermbg=234
endif
