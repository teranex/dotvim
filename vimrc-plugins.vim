call plug#begin('~/.vim/plugged')

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

Plug 't9md/vim-quickhl'
    nmap <leader>m <Plug>(quickhl-manual-this)
    xmap <leader>m <Plug>(quickhl-manual-this)

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

Plug 'SirVer/ultisnips'
"     let g:UltiSnipsExpandTrigger="<c-j>"
"     let g:UltiSnipsJumpForwardTrigger="<c-b>"
"     let g:UltiSnipsJumpBackwardTrigger="<c-z>"

call plug#end()

