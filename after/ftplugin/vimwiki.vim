setlocal wrap
setlocal nolist
setlocal linebreak
setlocal nocursorcolumn
" setlocal nocursorline
setlocal colorcolumn=
" setlocal foldlevelstart=0
setlocal foldlevel=99
" setlocal foldmethod=expr
" setlocal foldmarker=\ {{{,%%\ }}} " set foldmarkers so they don't include syntax regions
setlocal textwidth=0
setlocal breakindent
setlocal spelllang=en,nl          " check spelling in both English and Dutch by default
setlocal nospell " disable spell by default
setlocal foldcolumn=4
setlocal shiftwidth=4
setlocal tabstop=4
if has('conceal')
    setlocal concealcursor=c
endif

setlocal conceallevel=0   " disable conceal
setlocal dictionary=~/.vim/misc/vimwiki-dict

if $VIM =~? 'droidvim'
    " running on Android in DroidVim on a tiny screen
    setlocal nonumber
    setlocal norelativenumber
    setlocal foldcolumn=0
    :QuickfixsignsDisable

    " iabbrev <buffer> <expr> %n "# *".strftime("%Y-%m-%d %H:%M")."*\<CR>:REVIEW:<Up>\<End>"
else
    " assign ctrl-j to expand snippets, tab is used for table cells
    " inoremap <buffer> <C-j> <C-R>=UltiSnips#ExpandSnippetOrJump()<CR>

    " let g:minisnip_trigger = '<C-j>'
    " inoremap <buffer> <C-j> <Plug>minisnip
    " inoremap <buffer> <C-n> n<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>
endif

call AddCycleGroup(['TODO', 'T̶O̶D̶O̶', 'XXX', 'X̶X̶X̶', 'DISCUSS', 'D̶I̶S̶C̶U̶S̶S̶', 'ISSUE', 'I̶S̶S̶U̶E̶' ])

" iabbrev <buffer> <expr> %t "*".strftime("%H:%M")."*:"
" iabbrev <buffer> <expr> %d strftime("%Y-%m-%d")
" iabbrev <buffer> <expr> %j "# *".strftime("%Y-%m-%d")."* Journal\<CR>:journal:REVIEW:\<CR>"

map <c-x> <Plug>VimwikiToggleListItem
nnoremap <buffer> <leader>} :CtrlPFunky<cr>

function! PandocConvert(firstLine, lastLine)
    let infile = tempname().'.md'
    exec ':'.a:firstLine.','.a:lastLine.'w '.infile
    let outfile = tempname().'.html'
    exec '!pandoc -o '.outfile.' '.infile
    exec '!firefox '.outfile
    redraw
endfunction

command! -range=% Pandoc call PandocConvert(<line1>, <line2>)

" Copy from default Vimwiki to overwrite with our own version
" function! VimwikiFoldText()
"   let line = getline(v:foldstart)
"   let main_text = substitute(line, '^\s*', repeat(' ',indent(v:foldstart)), '')
"   let main_text =  substitute(line, '\v^#{1,}', repeat('·', v:foldlevel), '')
"   let fold_len = v:foldend - v:foldstart + 1
"   let len_text = ' ['.fold_len.'] '
"   if line !~# g:vimwiki_rxPreStart
"     let [main_text, spare_len] = s:shorten_text(main_text, 50)
"     return main_text.len_text.' ↩'
"   else
"     " fold-text for code blocks: use one or two of the starting lines
"     let [main_text, spare_len] = s:shorten_text(main_text, 24)
"     let line1 = substitute(getline(v:foldstart+1), '^\s*', ' ', '')
"     let [content_text, spare_len] = s:shorten_text(line1, spare_len+20)
"     if spare_len > s:tolerance && fold_len > 3
"       let line2 = substitute(getline(v:foldstart+2), '^\s*', s:newline, '')
"       let [more_text, spare_len] = s:shorten_text(line2, spare_len+12)
"       let content_text .= more_text
"     endif
"     return main_text.len_text.content_text.' ↩'
"   endif
" endfunction

" Copy from default Vimwiki to overwrite with our own version
" which disables code folding as it acts weird
" function! VimwikiFoldLevel(lnum)
"   let line = getline(a:lnum)
"
"   " Header/section folding...
"   if line =~# g:vimwiki_rxHeader
"     return '>'.vimwiki#u#count_first_sym(line)
"   " Code block folding...
"   " elseif line =~# g:vimwiki_rxPreStart
"   "   return 'a1'
"   " elseif line =~# g:vimwiki_rxPreEnd
"   "   return 's1'
"   else
"     return "="
"   endif
"
" endfunction
