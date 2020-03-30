if exists('g:loaded_grepper')
    " runtime plugin/grepper.vim
    let g:grepper.stop = 500
    let g:grepper.highlight = 1
    let g:grepper.prompt = 0
    let g:grepper.rg.grepprg .= ' --smart-case --sort path'

    function! s:ExecuteGrepper(tool, args)
        execute("Grepper -tool ".a:tool." -query ".a:args)
    endfunction
    " command! -nargs=1 Rg call s:ExecuteGrepper('rg', <q-args>)
    command! -nargs=1 Grep call s:ExecuteGrepper('grep', <q-args>)
endif
