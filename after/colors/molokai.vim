hi Error           guifg=#1E0010 guibg=red
hi ErrorMsg        guifg=red guibg=#232526 gui=bold
hi MatchParen      guifg=#000000 guibg=#3E3D32 gui=bold
hi Todo            guifg=#000000 guibg=#E6DB74 gui=bold
hi clear NonText
hi NonText         guifg=#75715E
hi VertSplit       guifg=#455354  guibg=#455354
hi ColorColumn     guibg=#232526
hi CursorColumn    guibg=#232526
hi CursorLine      guibg=#232526
hi clear Cursor
hi Cursor          gui=reverse
hi SpecialKey      guifg=#66D9EF               gui=none
hi SpecialKey      guifg=#888A85               gui=none
hi DiffText                      guibg=#080808 gui=bold
hi CursorLineNr    guifg=#232526 guibg=#465457 ctermfg=234 ctermbg=250
hi Conceal         guibg=#808080 guifg=black

" hi StatusLine       guifg=#FD971F ctermfg=208 ctermbg=black guibg=#121212 gui=bold,reverse
if $SUDO_USER != ''
    hi StatusLine guifg=red ctermfg=red
endif
hi StatusLineInsert guifg=#A6E22E ctermfg=black guibg=black ctermbg=118 gui=reverse,bold
hi StatusLineNC     guifg=#455354 guibg=fg
hi User1 gui=bold guibg=#960050 guifg=white ctermfg=white ctermbg=162

hi diffAdd      ctermfg=bg  guifg=bg      ctermbg=151 guibg=#afdfaf
hi diffDelete   ctermfg=bg  guifg=bg      ctermbg=181 guibg=#dfafaf cterm=none gui=none
hi diffChange   ctermfg=bg  guifg=bg      ctermbg=229 guibg=#E6DB74
hi diffText     ctermfg=bg  guifg=bg      ctermbg=208 guibg=#FD971F cterm=bold gui=bold

hi clear Search
hi Search           gui=reverse cterm=reverse

hi VimwikiHeader1   guifg=#F92672 gui=bold
hi VimwikiHeader2   guifg=#A6E22E gui=bold
hi VimwikiHeader3   guifg=#66D9EF gui=bold
hi VimwikiHeader4   guifg=#AE81FF gui=bold
hi VimwikiHeaderChar guifg=#465457
hi VimwikiHR        guifg=#465457
hi VimwikiNoExistsLink guifg=#465457 gui=italic
hi link VimwikiCellSeparator Ignore

hi VimwikiTag       guifg=#66D9EF gui=italic,underline
hi VimwikiDate      guifg=#F92672
hi VimwikiNoteDate  guifg=#E6DB74 gui=bold,underline
hi VimwikiNoteHeader guifg=#66D9EF gui=italic

hi DbgBreakPt guibg=#973b46 guifg=white gui=bold
hi DbgCurrent guibg=#ffec63 guifg=black gui=bold

hi phpDocTags guifg=#367480
hi phpDocParam guifg=#5e801a
hi phpDocVariable guifg=#804c10

if &t_Co > 255
   hi Error           ctermfg=16 ctermbg=red
   hi ErrorMsg        ctermfg=red ctermbg=16    cterm=bold
   hi NonText         ctermfg=59
   hi clear SpellBad
   hi SpellBad        cterm=underline
   hi VertSplit       ctermfg=244 ctermbg=244   cterm=bold
   hi ColorColumn     ctermbg=234
endif
