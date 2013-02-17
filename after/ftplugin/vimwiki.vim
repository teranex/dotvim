" Rooter
setlocal wrap
setlocal nolist
setlocal linebreak
setlocal foldmethod=marker
setlocal foldlevelstart=0
setlocal foldmarker=\ {{{,%%\ }}} " set foldmarkers so they don't include syntax regions
setlocal textwidth=100
setlocal spelllang=en,nl          " check spelling in both English and Dutch by default
if has('conceal')
    setlocal concealcursor=c
endif

" assign ctrl-j to expand snippets, tab is used for table cells
inoremap <buffer> <C-j> <C-R>=UltiSnips_ExpandSnippetOrJump()<CR>
" quickly open the general task list
map <buffer> ,tl :e tasks/index.wiki<CR>
" quickly add a new general task
map <buffer> ,ta ,tlggjO
" quickly archive (_F_ile) a task
map <buffer> ,tf :m$-1<CR>'.
