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
set foldlevelstart=99                   " by default, open all folds
set foldmethod=indent                   " indent fold method by default
set mouse=a                             " enable the mouse
set mousemodel=popup                    " produce pop up for right click
set list                                " show special chars, such as tab and eol
set listchars=tab:→\ ,eol:·,trail:☐,extends:❱,precedes:❰ " chars to show for list
set laststatus=2                        " always show the statusline
set title                               " set the title
set ruler                               " show cursor position in left bottom corner
set splitbelow                          " open a new horizontal window below the current window instead of above
set scrolloff=3                         " minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=3                     " minimal number of screen columns to keep next to the cursor
set sidescroll=5                        " horizontally scroll 5 characters, instead of centering the cursor
set wildmenu                            " show command line completions
set wildmode=longest:full               " complete mode for wildmenu
set linebreak                           " only wrap after words, not inside words
set cursorline                          " highlight the current line
set cursorcolumn                        " highlight the current column
set completeopt=menu,longest,preview    " options for insert mode completion
set spell                               " enable spell check by default

set tabstop=4                           " number of spaces that a tab counts for
set shiftwidth=4                        " number of spaces to use for each step of indent
set softtabstop=4                       " number of spaces that a tab counts for while editing
set shiftround                          " round the indent to a multiple of shiftwidth
set expandtab                           " expand tabs to spaces
set autoindent                          " automatically indent a new line
set formatoptions+=r                    " automatic formatting: auto insert current comment leader after enter
set virtualedit=block,onemore           " allow cursor after end of line in visual block mode and allow cursor one char after line end
set display=lastline                    " display wrapped lines at bottom instead of @ symbols
if v:version > '702'
    set colorcolumn=80,120              " show a vertical line at these positions
endif

set diffopt+=iwhite                     " diff options: ignore whitespace

set incsearch                           " while searching, immediately show first match
set ignorecase                          " ignore case in (search) patterns
set smartcase                           " when the (search) pattern contains uppercase chars, don't ignore case
"set hlsearch                            " highlight all the matches for the search

set directory=~/.vimswaps,.,/tmp        " where to store the swap files
set noswapfile                          " disable swap files, most of the time they are just annoying
set nobackup                            " don't make a (permanent) backup when saving files
set nowritebackup                       " don't make a (temporary) backup while saving files
if v:version > '702'
    set undofile                        " save undo history to an external file
    set undodir=~/.vimundo,.,/tmp       " where to save undo history files
    set relativenumber                  " use relative line numbering
    set nonumber                        " and disable default line numbering
endif
set updatetime=500                      " wait this many milliseconds before firing the CursorHold autocmd (and write swap files)

set autoread                            " automatically reload the file when modified outside and not modified inside vim
set autowrite                           " write the modified file when switching to another file
set hidden                              " allow Vim to switch to another buffer while the current is not saved

set tags=tags;/                         " where to find the tags file: current directory and up

if exists('+autochdir')
  set autochdir                         " automatically change to the current directory when loading a file
endif

" options for sessions. These define what should be saved in a session
set sessionoptions=buffers,help,resize,tabpages,winsize,winpos

