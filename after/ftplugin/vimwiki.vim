setlocal wrap
setlocal list
setlocal linebreak
setlocal nocursorcolumn
setlocal colorcolumn=
setlocal foldlevel=99
setlocal textwidth=0
setlocal breakindent
setlocal spelllang=en,nl          " check spelling in both English and Dutch by default
setlocal spell " enable spell by default
setlocal foldcolumn=0
setlocal shiftwidth=4
setlocal tabstop=4
setlocal infercase
setlocal iskeyword+=- " add a dash as keyword symbol to allow to jump to my id's such as 20200409-cb90f
setlocal conceallevel=0   " disable conceal
setlocal tags=.vimwiki_tags
if has('conceal')
    setlocal concealcursor=c
endif

" call AddCycleGroup(['TODO', 'T̶O̶D̶O̶', 'XXX', 'X̶X̶X̶', 'DISCUSS', 'D̶I̶S̶C̶U̶S̶S̶', 'ISSUE', 'I̶S̶S̶U̶E̶' ])

map <leader>r :Rg :REVIEW:<CR>
" map <leader>l :set nohlsearch<CR><leader>w<leader>wgg/# Journal<CR>/\v^$<CR>Otime<tab>
map <leader>l :VimwikiLogEntry<CR>

map <c-x> <Plug>VimwikiToggleListItem

function! PandocConvert(firstLine, lastLine)
    let infile = tempname().'.md'
    exec ':'.a:firstLine.','.a:lastLine.'w '.infile
    let outfile = tempname().'.html'
    exec '!pandoc -o '.outfile.' '.infile
    exec '!firefox '.outfile
    redraw
endfunction

command! -range=% Pandoc call PandocConvert(<line1>, <line2>)
command! Okular exec '!okular '.expand('%').'&'

command! Trash :Move .trash/

command! Backlinks call BacklinksSearch()

function! BacklinksSearch()
    let page_match = ".*/?".expand('%:t:r').'([\|#].*)?'
    let link_match = '\[\['.l:page_match.'\]\]|\('.l:page_match.'\)'
    echom l:link_match
    exec ":Rg ".l:link_match
endfunction

command! MissingBacklinks exec ':Rg [^\[\(/]'.tolower(expand('%:t:r'))

function! DoSearchWithKeyword(keyword, ...)
    let search = join(a:000, ' ')
    let cmd = 'rg --column --line-number --no-heading --color=always -i '.fzf#shellescape(l:search).' $(echo "$(fd '.a:keyword.';rg -l '':'.a:keyword.':'')" | sort | uniq)'
    call fzf#vim#grep(l:cmd, fzf#vim#with_preview())
endfunction

command! -nargs=+ SearchWithKeyword call DoSearchWithKeyword(<f-args>)

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview
