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
set fillchars=vert:\ ,fold:-            " fill vertical splitlines with spaces instead of the ugly |-char; Default - for folds

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
    if $VIM !~? 'vimtouch'               " check that we are not running on Android (VimTouch)
        set undofile                    " save undo history to an external file
    endif
    set undodir=~/.vimundo,.,/tmp       " where to save undo history files
    set relativenumber                  " use relative line numbering
    " set nonumber                        " and disable default line numbering
    set cryptmethod=blowfish            " use stronger blowfish encryption algorithm
endif
set updatetime=500                      " wait this many milliseconds before firing the CursorHold autocmd (and write swap files)

set autoread                            " automatically reload the file when modified outside and not modified inside vim
set autowrite                           " write the modified file when switching to another file
set hidden                              " allow Vim to switch to another buffer while the current is not saved

set tags=tags;/                         " where to find the tags file: current directory and up

if exists('+autochdir')
    set autochdir                       " automatically change to the current directory when loading a file
endif

" options for sessions. These define what should be saved in a session
set sessionoptions=buffers,folds,resize,tabpages,winsize,winpos

" set the path, so we can easily open files with the gf command etc
set path+=./**;,,

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
    " use console style dialogs
    set guioptions+=c
    " but always show the tabline (window otherwise resizes when first showing tabline)
    set showtabline=2

    if has("win32") || has("win64")
        set guifont=Consolas:h10:cANSI
    endif
endif

" enable filetype detection and indentation specific for filetype
syntax on
filetype plugin indent on

" load the matchit script
runtime! macros/matchit.vim

" Title configuration {{{
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
" }}}

" GUI tab labels {{{
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
" }}}

" Configuration of plugins, syntax, colorschemes {{{
" syntax configuring
let php_htmlInStrings = 1               " html syntax highlighting inside PHP strings
let php_folding = 0                     " disable PHP syntax folding
let g:DisableAutoPHPFolding = 1         " by default disable phpfolding.vim
let g:is_bash=1                         " configure shell script syntax as being bash syntax
let g:load_doxygen_syntax=1             " enable doxygen support in filetypes such as PHP

" color scheme
let g:molokai_original=0
colorscheme molokai

" settings for Syntastic =================================================
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_aggregate_errors=1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--builtins=_ --max-line-length=100'
let g:syntastic_php_phpcs_args="--report=csv --standard=".expand('<sfile>:p:h')."/.vim/misc/phpcs-drupal-ruleset.xml"
let g:syntastic_php_phpmd_post_args=expand('<sfile>:p:h')."/.vim/misc/phpmd-ruleset.xml"

" settings for Ack =======================================================
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" settings for gitv ======================================================
let g:Gitv_OpenHorizontal='auto'

" settings for vimwiki ===================================================
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_hl_headers=1
let g:vimwiki_dir_link='index'
let g:vimwiki_url_mingain=1000
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
" define the default wiki
let wiki_nested_syntaxes = {
    \ 'bash': 'sh',
    \ 'python': 'python',
    \ 'ruby': 'ruby',
    \ 'html': 'html',
    \ 'php': 'php',
    \ 'vim': 'vim',
    \ 'conf': 'conf',
    \ 'gitconf': 'gitconfig',
    \ 'sql': 'sql',
    \ 'mail': 'mail',
    \}
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.nested_syntaxes = wiki_nested_syntaxes
let g:vimwiki_list = [wiki]

" settings for vimwiki_task ==============================================
let g:vimwiki_tasks_tags_duetime = '+notify'
let g:vimwiki_tasks_note_path = 'tasks'
" let g:vimwiki_tasks_task_args = 'rc:/media/cryptdata/dev/taskwarrior/testdata/.taskrc'

" settings for pandoc ====================================================
let g:pandoc#folding#fdc = 0
" let g:pandoc#formatting#mode = 'hA'
let g:pandoc#modules#disabled = ["keyboard"]
let g:pandoc#command#latex_engine = 'pdflatex'
let g:pandoc#spell#default_langs = ['en', 'nl']
let g:pandoc#syntax#conceal#blacklist = ['atx', 'list']
" let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ['bash=sh', 'python', 'ruby', 'html', 'php', 'yaml', 'vim', 'conf', 'sql']
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 0

" settings for table-mode ================================================
let g:table_mode_map_prefix = '<Leader>='

" settings for ctrlp =====================================================
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles=0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['tag', 'buffertag', 'filetype', 'tjump']
let g:ctrlp_map = '<leader>t'
let g:ctrlp_max_height = 25
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_buftag_types = {'php': '--language-force=php --php-types=cdfi'}
let g:ctrlp_tjump_only_silent = 1
noremap <leader>e :CtrlPCurFile<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>] :CtrlPTag<CR>
noremap <leader>} :CtrlPBufTag<CR>
noremap <leader>s :CtrlPSession<CR>
noremap <leader>f :CtrlPFiletype<CR>
nnoremap <c-]> :CtrlPtjump<cr>

" settings for Powerline =================================================
let g:Powerline_symbols_override = { 'LINE': '' }
let g:Powerline_colorscheme = 'trex'
call Pl#Theme#InsertSegment('trex:root_indicator', 'before', 'mode_indicator')
call Pl#Theme#RemoveSegment('paste_indicator')
call Pl#Theme#RemoveSegment('hgrev:branch')
" call Pl#Theme#RemoveSegment('syntastic:errors')
call Pl#Theme#RemoveSegment('tagbar:currenttag')
call Pl#Theme#RemoveSegment('rvm:string')
call Pl#Theme#RemoveSegment('virtualenv:statusline')
call Pl#Theme#ReplaceSegment('fugitive:branch', 'filesize')
call Pl#Theme#ReplaceSegment('lineinfo', 'trex:lineinfo')
call Pl#Theme#InsertSegment('trex:bufnumber', 'after', 'trex:lineinfo')

" setting for colorizer ==================================================
" do not map anything
let g:colorizer_nomap = 1

" settings for quickfixsigns =============================================
let g:quickfixsigns_classes = ['marks', 'vcsdiff', 'qfl']
let g:quickfixsigns#marks#texthl = 'Type'

" settings for neocomplecache ============================================
let g:neocomplcache_enable_at_startup = 1

" settings for vdebug ====================================================
" set the default configuration (only options which are different from default
" configuration)
let g:vdebug_options= {
    \    "watch_window_style" : 'compact',
    \    "server"             : '10.0.3.1',
    \    "timeout"            : 300,
    \    "break_on_open"      : 0,
    \    "continuous_mode"    : 1,
    \}
" add a keymapping to quickly remove all breakpoints
nnoremap <leader>dr :BreakpointRemove *<CR>

" settings for ultisnips =================================================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]
let g:UltiSnipsNoPythonWarning = 1

" settings for tslime ====================================================
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" settings for detectindent ==============================================
let g:detectindent_preferred_expandtab=1

" settings for indent lines ==============================================
let g:indentLine_color_gui='#31373a'
let g:indentLine_char='│'
let g:indentLine_indentLevel=7
let g:indentLine_noConcealCursor=1

" settings for clever-f
nmap ; <Plug>(clever-f-repeat-forward)
xmap ; <Plug>(clever-f-repeat-forward)
omap ; <Plug>(clever-f-repeat-forward)
nmap , <Plug>(clever-f-repeat-back)
xmap , <Plug>(clever-f-repeat-back)
omap , <Plug>(clever-f-repeat-back)

" settings for python-mode ===============================================
let g:pymode_rope_enable_shortcuts=0 " Does this work??
let g:pymode_rope_goto_def_newwin = 'vnew'
let g:pymode_rope_extended_complete=1
let g:pymode_run = 0
let g:pymode_lint = 0 " disabe the lint script. Let Syntastic do this job
" let g:pymode_lint_ignore = "W191,E128,E501"
let g:pymode_lint_cwindow = 0
let g:pymode_breakpoint = 0
let g:pymode_utils_whitespaces = 0

" settings for php-refactoring
let g:php_refactor_command='php /home/jeroen/dotvim/misc/refactor.phar'

" }}}

" Key mapping {{{
"allow to use w!! to write to a file with sudo, in case forgotten
"http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
cnoremap w!! %!sudo tee > /dev/null %

" remove currently highlighted search by pressing Escape twice
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" Delete all the other buffers with \B
nnoremap <leader>B :Bonly<CR>

" enter to the previous line
inoremap <S-CR> <C-O>O

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

" smart semi-colon insert at end of line
inoremap ;<cr> <C-O>A;<cr>
inoremap ;; <Esc>m'A;<Esc>`'li

" tab switching: easily switch back to the previous tab
" see http://groups.google.com/group/vim_use/msg/b5f64d02a49b1348
autocmd TabLeave * :let g:last_tab=tabpagenr()

fu! <sid>LastTab()
    if !exists("g:last_tab")
        return
    endif
    exe "tabn" g:last_tab
endfu

nnoremap <silent> <M-6> :call <sid>LastTab()<cr>
" }}}

" Auto Commands {{{
" Configure certain extensions as the correct filetype
autocmd BufRead,BufNewFile *.{profile,install,test} setlocal filetype=php
autocmd BufRead,BufNewFile *.json setlocal filetype=javascript
autocmd BufRead,BufNewFile *.{info,make,build} setlocal filetype=dosini

" run the rooter plugin after a session is loaded
autocmd BufRead,BufNewFile * Rooter

" Enable relativenumber only when in normal mode
" if exists('+relativenumber')
"     autocmd InsertEnter * setlocal number
"     autocmd InsertLeave * setlocal relativenumber
" endif

autocmd InsertLeave * pclose

" configure Filetypes
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 | ColorHighlight

" close fugitive buffers when they are not shown anymore
autocmd BufReadPost fugitive://* set bufhidden=wipe

" open the quickfix window after grepping
autocmd QuickFixCmdPost *grep* copen

" configure the Pentadactyl and Thunderbird external editor buffers
function! s:ConfigureTmpBuffer()
    ToggleWritingMode
    set columns=120
    set backupskip=
    set backup
endfunction
autocmd BufReadPost {/tmp/*.eml,pentadactyl.txt} call s:ConfigureTmpBuffer()

" set up to change the status line based on mode
autocmd InsertEnter * hi! link StatusLine StatusLineInsert
autocmd InsertLeave * hi! link StatusLine NONE

" automatically try to detect correct indent
autocmd BufReadPost * :DetectIndent

" due to encfs on my home directory, writing an undofile will sometimes fail
" as it results in a filename which is too long for encfs. In that case,
" simply disable undofile.
function! s:DisableUndofileWhenFailed()
    if match(v:errmsg, '\v^E828: Cannot open undo file for writing') != -1
        setlocal noundofile
        let v:errmsg = ''
        echo "Disabling undofile for this buffer"
    endif
endfunction
autocmd BufWritePost * call <SID>DisableUndofileWhenFailed()

" the following line makes vim ignore camelCase and CamelCase words so they
" are not highlighted as spelling mistakes
autocmd Syntax * syn match CamelCase "\(\<\|_\)\%(\u\l*\)\{2,}\(\>\|_\)\|\<\%(\l\l*\)\%(\u\l*\)\{1,}\>" transparent containedin=.*Comment.*,.*String.*,VimwikiLink contains=@NoSpell contained
" }}}

" Abbreviations {{{
abbr publiic public
abbr funciton function
abbr functin function
" command line only Abbreviations
cabbrev h tab help
" }}}

" Functions {{{
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

" function to be used by snipMate.
" Monday is first day: 0, Sunday last: 6
function! InsertDateForWeekday(daynumber)
    let weekday = strftime('%a')
    let current_daynumber = 0
    if weekday == 'Mon'
        let current_daynumber = 0
    elseif weekday == 'Tue'
        let current_daynumber = 1
    elseif weekday == 'Wed'
        let current_daynumber = 2
    elseif weekday == 'Thu'
        let current_daynumber = 3
    elseif weekday == 'Fri'
        let current_daynumber = 4
    elseif weekday == 'Sat'
        let current_daynumber = 5
    elseif weekday == 'Sun'
        let current_daynumber = 6
    endif

    let day_difference = a:daynumber - current_daynumber
    if day_difference <= 0
        let day_difference += 7
    endif
    return strftime("%Y-%m-%d", localtime()+86400*day_difference)
endfunction

" Highlight characters found by f, F, t, and T.
" Unhighlights on a cursorhold.
"
" matchadd is needed to highlight the char
"
" Also map <leader>f to show the highlight, and jump over the next char for ,
" and ; operations if the cursor won't move normally.
" if exists('*matchadd')
"     nnoremap f :<C-U>call FindChar('f', v:count1)<CR>
"     nnoremap F :<C-U>call FindChar('F', v:count1)<CR>
"     nnoremap t :<C-U>call FindChar('t', v:count1)<CR>
"     nnoremap T :<C-U>call FindChar('T', v:count1)<CR>
"     onoremap f :<C-U>call FindChar('f', v:count1, 'v')<CR>
"     onoremap F :<C-U>call FindChar('F', v:count1, 'v')<CR>
"     onoremap t :<C-U>call FindChar('t', v:count1, 'v')<CR>
"     onoremap T :<C-U>call FindChar('T', v:count1, 'v')<CR>
"     xnoremap f :<C-U>call FindChar('f', v:count1, 'gv')<CR>
"     xnoremap F :<C-U>call FindChar('F', v:count1, 'gv')<CR>
"     xnoremap t :<C-U>call FindChar('t', v:count1, 'gv')<CR>
"     xnoremap T :<C-U>call FindChar('T', v:count1, 'gv')<CR>
"
"     nnoremap ;  :<C-U>call FindLastChar(v:count1, ';')<CR>
"     onoremap ; v:<C-U>call FindLastChar(v:count1, ';')<CR>
"     xnoremap ;  :<C-U>call FindLastChar(v:count1, ';', 1)<CR>
"     nnoremap ,  :<C-U>call FindLastChar(v:count1, ',')<CR>
"     onoremap , v:<C-U>call FindLastChar(v:count1, ',')<CR>
"     xnoremap ,  :<C-U>call FindLastChar(v:count1, ',', 1)<CR>
"
"     " <C-U> in normal mode to remove any count, in visual mode to remove range
"     " Do not provide this command in op-pending mode, it doesn't do anything
"     " nnoremap <Leader>f :<C-U>call HighlightFoundChar()<CR>
"     " xnoremap <Leader>f :<C-U>call HighlightFoundChar()<CR>gv
"
"     hi FindChar gui=bold,underline guisp=orange guibg=black
"
"     " highlight the last found character
"     function! HighlightFoundChar()
"         if &hlsearch
"             if exists('w:fFtT_command_highlight')
"                 call matchdelete(w:fFtT_command_highlight)
"             endif
"             let w:fFtT_line = line('.')
"             let w:fFtT_command_highlight = matchadd(
"                         \'FindChar',
"                         \'\V\%' . w:fFtT_line . "l".escape(g:last_found_char,'/\'),
"                         \11)
"             setl cursorcolumn cursorline
"
"             " Set up autocmds to turn off highlighting for f, F, t, and T commands
"             " after a period of doing nothing, or moving to a new line. The
"             " CursorMoved one makes the cursor move slowly so remove it when not
"             " needed.
"             autocmd fFtT_hi CursorMoved *
"                         \ if exists('w:fFtT_command_highlight') && w:fFtT_line != line('.') |
"                         \   call matchdelete(w:fFtT_command_highlight) |
"                         \   unlet w:fFtT_command_highlight |
"                         " \   setl nocursorcolumn nocursorline |
"                         \   exec 'au! fFtT_hi CursorMoved' |
"                         \ endif
"
"         endif
"     endfunction
"
"     augroup fFtT_hi
"         au!
"         " Set up autocmds to turn off highlighting for f, F, t, and T commands after
"         " a period of doing nothing, or moving to a new line. The CursorMoved one
"         " makes the cursor move slowly so remove it when not needed.
"         " autocmd CursorHold,CursorHoldI *
"         "       \ if exists('w:fFtT_command_highlight') |
"         "       \   call matchdelete(w:fFtT_command_highlight) |
"         "       \   unlet w:fFtT_command_highlight |
"         "       \   setl nocursorcolumn nocursorline |
"         "       \   exec 'au! fFtT_hi CursorMoved' |
"         "       \ endif
"     augroup END
"
"     " Set the "last found character" and highlight it.
"     function! FindChar(op, count, ...)
"         " echo "Enter character to find"
"         let g:last_found_char = nr2char(getchar())
"         call HighlightFoundChar()
"         " clear the echo
"         echo ''
"         let cmdprefix=''
"         if a:0
"             let cmdprefix=a:1
"         endif
"         exec 'normal! ' . cmdprefix . a:count . a:op . g:last_found_char
"     endfunction
"
"     " Highlight the "last found character" if it exists and pass on the input
"     " operation which should be either , or ;
"     "
"     " Do a double-jump if a single jump doesn't move to allow ; and , to work
"     " intelligently when t or T is used.
"     function! FindLastChar(count, op, ...)
"         if exists('g:last_found_char') && g:last_found_char != ''
"             call HighlightFoundChar()
"         endif
"         if a:0
"             normal! gv
"         endif
"         if a:count==1
"             let curpos=getpos('.')
"             exec 'normal!' a:op
"             if curpos==getpos('.')
"                 exec 'normal! 2'.a:op
"             endif
"         else
"             exec 'normal! '.a:count.a:op
"         endif
"     endfunction
" endif
"
" function! UnifiedDiffFolds()
"     if getline(v:lnum) =~ "^diff\ "
"         return ">1"
"     endif
"     return "="
" endfunction
" }}}

" Host specific config ===================================================
" check for the existence of a host-specific vimrc file and source it
" by example: if your host is named 'andoria', this will source
" ~/scripts/vim/vimrc-andoria if it exists
let hostfile=$HOME.'/.vim/vimrc-'.hostname()
if filereadable(hostfile)
    exe 'source ' . hostfile
endif

" vim: fdm=marker fdl=0
