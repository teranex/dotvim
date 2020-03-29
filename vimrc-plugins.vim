call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'

Plug 'vim-airline/vim-airline'

Plug 'vimwiki/vimwiki'
    let g:vimwiki_hl_cb_checked=2
    let g:vimwiki_table_mappings=0
    let g:vimwiki_autowriteall=0 " do not automatically save
    let g:vimwiki_hl_headers=1
    let g:vimwiki_dir_link='index'
    let g:vimwiki_folding='expr'
    let g:vimwiki_url_maxsave=0
    let g:vimwiki_ext2syntax = {'.md': 'markdown'}

    let wiki = {}
    let wiki.path = '~/vimwiki/'
    let wiki.syntax = 'markdown'
    let wiki.ext = '.md'
    let wiki.automatic_nested_syntaxes = 1
    let wiki.auto_tags = 1
    let g:vimwiki_list = [wiki]

call plug#end()




" FastFold
let g:fastfold_savehook=0

" color scheme
let g:molokai_original=0
colorscheme molokai

" settings for Rooter ====================================================
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['.rootmarker', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
" run the rooter plugin after a session is loaded
autocmd BufRead,BufNewFile * Rooter

" settings for fugitive ==================================================
" close fugitive buffers when they are not shown anymore
autocmd BufReadPost fugitive://* set bufhidden=wipe

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
" let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:ackprg = 'ag --nogroup --nocolor --column'

" settings for Ferret ====================================================
let g:FerretMap = 0 " do not setup mappings
" define the command as Rg because, seriously, that's shorter
" command! -bang -nargs=1 -complete=customlist,ferret#private#ackcomplete Rg call ferret#private#ack(<bang>0, <q-args>)

" settings for Grepper ===================================================
" let g:grepper = {}
runtime plugin/grepper.vim
let g:grepper.stop = 500
let g:grepper.highlight = 1
let g:grepper.prompt = 0
let g:grepper.rg.grepprg .= ' --smart-case --sort path'
" let g:grepper.rg = {}
" let g:grepper.rg.grepprg = '~/scripts/rg -H --no-heading --vimgrep --no-messages'

function! s:ExecuteGrepper(tool, args)
    execute("Grepper -tool ".a:tool." -query ".a:args)
endfunction
command! -nargs=1 Rg call s:ExecuteGrepper('rg', <q-args>)
command! -nargs=1 Grep call s:ExecuteGrepper('grep', <q-args>)

" settings for gitv ======================================================
let g:Gitv_OpenHorizontal='auto'

" settings for vimwiki ===================================================
" let g:vimwiki_folding = 'expr'
" let g:vimwiki_folding = 'marker' " no folding

" settings for pandoc ====================================================
let g:pandoc#folding#fdc = 0
" let g:pandoc#formatting#mode = 'hA'
let g:pandoc#modules#disabled = ["keyboard", "folding"]
let g:pandoc#command#latex_engine = 'pdflatex'
let g:pandoc#spell#default_langs = ['en', 'nl']
let g:pandoc#syntax#conceal#blacklist = ['atx', 'list']
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ['bash=sh', 'python', 'ruby', 'html', 'php', 'yaml', 'vim', 'conf', 'sql']
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 0

" settings for ctrlp =====================================================
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles=0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['tag', 'buffertag', 'filetype', 'tjump'] ", 'funky']
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
" Use ripgrep for ctrlp if available
if executable('/opt/ripgrep/rg')
    let g:ctrlp_user_command = "rg --files %s"
    let g:ctrlp_use_caching = 0
endif

" settings for ripgrep ===================================================
let g:rg_binary = "rg --no-messages"
let g:rg_highlight = 'true'

" settings for Airline ===================================================

" setting for colorizer ==================================================
" do not map anything
let g:colorizer_nomap = 1

" settings for quickfixsigns =============================================
let g:quickfixsigns_classes = ['marks', 'vcsdiff', 'qfl']
let g:quickfixsigns#marks#texthl = 'Type'

" settings for neocomplecache ============================================
" let g:neocomplcache_enable_at_startup = 1
" settings for neocomplete ============================================
let g:neocomplete#enable_at_startup=0

" settings form mucomplete ===============================================
set completeopt=menuone,noinsert

" inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
" inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
" inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

let g:mucomplete#enable_auto_at_startup = 0

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

" settings for Bonly =====================================================
" Delete all the other buffers with \B
nnoremap <silent> <leader>B :Bonly<CR>:tabonly<CR>

" settings for ultisnips =================================================
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]
" let g:UltiSnipsNoPythonWarning = 1

" settings for minisnip ==================================================
let g:minisnip_trigger = '<C-j>'

" settings for tslime ====================================================
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" settings for detectindent ==============================================
let g:detectindent_preferred_expandtab=1
" automatically try to detect correct indent
autocmd BufReadPost * :DetectIndent

" settings for indent lines ==============================================
let g:indentLine_color_gui='#31373a'
let g:indentLine_char='│'
let g:indentLine_indentLevel=7
" let g:indentLine_noConcealCursor=1
let g:indentLine_concealcursor = 'nc'

" settings for clever-f
let g:clever_f_across_no_line=1
let g:clever_f_timeout_ms=1
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

" settings for Highlightedyank ===========================================
" if !exists('##TextYankPost')
"     map y <Plug>(highlightedyank)
" endif
