call plug#begin('~/.vim/plugged')

" Plug 'junegunn/goyo.vim'

Plug 'vim-airline/vim-airline'
    " XXX: config see after/plugin/airline.vim

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    let g:vimwiki_hl_cb_checked=2
    let g:vimwiki_key_mappings = { 'table_mappings': 0, }
    let g:vimwiki_autowriteall=1 " automatically save
    let g:vimwiki_hl_headers=1
    let g:vimwiki_dir_link='index'
    let g:vimwiki_folding='expr:quick'
    let g:vimwiki_url_maxsave=0
    let g:vimwiki_ext2syntax = {'.md': 'markdown'}
    let g:vimwiki_listsyms = ' .oOx'

    let wiki = {}
    let wiki.path = '~/vimwiki/'
    let wiki.syntax = 'markdown'
    let wiki.ext = '.md'
    let wiki.automatic_nested_syntaxes = 1
    let wiki.auto_tags = 0
    let g:vimwiki_list = [wiki]

" Plug 'michal-h21/vim-zettel'
    " let g:zettel_use_absolute_paths = 1

Plug 'djoshea/vim-autoread'

Plug 'vim-scripts/AutoTag'

Plug 'rhysd/clever-f.vim'
    let g:clever_f_across_no_line=1
    let g:clever_f_timeout_ms=1
    nmap ; <Plug>(clever-f-repeat-forward)
    xmap ; <Plug>(clever-f-repeat-forward)
    omap ; <Plug>(clever-f-repeat-forward)
    nmap , <Plug>(clever-f-repeat-back)
    xmap , <Plug>(clever-f-repeat-back)
    omap , <Plug>(clever-f-repeat-back)

Plug 'chrisbra/color_highlight'

Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-fugitive'
    " close fugitive buffers when they are not shown anymore
    autocmd BufReadPost fugitive://* set bufhidden=wipe

Plug 'machakann/vim-highlightedyank'

Plug 'airblade/vim-rooter'
    let g:rooter_silent_chdir = 1
    let g:rooter_patterns = ['.rootmarker', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
    " run the rooter plugin after a session is loaded
    " autocmd BufRead,BufNewFile * Rooter

Plug 'airblade/vim-gitgutter'

Plug 'michaeljsmith/vim-indent-object'

Plug 'tomtom/tcomment_vim'

Plug 'Yggdroot/indentLine'
    let g:indentLine_color_gui='#31373a'
    let g:indentLine_char='│'
    let g:indentLine_indentLevel=7
    let g:indentLine_concealcursor = 'c'

Plug 'tomtom/quickfixsigns_vim'
    let g:quickfixsigns_classes = ['marks', 'qfl']
    let g:quickfixsigns#marks#texthl = 'Type'


" Plug 'inkarkat/vim-mark', { 'branch': 'stable' }
Plug 't9md/vim-quickhl'
    nmap <leader>m <Plug>(quickhl-manual-this)
    xmap <leader>m <Plug>(quickhl-manual-this)

" Plug 'axvr/zepl.vim'

" Plug 'skywind3000/vim-terminal-help'
"     let g:terminal_default_mapping = 0
"     function TerminalToggleWrap()
"         RooterToggle
"         call TerminalToggle()
"         RooterToggle
"     endfunction
"     nnoremap <silent><m-=> :call TerminalToggleWrap()<cr>
"     tnoremap <silent><m-=> <c-\><c-n>:call TerminalToggleWrap()<cr>

if $VIM =~? 'droidvim'
    Plug 'mhinz/vim-grepper'
        " XXX: config see after/plugin/grepper.vim

    Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'ivalkeen/vim-ctrlp-tjump'
        let g:ctrlp_working_path_mode = 0
        let g:ctrlp_dotfiles=0
        let g:ctrlp_follow_symlinks = 1
        let g:ctrlp_extensions = ['tag'] ", 'buffertag', 'tjump']
        let g:ctrlp_map = '<leader>t'
        let g:ctrlp_max_height = 25
        let g:ctrlp_switch_buffer = 'Et'
        let g:ctrlp_buftag_types = {'php': '--language-force=php --php-types=cdfi'}
        " let g:ctrlp_tjump_only_silent = 1
        noremap <leader>e :CtrlPCurFile<CR>
        noremap <leader>b :CtrlPBuffer<CR>
        noremap <leader>] :CtrlPTag<CR>
        noremap <leader>} :CtrlPBufTag<CR>
        " noremap <leader>s :CtrlPSession<CR>
        " nnoremap <c-]> :CtrlPtjump<cr>
        " Use ripgrep for ctrlp if available
        if executable('fd')
            echom 'using fd'
            let g:ctrlp_user_command = 'fd -c never "" "%s"'
            " let g:ctrlp_user_command = "rg --files %s"
            let g:ctrlp_use_caching = 0
        endif
else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
        noremap <leader>t :Files<CR>
        noremap <leader>b :Buffers<CR>
        noremap <leader>] :Tags<cr>
        noremap <leader>} :BTags<CR>
        let $RIPGREP_CONFIG_PATH=expand('~/.vim/misc/ripgreprc')
        let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
        if executable('fd')
            let $FZF_DEFAULT_COMMAND='fdfind --type f --no-ignore-vcs'
            let $FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'
        endif
endif

Plug 'lifepillar/vim-mucomplete'
    set completeopt=menuone,noselect
    set shortmess+=c
    let g:mucomplete#enable_auto_at_startup = 1
    let g:mucomplete#chains = {
    \ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'],
    \ 'vimwiki' : ['omni', 'ulti', 'keyn']
    \ }

Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'dense-analysis/ale'
    let g:ale_php_phpcs_standard = 'PSR2'
    let g:ale_php_phpcs_use_global = 1

" Plug 'vim-scripts/BufOnly.vim'
"     " Delete all the other buffers with \B
"     nnoremap <silent> <leader>B :Bonly<CR>:tabonly<CR>

" Plug 'ciaranm/detectindent'
"     let g:detectindent_preferred_expandtab=1
"     autocmd BufReadPost * :DetectIndent
"
call plug#end()

