" this function allows you to quickly toggle between a mode to write
" code and a mode to write text
let g:toggleWritingModeEnabled = 0
function! ToggleWritingModeFunc()
    if g:toggleWritingModeEnabled
        unmap j
        unmap k
        setlocal nowrap nospell list
        let g:toggleWritingModeEnabled = 0
    else
        map j gj
        map k gk
        setlocal wrap spell nolist lbr
        let g:toggleWritingModeEnabled = 1
    endif
endfunction

command! ToggleWritingMode call ToggleWritingModeFunc()

" function to be used by snipMate.
" Monday is first day: 0, Sunday last: 6
function! InsertDateForWeekday(daynumber)
    let weekday = strftime('%a')
    let current_daynumber = 0
    if weekday == 'Mon'
        let current_daynumber = 0
    elseif weekday == 'Tue'
        let current_daynumber = 1
    elseif weekday == 'Wed'
        let current_daynumber = 2
    elseif weekday == 'Thu'
        let current_daynumber = 3
    elseif weekday == 'Fri'
        let current_daynumber = 4
    elseif weekday == 'Sat'
        let current_daynumber = 5
    elseif weekday == 'Sun'
        let current_daynumber = 6
    endif

    let day_difference = a:daynumber - current_daynumber
    if day_difference <= 0
        let day_difference += 7
    endif
    return strftime("%Y-%m-%d", localtime()+86400*day_difference)
endfunction

function! GenerateUniqueID(length)
    return strpart(sha256(strftime("%Y%m%d%H%M%S")), 0, a:length)
endfunction

function! GenerateTimestampedID()
    return strftime("%Y%m%d-") . GenerateUniqueID(5)
endfunction

function! VimWikiNewNote(title)
    set nofoldenable
    if strlen(a:title) == 0
        let title = input("Note title: ")
    else
        let title = a:title
    endif

    let slug = ''
    if strlen(title) > 0
        " taken from vim-zettel
        let slug = substitute(title, " ", "-","g")
        let slug = tolower(slug)
        let slug = "-".slug
    endif

    let id = GenerateTimestampedID()
    " let id_split = split(id, '-')
    " echom id_split
    " let filename = strftime("%Y-%m-%d-").get(id_split, 1).slug.'.md'
    let filename = id.slug.'.md'

    exec ':edit ~/vimwiki/diary/'.filename
    " call append(0, "# *".strftime("%Y-%m-%d %H:%M")."* ".title)
    call append(0, "# *".strftime("%Y-%m-%d")."* ".title)
    call append(1, ':REVIEW:'.id.':')
    normal k
    startinsert!
endfunction

command! -nargs=* NewNote call VimWikiNewNote(<q-args>)

" see https://github.com/garybernhardt/dotfiles/blob/master/.vimrc#L285
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
command! FRename call RenameFile()
