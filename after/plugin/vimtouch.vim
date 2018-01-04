" only execute if we are running on Android (Vim Touch)
" if $VIM =~? 'vimtouch'
"     " if no file was provided, load the vimwiki session
"     if len(argv()) == 0
"         " SessionOpen vimwiki
"         cd ~/vimwiki/
"         autocmd VimEnter * CtrlP
"     endif
" endif

if $VIM =~? 'droidvim' && argc() == 0
    " we are running on DroidVim
    cd ~/vimwiki/
    exe "silent e diary/".strftime("%Y-%m-%d").".md"
endif
