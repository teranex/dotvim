hi Error           guifg=#1E0010 guibg=red 
hi ErrorMsg        guifg=red guibg=#232526 gui=bold
hi MatchParen      guifg=#000000 guibg=#3E3D32 gui=bold
hi Todo            guifg=#000000 guibg=#E6DB74 gui=bold
hi clear NonText
hi NonText         guifg=#75715E
hi VertSplit       guifg=#808080 guibg=#808080 gui=bold
hi ColorColumn     guibg=#232526

if &t_Co > 255
   hi Error           ctermfg=16 ctermbg=red
   hi ErrorMsg        ctermfg=red ctermbg=16    cterm=bold
   hi NonText         ctermfg=59
   hi clear SpellBad
   hi SpellBad        cterm=underline
   hi VertSplit       ctermfg=244 ctermbg=244   cterm=bold
   hi ColorColumn     ctermbg=234
endif
