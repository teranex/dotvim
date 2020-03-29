" first enable pathogen by sourcing pathogen_init from runtime
runtime pathogen_init

" first some settings copied from Debian config
set nocompatible                        " no compatibility with old-skool vi
set backspace=indent,eol,start          " define behavior of backspace key
set history=1000                        " keep more history (was 50 in Debian config)

" and some other default options, just to be sure
set encoding=utf-8                      " by default set the encoding to UTF-8
set fileformats=unix,dos,mac            " also read mac files correctly, just in case we are dealing with that

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
set listchars=tab:→\ ,eol:·,trail:•,extends:❱,precedes:❰ " chars to show for list
set showbreak=…\                        " when soft-wrapping, start lines which continue the previous line with these chars
set laststatus=2                        " always show the statusline
set title                               " set the title
set ruler                               " show cursor position in left bottom corner
set splitbelow                          " open a new horizontal window below the current window instead of above
set scrolloff=3                         " minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=3                     " minimal number of screen columns to keep next to the cursor
set sidescroll=5                        " horizontally scroll 5 characters, instead of centering the cursor
set wildmenu                            " show command line completions
set wildmode=longest:full               " complete mode for wildmenu
set wildmode+=full                      " when pressing tab a second time, fully complete
if exists("&wildignorecase")
    set wildignorecase                  " ignore case when completing filenames
endif
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
set display+=lastline                   " display wrapped lines at bottom instead of @ symbols
if v:version > '702'
    set colorcolumn=80,120              " show a vertical line at these positions
endif
set fillchars=vert:\ ,fold:\            " fill vertical splitlines with spaces instead of the ugly |-char; Default - for folds

set diffopt+=iwhite                     " diff options: ignore whitespace

set incsearch                           " while searching, immediately show first match
set ignorecase                          " ignore case in (search) patterns
set smartcase                           " when the (search) pattern contains uppercase chars, don't ignore case
set hlsearch                            " highlight all the matches for the search (disable until next search with :noh)

set directory=~/.vimswaps,.,/tmp        " where to store the swap files
set noswapfile                          " disable swap files, most of the time they are just annoying
set nobackup                            " don't make a (permanent) backup when saving files
set writebackup                         " make a (temporary) backup while saving files
set backupcopy=yes                      " make a copy and overwrite the original file
if v:version > '702'
    if $VIM !~? 'droidvim'               " check that we are not running on Android (VimTouch)
        set undofile                    " save undo history to an external file
    endif
    set undodir=~/.vimundo,.,/tmp       " where to save undo history files
    set relativenumber                  " use relative line numbering
    " set nonumber                        " and disable default line numbering
endif
set cryptmethod=blowfish2               " use stronger blowfish encryption algorithm
set updatetime=500                      " wait this many milliseconds before firing the CursorHold autocmd (and write swap files)

set autoread                            " automatically reload the file when modified outside and not modified inside vim
set autowrite                           " write the modified file when switching to another file
set hidden                              " allow Vim to switch to another buffer while the current is not saved

set tags=tags;/                         " where to find the tags file: current directory and up

" options for sessions. These define what should be saved in a session
set sessionoptions=buffers,tabpages,winsize

" set the path, so we can easily open files with the gf command etc
set path+=./**;,,

" enable filetype detection and indentation specific for filetype
syntax on
filetype plugin indent on

" syntax configuring
let php_htmlInStrings = 1               " html syntax highlighting inside PHP strings
let php_folding = 0                     " disable PHP syntax folding
let g:DisableAutoPHPFolding = 1         " by default disable phpfolding.vim
let g:is_bash=1                         " configure shell script syntax as being bash syntax
let g:load_doxygen_syntax=1             " enable doxygen support in filetypes such as PHP

" the following line makes vim ignore camelCase and CamelCase words so they
" are not highlighted as spelling mistakes
autocmd Syntax * syn match CamelCase "\(\<\|_\)\%(\u\l*\)\{2,}\(\>\|_\)\|\<\%(\l\l*\)\%(\u\l*\)\{1,}\>" transparent containedin=.*Comment.*,.*String.*,VimwikiLink contains=@NoSpell contained

autocmd BufRead,BufNewFile *.{profile,install,test} setlocal filetype=php

" load the matchit script
runtime! macros/matchit.vim

" configure GUI, tab labels and titles
runtime vimrc-ui.vim

" setup keymappings
runtime vimrc-keymappings.vim

" setup abbreviations
runtime vimrc-abbreviations.vim

" setup functions and commands
runtime vimrc-functions.vim

" setup plugins
runtime vimrc-plugins.vim

" Host specific config ===================================================
" check for the existence of a host-specific vimrc file and source it
" by example: if your host is named 'andoria', this will source
" ~/scripts/vim/vimrc-andoria if it exists
let hostfile=$HOME.'/.vim/vimrc-'.hostname()
if filereadable(hostfile)
    exe 'source ' . hostfile
endif

" vim: fdm=marker fdl=0
