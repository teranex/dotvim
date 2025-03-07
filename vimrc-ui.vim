if has("gui_running")
    " GUI is running or is about to start.
    " Maximize GVim window.
    " set lines=37 columns=135
    " remove the menu bar
    set guioptions-=m
    " and remove the toolbar
    set guioptions-=T
    " and enable the horizontal scrollbar
    "set guioptions+=b
    " and remove the vertical scrollbar
    set guioptions-=r
    " no left scrollbar
    set guioptions-=L
    " use console style dialogs
    set guioptions+=c
    " but always show the tabline (window otherwise resizes when first showing tabline)
    " set showtabline=2
    set showtabline=1

    if has("win32") || has("win64")
        set guifont=Consolas:h10:cANSI
    else
        " set guifont=Hack
        let &guifont="0xProto Nerd Font Mono 10"
    endif
endif

" helper function for titlestring. Returns the name of the current
" session, if any is loaded, or an empty string when no session is loaded
function! TitleCurrentSession()
    if exists('g:LAST_SESSION')
        return g:LAST_SESSION.': '
    else
        return ''
    endif
endfunction

" title string
set titlestring=                               " completely reset titlestring
set titlestring+=%{TitleCurrentSession()}      " get the name of the current session, if available
set titlestring+=%t                            " the current filename
set titlestring+=%(\ %M%)                      " modified flag
set titlestring+=%(\ (%{expand(\"%:~:h\")})%)  " relative path to current file
set titlestring+=%(\ %a%)                      " extra attributes

function! TabLabelName(n)
    let buflist = tabpagebuflist(a:n)
    let bufnam  = bufname(buflist[tabpagewinnr(a:n) - 1])
    return substitute(bufnam, '.*/', '', '') " get basename of the buffer
endfunction


function TabLabelProperties()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label = ' ('.wincount.')'
    endif

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label .= ' [+]'
            break
        endif
    endfor

    " Append the buffer name
    return label
endfunction

function! MyGuiTabLine()
    let s = '#%N%{TabLabelProperties()}: %{TabLabelName(' . tabpagenr() . ')} '
    return s
endfunction

set guitablabel=%!MyGuiTabLine()