" set the path, so we can easily open files with the gf command etc
set path+=./**;,,

" enable filetype detection and indentation specific for filetype
syntax on
filetype plugin indent on

" syntax configuring
let php_htmlInStrings = 1               " html syntax highlighting inside PHP strings
let php_folding = 0                     " disable PHP syntax folding
let g:is_bash=1                         " configure shell script syntax as being bash syntax

" color scheme
let g:molokai_original=0
colorscheme molokai

function! FileSize()
  let bytes = getfsize(expand("%:p"))
  if bytes <= 0
    return ""
  endif
  if bytes < 1024
    return bytes . "b"
  else
    return (bytes / 1024) . "k"
  endif
endfunction

" status line
hi User1 gui=bold guibg=#960050 guifg=white ctermfg=white ctermbg=162

set statusline=                                " completely reset statusline
set statusline+=%f\                            " relative path of the file
set statusline+=#%n~%{winnr()}\                           " buffer number
set statusline+=%1*%m%r%*\ \                   " modified flag and read only flag
set statusline+=[%{strlen(&filetype)?&filetype:'none'},      " filetype
set statusline+=%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                        " file format
set statusline+=%=                             " left/right separator
set statusline+=[%{&wrap?'wrap':'nowrap'},     " wrap state
set statusline+=%{&expandtab?'spaces':'tabs'}:%{&tabstop}]\  " expand tab and tab stop info
set statusline+=%{FileSize()}\                 " filesize
set statusline+=%l/%L:%-3c                     " cursor line/total lines:cursor column
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

" GUI tab labels
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


if has("gui_running")
  " GUI is running or is about to start.
  " Maximize GVim window.
  set lines=37 columns=135
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
  " but always show the tabline (window otherwise resizes when first showing tabline)
  set showtabline=2

  if has("win32") || has("win64")
      set guifont=Consolas:h10:cANSI
  endif
endif

" tab switching: easily switch back to the previous tab
" see http://groups.google.com/group/vim_use/msg/b5f64d02a49b1348
au TabLeave * :let g:last_tab=tabpagenr()

fu! <sid>LastTab()
    if !exists("g:last_tab")
        return
    endif
    exe "tabn" g:last_tab
endfu

nmap <silent> <M-6> :call <sid>LastTab()<cr>

" settings for Syntastic =================================================
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" settings for debugger.vim ==============================================
let g:debuggerMaxDepth = 3

" settings for yankring ==================================================
"let g:yankring_min_element_length = 2

" settings for Ack =======================================================
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" settings for taglist ===================================================
let g:Tlist_Show_One_File=1 " only show current file

" settings for ShowMarks =================================================
" let g:showmarks_marks='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>^''.'

" settings for gitv ======================================================
let g:Gitv_OpenHorizontal='auto'

" settings for vimwiki ===================================================
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_hl_headers=1

" settings for ctrlp =====================================================
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles=0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_map = '<leader>t'
map <leader>e :CtrlPCurFile<CR>
map <leader>b :CtrlPBuffer<CR>
map <leader>] :CtrlPTag<CR>

" settings for snipmate ==================================================
" configure our custom snippets directories
let g:snippets_dir = $HOME.'/.vim/snippets/snipmate-snippets/,'.$HOME.'/.vim/snippets/own/'
" and source the support functions
exec 'source '.$HOME.'/.vim/snippets/snipmate-snippets/support_functions.vim'

" setting for colorizer ==================================================
" mapped to \tc by default, but this slows down the \t mapping for ctrlp so
" remap it to ,tc
nmap ,tc <Plug>Colorizer

" settings for quickfixsigns =============================================
let g:quickfixsigns_classes = ['marks', 'vcsdiff', 'breakpoints']
let g:quickfixsigns#marks#texthl = 'Type'

" settings for Mark ======================================================
" Better highlighting for Marked words with the mark.vim plugin.
highlight def MarkWord1 ctermbg=Yellow  guibg=#960050
highlight def MarkWord2 ctermbg=Magenta guibg=#005000
highlight def MarkWord3 ctermbg=Red     guibg=#465457
highlight def MarkWord4 ctermbg=Cyan    guibg=#13354A
highlight def MarkWord5 ctermbg=Green   guibg=#1E0010

" Key mapping ============================================================
"allow to use w!! to write to a file with sudo, in case forgotten
"http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
cmap w!! %!sudo tee > /dev/null %

" mapping to quickly open current directory in netrw
"map <leader>e :Ex<CR>

" Quickly insert semicolon at the end of the string
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc/1636961#1636961
inoremap ;; <End>;

" enter to the previous line
imap <S-CR> <C-O>O

" fix indent of the entire block when inserting }. (Might have to change this
" to only active for the PHP filetype)
inoremap } }<ESC>m'=iB`'a

" clear the search buffer with ,/
" http://nvie.com/posts/how-i-boosted-my-vim/
nmap <silent> ,/ :let @/=""<CR>

" open the session list
map ,s :SessionList<CR>
" open a new Tab
map ,t :tabnew<CR>\t

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
" and map control-delete to delete the next word in insert mode
imap <C-Del> <C-O>dw

" try to automagically align what should be aligned
map <leader>a :Tab /\(=>\\|,\zs\\|=\\|\|\)<CR>

" Auto Commands ==========================================================
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType php setlocal comments=sl:/*,mb:*,elx:*/ fdm=indent
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 | ColorHighlight

" Configure certain extensions as the correct filetype
autocmd BufRead,BufNewFile *.profile,*.install,*.test setlocal filetype=php

" run the rooter plugin for every file
autocmd SessionLoadPost * Rooter

" close fugitive buffers when they are not shown anymore
autocmd BufReadPost fugitive://* set bufhidden=wipe

" enable the marks plugin by default
" if has("signs")
"     autocmd BufEnter * DoShowMarks
" endif

" set up to change the status line based on mode
au InsertEnter * hi! link StatusLine StatusLineInsert
au InsertLeave * hi! link StatusLine NONE

" Abbreviations ==========================================================
abbr publiic public
abbr funciton function
abbr functin function
" command line only Abbreviations
cabbrev help tab help
cabbrev h tab help
cabbrev <expr> mv '!mv '.expand('%:p').' '.expand('%:p:h')
cabbrev <expr> rm '!rm '.expand('%:p')

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

" easily copy relative path to clipboard
command! CopyPath let @+ = expand('%')

function! BufDelExcptActv()
    let buf = bufnr('%')
    bufdo if bufnr('%') != buf | bdelete | endif
endfunction
command! Bonly call BufDelExcptActv()

" Spelling configuration =================================================
" the following line makes vim ignore camelCase and CamelCase words so they
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
