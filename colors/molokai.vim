" Vim color file
" vim:fdm=marker:
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant 
" by Hamish Stuart Macpherson
"
" {{{ default molokai
hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif


hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
" hi Folded          guifg=#465457 guibg=#000000
" hi Folded          guifg=#960050 guibg=bg
" hi Folded          guifg=#13354A guibg=bg
" hi Folded          guifg=#1b4a68 guibg=bg
" hi Folded          guifg=#66D9EF guibg=bg gui=bold
hi Folded          guifg=#66D9EF guibg=#232526
" hi Folded          guifg=#F92672 guibg=bg
" hi Folded          guifg=#89807D guibg=bg
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#FFFFFF guibg=#455354
" marks column
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

if s:molokai_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E
   hi CursorLine                    guibg=#3E3D32
   hi CursorColumn                  guibg=#3E3D32
   hi ColorColumn                   guibg=#3B3A32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#75715E
   hi SpecialKey      guifg=#75715E
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
   hi Comment         guifg=#465457
   hi CursorLine                    guibg=#293739
   hi CursorColumn                  guibg=#293739
   hi ColorColumn                   guibg=#232526
   hi LineNr          guifg=#465457 guibg=#232526
   hi NonText         guifg=#465457
   hi SpecialKey      guifg=#465457
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   if s:molokai_original == 1
      hi Normal                   ctermbg=234 cterm=none
      hi CursorLine               ctermbg=235   cterm=none
   else
      hi Normal       ctermfg=252 ctermbg=233 cterm=none
      hi CursorLine               ctermbg=234   cterm=none
   endif
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   " hi Folded          ctermfg=67  ctermbg=16
   hi Folded          ctermfg=81  ctermbg=16
   hi Function        ctermfg=118
   hi Identifier      ctermfg=208               cterm=none
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=193 ctermbg=16

   hi Keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16
   hi PmenuSel                    ctermbg=244
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=253 ctermbg=66

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81  ctermbg=232

   hi Statement       ctermfg=161               cterm=bold
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi Tag             ctermfg=161
   hi Title           ctermfg=166
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Comment         ctermfg=59
   hi CursorColumn                ctermbg=234
   hi ColorColumn                 ctermbg=234
   hi LineNr          ctermfg=250 ctermbg=234
   hi NonText         ctermfg=59
   hi SpecialKey      ctermfg=59
end

" }}}

" ======= OWN MODIFICATIONS ==================================================
hi Error           guifg=#1E0010 guibg=red
hi ErrorMsg        guifg=red guibg=#232526 gui=bold
hi MatchParen      guifg=#66D9EF guibg=#1b4a68
" hi Todo            guifg=#000000 guibg=#E6DB74 gui=bold
hi Todo            guifg=#FD971F guibg=#31373a gui=bold
hi clear NonText
	
" hi NonText         guifg=#75715E
hi NonText         guifg=#373e42
" hi NonText         guifg=#465457
hi VertSplit       guibg=#455354
hi ColorColumn     guibg=#232526
hi CursorColumn    guibg=#232526
hi CursorLine      guibg=#232526
hi clear Cursor
hi Cursor          gui=reverse ctermfg=16  ctermbg=253
hi SpecialKey      guifg=#66D9EF               gui=none
hi SpecialKey      guifg=#888A85               gui=none
hi DiffText                      guibg=#080808 gui=bold
hi CursorLineNr    guifg=#232526 guibg=#465457 ctermfg=234 ctermbg=250 cterm=none
hi Conceal         guifg=#31373a ctermfg=235
" hi Folded           ctermfg=59

if $SUDO_USER != ''
    hi StatusLine guifg=red ctermfg=red
endif
hi StatusLineInsert guifg=#A6E22E ctermfg=black guibg=black ctermbg=118 gui=reverse,bold
hi StatusLineNC     guifg=#455354 guibg=fg
hi User1 gui=bold   guibg=#960050 guifg=white ctermfg=white ctermbg=162

