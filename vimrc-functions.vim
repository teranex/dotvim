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
function! CreateNoteFromSnippet(snippet, path, title, timestamp, diary_header)
    " taken from vim-zettel
    let slug = substitute(a:title, "[ /:]", "-","g")
    let slug = tolower(slug)
    let slug = "-".slug

    let id = GenerateIDFromTimestamp(a:timestamp)
    let filename = id.slug.'.md'

    let g:vwsnip_id = id
    let g:vwsnip_title = a:title
    let g:vwsnip_date = strftime("%Y-%m-%d", a:timestamp)

    if a:diary_header != ''
        let diary_file = '~/vimwiki/diary/'.strftime("%Y-%m-%d").'.md'
        exec ':edit '.diary_file
        " move to the top so we can correctly search
        call cursor(1, 1)
        " search Journal heading and last line
        call search("# ".a:diary_header)
        let last_line = search("^$")
        " insert new line starting with * and current time
        call append(l:last_line-1, "* [[/".a:path.'/'.id.slug."]]")
    endif

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

command! -nargs=* Meeting call CreateNoteFromSnippet('__meeting', 'work', <q-args>, AskDateForNote(), 'Meetings')
command! -nargs=* Note call CreateNoteFromSnippet('__note', 'notes', <q-args>, localtime(), '')
command! -nargs=* WorkNote call CreateNoteFromSnippet('__note', 'work', <q-args>, localtime(), '')
command! Diary call CreateDiaryFromSnippet(input("date> ", strftime("%Y-%m-%d")))

function! AppendLogEntry()
    " open today's diary file
    " norm <leader>w<leader>w
    let diary_file = '~/vimwiki/diary/'.strftime("%Y-%m-%d").'.md'
    exec ':edit '.diary_file
    " move to the top so we can correctly search
    call cursor(1, 1)
    " search Journal heading and last line
    call search("# Journal")
    let last_line = search("^$")
    " insert new line starting with * and current time
    call append(l:last_line-1, "* ".strftime("%H:%M")." ")
    " move cursor to end of the newly added line
    call cursor(l:last_line, 20)
    startinsert
endfunction

command! VimwikiLogEntry call AppendLogEntry()

function! ParseVimwikiURL(url)
    " strip quote when it was passed as an argument from desktop entry
    let url = substitute(a:url, "'", '', 'g')
    let url = substitute(url, '^vimwiki://', '', '')
    let wiki_dir = $HOME . '/vimwiki/'

    if match(url, '^tag=') >= 0
      " exec 'cd '.l:wiki_dir
      exec 'set tags='.wiki_dir.'.vimwiki_tags'
      let tag = substitute(url, '^tag=', '', '')
      execute 'tag ' . tag
    else
      let file_path = wiki_dir . url . '.md'
      execute 'e ' . file_path
    endif
endfunction

command! -nargs=1 OpenVimwikiURL call ParseVimwikiURL(<q-args>)
