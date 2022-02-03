function! GenerateUniqueID(length)
    return strpart(sha256(strftime("%Y%m%d%H%M%S")), 0, a:length)
endfunction

function! GenerateIDFromTimestamp(timestamp)
    return strftime("%Y%m%d-", a:timestamp) . GenerateUniqueID(5)
endfunction

function! GenerateTimestampedID()
    return GenerateIDFromTimestamp(localtime())
endfunction

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

" A more logical place to define this function would be
" after/ftplugin/vimwiki.vim
" However, that gives an error as the function then gets redefined when the
" buffer is created and set to filetype `vimwiki`
function! CreateNoteFromSnippet(snippet, path, title, timestamp)
    " taken from vim-zettel
    let slug = substitute(a:title, " ", "-","g")
    let slug = tolower(slug)
    let slug = "-".slug

    let id = GenerateIDFromTimestamp(a:timestamp)
    let filename = id.slug.'.md'

    let g:vwsnip_id = id
    let g:vwsnip_title = a:title
    let g:vwsnip_date = strftime("%Y-%m-%d", a:timestamp)

    exec ':edit ~/vimwiki/'.a:path.'/'.filename
    exec "normal a".a:snippet."\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
    startinsert!

    unlet g:vwsnip_id g:vwsnip_title g:vwsnip_date
endfunction

function! AskDateForNote()
    let date = input("date> ", strftime("%Y-%m-%d"))
    return strptime("%Y-%m-%d", date)
endfunction

function! CreateDiaryFromSnippet(diary_date)
    let diary_file = '~/vimwiki/diary/'.a:diary_date.'.md'

    exec ':edit '.diary_file
    if getfsize(expand(diary_file)) <= 0
        exec "normal adiary\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
        startinsert!
    endif
endfunction

command! -nargs=* Meeting call CreateNoteFromSnippet('__meeting', 'work/meetings', <q-args>, AskDateForNote())
command! -nargs=* Note call CreateNoteFromSnippet('__note', 'notes', <q-args>, localtime())
command! -nargs=* WorkNote call CreateNoteFromSnippet('__note', 'work', <q-args>, localtime())
command! Diary call CreateDiaryFromSnippet(input("date> ", strftime("%Y-%m-%d")))