hi DiffAdd         guifg=bg ctermfg=black ctermbg=151 guibg=#afdfaf
hi DiffDelete      guifg=bg ctermfg=black ctermbg=181 guibg=#dfafaf cterm=none gui=none
hi DiffChange      guifg=bg ctermfg=black ctermbg=229 guibg=#E6DB74 cterm=none
hi DiffText        guifg=bg ctermfg=black ctermbg=208 guibg=#FD971F cterm=none gui=bold

hi clear Search
hi Search           gui=reverse cterm=reverse

hi VimwikiHeader1   guifg=#F92672 gui=bold ctermfg=161 cterm=bold
hi VimwikiHeader2   guifg=#A6E22E gui=bold ctermfg=118 cterm=bold
hi VimwikiHeader3   guifg=#66D9EF gui=bold,italic ctermfg=81 cterm=bold
hi VimwikiHeader4   guifg=#AE81FF gui=bold ctermfg=135 cterm=bold
hi VimwikiHeaderChar guifg=#465457
hi VimwikiHR        guifg=#465457 ctermfg=59
hi VimwikiNoExistsLink guifg=#465457 gui=italic
hi link VimwikiCellSeparator Ignore
hi link VimwikiMarkers Comment
hi link VimwikiDelText Comment
hi link VimwikiCode Float
hi VimwikiMarkTag guifg=#66D9EF guibg=#1b4a68 ctermfg=16  ctermbg=208 cterm=bold

hi VimwikiTag       guifg=#66D9EF gui=italic,underline ctermfg=81 cterm=underline,italic
hi VimwikiDate      guifg=#F92672 ctermfg=161
hi xVimwikiMainTitle           guifg=#E6DB74 ctermfg=229 gui=italic,bold,underline
hi xVimwikiTodoDone guifg=#A6E22E guibg=#31373a gui=bold
hi xVimwikiDate guifg=#F8F8F2 guibg=#465457 gui=italic cterm=italic
" hi VimwikiHeader2Date  guifg=#A6E22E gui=italic ctermfg=144
" hi link VimwikiHeader2Date Comment
" hi VimwikiHeader3Date  guifg=#66D9EF gui=italic ctermfg=144
" hi VimwikiHeader4Date  guifg=#AE81FF gui=italic ctermfg=144
" hi VimwikiNoteHeader guifg=#66D9EF gui=italic ctermfg=81

hi MarkWord1 ctermbg=Yellow  guibg=#F92672 guifg=white ctermbg=161 ctermfg=255
hi MarkWord2 ctermbg=Magenta guibg=#A6E22E guifg=black ctermbg=118 ctermfg=16
hi MarkWord3 ctermbg=Red     guibg=#66D9EF guifg=black ctermbg=81 ctermfg=16
hi MarkWord4 ctermbg=Cyan    guibg=#AE81FF guifg=black ctermbg=135 ctermfg=16
hi MarkWord5 ctermbg=Green   guibg=#E6DB74 guifg=black ctermbg=144 ctermfg=16

hi clear DbgCurrentSign
hi clear DbgCurrentLine
hi clear DbgBreakptSign
hi clear DbgBreakptLine
hi DbgBreakptSign guibg=#973b46 guifg=white gui=bold
hi link DbgBreakptLine DbgBreakptSign
hi DbgCurrentSign guibg=#ffec63 guifg=black gui=bold
hi link DbgCurrentLine DbgCurrentSign

hi clear doxygenSpecialMultilineDesc
hi doxygenSpecialMultilineDesc guifg=#F92672 gui=NONE

if &t_Co > 255
    hi Error           ctermfg=16 ctermbg=red
    hi ErrorMsg        ctermfg=red ctermbg=16    cterm=bold
    hi NonText         ctermfg=59
    " hi clear SpellBad
    hi SpellBad        cterm=underline ctermbg=NONE guisp=#FF0000
    hi SpellCap        guisp=#7070F0 cterm=underline ctermbg=NONE
    hi VertSplit       ctermfg=244 ctermbg=244   cterm=bold
    hi ColorColumn     ctermbg=234
endif

let g:fzf_colors =
    \ { 'fg':    ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Identifier'],
    \ 'fg+':     ['fg', 'Pmenu', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'Pmenu', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
