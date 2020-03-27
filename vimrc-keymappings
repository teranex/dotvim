"allow to use w!! to write to a file with sudo, in case forgotten
"http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
" cnoremap w!! %!sudo tee > /dev/null %

" remove currently highlighted search by pressing Escape twice
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" enter to the previous line
" inoremap <S-CR> <C-O>O

" by default search with 'very no magic'
nnoremap / /\V
nnoremap ? ?\V

" easily insert an escaped / on the search prompt
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'

" remap ctrl-] to jump to tag, or display list of multiple results
" nnoremap <c-]> g<c-]>
" vnoremap <c-]> g<c-]>

" insert blank lines before and after (copied from unimpaired)
function! s:BlankUp(count) abort
    put!=repeat(nr2char(10), a:count)
    ']+1
endfunction

function! s:BlankDown(count) abort
    put =repeat(nr2char(10), a:count)
    '[-1
endfunction

nmap [<Space> :<C-U>call <SID>BlankUp(v:count1)<CR>
nmap ]<Space> :<C-U>call <SID>BlankDown(v:count1)<CR>

" map control-backspace to delete the previous word in insert mode
" imap <C-BS> <C-W>
inoremap <C-BS> <C-W>

" and map control-delete to delete the next word in insert mode
inoremap <C-Del> <C-O>dw

" even a bit of Emacs love...
inoremap <C-A> <C-o>I
cnoremap <C-A> <Home>
inoremap <C-E> <End>

" tab switching: easily switch back to the previous tab
" see http://groups.google.com/group/vim_use/msg/b5f64d02a49b1348
" autocmd TabLeave * :let g:last_tab=tabpagenr()
"
" fu! <sid>LastTab()
"     if !exists("g:last_tab")
"         return
"     endif
"     exe "tabn" g:last_tab
" endfu
"
" nnoremap <silent> <M-6> :call <sid>LastTab()<cr>

" nnoremap <C-Left> :cprevious<cr>
" nnoremap <C-Right> :cnext<cr>
