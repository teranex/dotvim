setlocal wrap
setlocal nolist
setlocal linebreak
setlocal nocursorcolumn
setlocal nocursorline
setlocal colorcolumn=
setlocal foldlevelstart=0
setlocal foldlevel=0
setlocal foldmarker=\ {{{,%%\ }}} " set foldmarkers so they don't include syntax regions
setlocal textwidth=0
setlocal breakindent
setlocal spelllang=en,nl          " check spelling in both English and Dutch by default
setlocal nospell " disable spell by default
setlocal foldcolumn=4
if has('conceal')
    setlocal concealcursor=c
endif

setlocal conceallevel=0   " disable conceal

if $VIM =~? 'droidvim'
    " running on Android in DroidVim on a tiny screen
    set nonumber
    set norelativenumber
    set foldcolumn=0
    :QuickfixsignsDisable

    iabbrev <buffer> <expr> nnn "## *".strftime("%Y-%m-%d %H:%M")."*\<CR>:REVIEW:<Up>\<End>"
else
    " assign ctrl-j to expand snippets, tab is used for table cells
    inoremap <buffer> <C-j> <C-R>=UltiSnips#ExpandSnippetOrJump()<CR>
    inoremap <buffer> <C-n> n<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>
endif

iabbrev <buffer> <expr> %t strftime("%Y-%m-%d %H:%M")
iabbrev <buffer> <expr> %d strftime("%Y-%m-%d")

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
