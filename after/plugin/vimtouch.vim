" only execute if we are running on Android (Vim Touch)
if $VIM =~? 'vimtouch'
    " if no file was provided, load the vimwiki session
    if len(argv()) == 0
        SessionOpen vimwiki
    endif
endif
