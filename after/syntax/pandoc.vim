hi link pandocAtxHeader VimwikiHeader3
hi link pandocAtxStart Comment
hi link pandocUListItemBullet Identifier

hi VimwikiHeader3 gui=bold

syn match xPandocHeaderDate /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=pandocAtxHeader
hi link xPandocHeaderDate VimwikiHeader3Date
hi VimwikiHeader3Date gui=underline

syn match xPandocFinishedTask /\v\*\s+\[[xX]\]\s.*/
hi link xPandocFinishedTask Comment

hi link pandocStrikeout     Comment
hi pandocStrikeout guifg=#465457 gui=italic
hi link pandocStrikeoutMark Comment

syn match xPandocLine /\v^-----$/
hi link xPandocLine String

function! ToggleStrikeoutOnCurrentListItem()
    let l:line = getline(line('.'))
    let l:match = matchlist(l:line, '\v^(\s*[*-]\s+)((\~\~)?)(.{-})((\~\~)?)$')
    if (len(l:match) > 0)
        let l:prefix = l:match[1]
        let l:task = l:match[4]
        let l:strikeout = '~~'
        if (l:match[2] == '~~') " task was already strikeout, revert
            let l:strikeout = ''
        endif
        call setline('.', l:prefix . l:strikeout . l:task . l:strikeout)
    endif
endfunction

nnoremap <C-space> :call ToggleStrikeoutOnCurrentListItem()<CR>

set wildignore+=*.pdf,*.html " ignore pandoc output files (in ctrlp)

function! <SID>UpdatePandocGeneratedFiles()
    let l:input = expand('%:r')
    if filewritable(l:input . '.pdf') == 1
        Pandoc pdf
    endif
    if filewritable(l:input . '.html') == 1
        Pandoc html5 -s --self-contained
    endif
endfunction

TableModeEnable

autocmd! BufWritePost <buffer> call <SID>UpdatePandocGeneratedFiles()
autocmd! InsertLeave <buffer> :TableModeRealign

" syn match xPandocMarker contained /\v(XXX|TODO|FIXME):/
" hi link xPandocMarker Todo

" setl foldmethod=expr
" setl foldexpr=getline(v:lnum)=='***'
" setl foldminlines=0
" setl foldtext='---'
" setl foldlevel=0
" set foldclose=all
