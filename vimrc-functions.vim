function! GenerateUniqueID(length)
    return strpart(sha256(strftime("%Y%m%d%H%M%S")), 0, a:length)
endfunction

function! GenerateTimestampedID()
    return strftime("%Y%m%d-") . GenerateUniqueID(5)
endfunction

function! VimWikiNewNote(path, title)
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
    let filename = id.slug.'.md'

    exec ':edit ~/vimwiki/'.a:path.'/'.filename
    call append(0, "# *".strftime("%Y-%m-%d")."* ".title)
    call append(1, ':REVIEW:'.id.':')
    normal k
    startinsert!
endfunction

command! -nargs=* Note call VimWikiNewNote('notes', <q-args>)
command! -nargs=* Meeting call VimWikiNewNote('work/meetings', <q-args>)

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
