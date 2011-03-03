" first enable pathogen by sourcing pathogen_init from runtime
runtime pathogen_init

" first some settings copied from Debian config
set nocompatible                        " no compatibility with old-skool vi
set backspace=indent,eol,start          " define behavior of backspace key
set history=500                         " keep the last 500 commands (was 50 in Debian config)

" and some other default options, just to be sure
set encoding=utf-8                      " by default set the encoding to UTF-8

" then my own
set nowrap                              " disable wrapping of text
set number                              " show line numbers by default
set t_Co=256                            " force the terminal to use 256 colors
set showcmd                             " show the current command in the statusline
set nofoldenable                        " disable folding. I hate it
set mouse=a                             " enable the mouse
set mousemodel=popup                    " produce pop up for right click
set list                                " show special chars, such as tab and eol
set listchars=tab:→\ ,eol:·             " chars to show for list
set laststatus=2                        " always show the statusline
set title                               " set the title
set ruler                               " show cursor position in left bottom corner
set splitbelow                          " open a new horizontal window below the current window instead of above
set scrolloff=3                         " minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=3                     " minimal number of screen columns to keep next to the cursor
set wildmenu                            " show command line completions
set wildmode=longest:full               " complete mode for wildmenu
set linebreak                           " only wrap after words, not inside words
set cursorline                          " highlight the current line
set completeopt=menu,longest,preview    " options for insert mode completion
set spell                               " enable spell check by default

set tabstop=4                           " number of spaces that a tab counts for
set shiftwidth=4                        " number of spaces to use for each step of indent
set softtabstop=4                       " number of spaces that a tab counts for while editing
set shiftround                          " round the indent to a multiple of shiftwidth
set expandtab                           " expand tabs to spaces
set autoindent                          " automatically indent a new line
set formatoptions+=r                    " automatic formatting: auto insert current comment leader after enter

set incsearch                           " while searching, immediately show first match
set ignorecase                          " ignore case in (search) patterns
set smartcase                           " when the (search) pattern contains uppercase chars, don't ignore case
set hlsearch                            " highlight all the matches for the search

set directory=~/.vimswaps,.,/tmp        " where to store the swap files
set noswapfile                          " disable swap files, most of the time they are just annoying
set nobackup                            " don't make a (permanent) backup when saving files
set nowritebackup                       " don't make a (temporary) backup while saving files
if v:version > '702'
    set undofile                        " save undo history to an external file
    set undodir=~/.vimundo,.,/tmp       " where to save undo history files
endif

set autowrite                           " write the modified file when switching to another file
set hidden                              " allow Vim to switch to another buffer while the current is not saved

set tags=tags;/                         " where to find the tags file: current directory and up

if exists('+autochdir') 
  set autochdir                         " automatically change to the current directory when loading a file
endif

" options for sessions. These define what should be saved in a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" enable filetype detection and indentation specific for filetype
syntax on
filetype on
filetype indent on
filetype plugin indent on

" syntax configuring
let php_htmlInStrings = 1               " html syntax highlighting inside PHP strings

" color scheme
let g:molokai_original=0
colorscheme molokai

" status line
hi User1 gui=bold guibg=#960050 guifg=white ctermfg=white ctermbg=162

