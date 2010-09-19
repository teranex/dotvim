" Description: vimtabs is a quickway to navigate through buffers     |
"                * it looks like mozilla-tabs if <F2> is pressed     |
"                * it's gui-independant and works also on console :) |
"                * the trick was to exploit wildmenu and emenu :)    |
" Author:      Christian MICHON                                      |
" Email:       christian_michon@yahoo.fr                             |
" Version:     1.1                                                   |
" Last Change: 21 Jul 2004                                           |
" Usage:       drop it in ~/.vim/plugin for example                  |
" TODO:        vimtabs appears by buffer's name order. It would be   |
"              better to appear by buffer's number order instead.    |
" History:     1.1 added 'hidden' option (21Jul2004)                 |
"              1.0 initial release (21Jul2004)                       |
"\___________________________________________________________________/

if exists('loaded_vimtabs')
  finish
endif
let loaded_vimtabs = 1

set hidden wildmenu wildcharm=<C-Z>
source $VIMRUNTIME/menu.vim
autocmd VimEnter * aunmenu Buffers.Refresh\ menu
autocmd VimEnter * aunmenu Buffers.Delete
autocmd VimEnter * aunmenu Buffers.Alternate
autocmd VimEnter * aunmenu Buffers.Next
autocmd VimEnter * aunmenu Buffers.Previous
autocmd VimEnter * aunmenu Buffers.-SEP-
map <unique> <F2> :emenu Buffers.<C-Z>
