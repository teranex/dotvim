let g:airline_theme='mymolokai'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V-LINE',
    \ '' : 'V-BLOCK',
    \ 's'  : 'S',
    \ 'S'  : 'S-LINE',
    \ '' : 'S-BLOCK',
    \ }
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_detect_spell = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0

function! MyAirline_Filesize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ''
    endif
    if bytes < 1024
        return bytes . 'B'
    else
        return (bytes / 1024) . 'kB'
    endif
endfunction

function! MyAirline_Filetype()
    let l:filetype = &filetype
    if l:filetype == ''
        let l:filetype = 'no ft'
    endif
    let l:fenc = &fenc
    if l:fenc == ''
        let l:fenc = &encoding
      endif
    return printf('%s | %s', l:fenc, l:filetype)
endfunction


call airline#parts#define('my_linenr', {
    \ 'raw': ' %#__accent_bold#%l%#__restore__#',
    \ 'accent': 'bold'})
call airline#parts#define('my_maxlinenr', { 'raw': '/%L ' })

call airline#parts#define_function('my_filesize', 'MyAirline_Filesize')
call airline#parts#define_function('my_filetype', 'MyAirline_Filetype')
let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'spell', 'capslock', 'iminsert'])
let g:airline_section_b = airline#section#create(['hunks', 'branch', 'my_filesize'])
let g:airline_section_c = airline#section#create(['%<', 'file', ' ', 'readonly'])
let g:airline_section_gutter = airline#section#create(['%='])
let g:airline_section_x = airline#section#create_right(['tagbar'])
let g:airline_section_y = airline#section#create(['my_filetype'])
let g:airline_section_z = airline#section#create(['windowswap', 'c:%v |', 'my_linenr', 'my_maxlinenr', '| #%n'])
let g:airline_section_error = airline#section#create(['ycm_error_count', 'eclim'])
let g:airline_section_warning = airline#section#create(['ycm_warning_count', 'whitespace'])