set statusline=                                " completely reset statusline
set statusline+=%f\                            " relative path of the file
set statusline+=%1*%m%r%*\ \                   " modified flag and read only flag
set statusline+=[%{&filetype},                 " filetype
set statusline+=%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                        " file format
set statusline+=%=                             " left/right separator
set statusline+=[%{&wrap?'wrap':'nowrap'},     " wrap state
set statusline+=%{&expandtab?'spaces':'tabs'}:%{&tabstop}]\  " expand tab and tab stop info
set statusline+=%c,                            " cursor column
set statusline+=%l/%L                          " cursor line/total lines
set statusline+=\ %P                           " percent through file

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


if has("gui_running")
  " GUI is running or is about to start.
  " Maximize GVim window.
  set lines=37 columns=135
  " and remove the toolbar
  set guioptions-=T
  " but always show the tabline (window otherwise resizes when first showing tabline)
  set showtabline=2
endif

" Settings for Changed.vim 
"if has("signs")
    "let g:Changed_definedSigns = 1
    "sign define SIGN_CHANGED_DELETED_VIM text=- texthl=ChangedDeleted
    "sign define SIGN_CHANGED_ADDED_VIM   text=+ texthl=ChangedAdded
    "sign define SIGN_CHANGED_VIM         text=* texthl=ChangedModified 
    "highlight ChangedDeleted cterm=bold ctermbg=208 ctermfg=black gui=bold guibg=#ff9800 guifg=black 
    "highlight ChangedAdded cterm=bold ctermbg=148 ctermfg=black gui=bold guibg=#b1d631 guifg=black 
    "highlight ChangedModified cterm=bold ctermbg=yellow ctermfg=black gui=bold guibg=#f6f382 guifg=black 
"endif

" define mapping for QuickBuffer =========================================
let g:qb_hotkey = ",l"

" settings for Syntastic =================================================
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" settings for debugger.vim ==============================================
let g:debuggerMaxDepth = 3

" settings for yankring ==================================================
"let g:yankring_min_element_length = 2

" settings for indent guidelines =========================================
if !has("gui_running") " define our own colors when running in terminal
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2b2f31 ctermbg=235
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#17191a ctermbg=234
endif

" settings for easygrep ==================================================
let g:EasyGrepCommand=1
let g:EasyGrepRecursive=1
let g:EasyGrepIgnoreCase=0
let g:EasyGrepOpenWindowOnMatch=1
let g:EasyGrepJumpToMatch=0

" Key mapping ============================================================
"allow to use w!! to write to a file with sudo, in case forgotten
"http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
cmap w!! %!sudo tee > /dev/null %

" key mappings for fuzzy finder
map <leader>l   :FufBuffer<CR>
map <leader>ff  :FufFileWithCurrentBufferDir<CR>
map <leader>fF  :FufFile<CR>
map <leader>ft  :FufBufferTag<CR>
map <leader>fT  :FufTag<CR>
map <leader>fO  :FufTaggedFile<CR>

" Quickly insert semicolon at the end of the string
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc/1636961#1636961
inoremap ;; <End>;

" clear the search buffer with ,/
" http://nvie.com/posts/how-i-boosted-my-vim/
nmap <silent> ,/ :let @/=""<CR>

" toggle comment of entire line
map ,c<space> <plug>NERDCommenterToggle
" open the session list
map ,s :SessionList<CR>
" show the YankRing
map ,y :YRShow<CR>
" show the undo window from GUndo
map ,u :GundoToggle<CR>

" quickly escape a single character
map \\ i\<ESC>l

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" map control-backspace to delete the previous word in insert mode
imap <C-BS> <C-W>

" Auto Commands ==========================================================
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType php setlocal comments=sl:/*,mb:*,elx:*/
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Configure certain extensions as the correct filetype
autocmd BufRead,BufNewFile *.profile setlocal filetype=php
autocmd BufRead,BufNewFile *.install setlocal filetype=php

" run the rooter plugin for every file
autocmd BufRead,BufNewFile * Rooter

" enable the marks plugin by default
if has("signs")
    autocmd BufEnter * DoShowMarks
endif

" set up to change the status line based on mode
au InsertEnter * hi StatusLine term=reverse guifg=#005000 ctermfg=22
au InsertLeave * hi StatusLine term=reverse guifg=#444444 ctermfg=238
" and go to command mode when focus lost
"au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

" Abbreviations ==========================================================
abbr publiic public
abbr funciton function
abbr functin function
" command line only Abbreviations
cabbrev help tab help

" Functions ==============================================================
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

" Spelling configuration =================================================
" the following line makes vim ignore camelCase and CamelCase word so they
" are not highlighted as spelling mistakes
au Syntax * syn match CamelCase "\(\<\|_\)\%(\u\l*\)\{2,}\(\>\|_\)\|\<\%(\l\l*\)\%(\u\l*\)\{1,}\>" transparent containedin=.*Comment.*,.*String.*,VimwikiLink contains=@NoSpell contained

" Host specific config ===================================================
" check for the existence of a host-specific vimrc file and source it
" by example: if your host is named 'andoria', this will source
" ~/scripts/vim/vimrc-andoria if it exists
let hostfile=$HOME.'/.vim/vimrc-'.hostname()
if filereadable(hostfile)
    exe 'source ' . hostfile
endif
