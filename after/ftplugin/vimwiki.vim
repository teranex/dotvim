" Rooter
setlocal wrap
setlocal nolist
setlocal linebreak
setlocal nocursorcolumn
setlocal nocursorline
setlocal colorcolumn=
setlocal foldmethod=marker
setlocal foldlevelstart=0
setlocal foldmarker=\ {{{,%%\ }}} " set foldmarkers so they don't include syntax regions
setlocal textwidth=0
setlocal breakindent
setlocal spelllang=en,nl          " check spelling in both English and Dutch by default
setlocal nospell " disable spell by default
if has('conceal')
    setlocal concealcursor=c
endif
" set showtabline=1

" disable conceal
setlocal conceallevel=0

" assign ctrl-j to expand snippets, tab is used for table cells
inoremap <buffer> <C-j> <C-R>=UltiSnips#ExpandSnippetOrJump()<CR>
" quickly open the general task list
" map <buffer> ,tl :e tasks/index.wiki<CR>
" quickly add a new general task
" map <buffer> ,ta ,tlggjO
" quickly archive (_F_ile) a task
" map <buffer> ,tf :m$-1<CR>'.

" define some aabbreviations. These are available as snippets in UltiSnips as
" well, but UltiSnips requires Python which is not available on all devices
" iabbrev <buffer> <expr> monday_    InsertDateForWeekday(0)
" iabbrev <buffer> <expr> tuesday_   InsertDateForWeekday(1)
" iabbrev <buffer> <expr> wednesday_ InsertDateForWeekday(2)
" iabbrev <buffer> <expr> thursday_  InsertDateForWeekday(3)
" iabbrev <buffer> <expr> friday_    InsertDateForWeekday(4)
" iabbrev <buffer> <expr> saturday_  InsertDateForWeekday(5)
" iabbrev <buffer> <expr> sunday_    InsertDateForWeekday(6)
" iabbrev <buffer> <expr> today_     strftime("%Y-%m-%d")
" iabbrev <buffer> <expr> tomorrow_  strftime("%Y-%m-%d", localtime()+86400)
" iabbrev <buffer> <expr> n_ "### ".strftime("%Y-%m-%d %H:%M")."\<CR>\<CR>--------------------------------------------------<Up>\<Up>"

iabbrev <buffer> <expr> %t strftime("%Y-%m-%d %H:%M")
iabbrev <buffer> <expr> %d strftime("%Y-%m-%d")

map <c-x> <Plug>VimwikiToggleListItem
nnoremap <buffer> <c-n> Go<C-U><CR><CR>n<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>


function! PandocConvert(firstLine, lastLine)
    let infile = tempname().'.md'
    exec ':'.a:firstLine.','.a:lastLine.'w '.infile
    let outfile = tempname().'.html'
    exec '!pandoc -o '.outfile.' '.infile
    exec '!firefox '.outfile
    redraw
endfunction

command! -range=% Pandoc call PandocConvert(<line1>, <line2>)
