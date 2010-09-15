" BOFAS -------------------------------
cd ~/Projecten/Bofas/bofas/

set wildignore=/home/jeroen/Projecten/Bofas/bofas/library/Zend/**

setlocal tags=~/Projecten/Bofas/bofas/tags
setlocal noautochdir
setlocal makeprg=ant\ -find\ build.xml

"grep current cursor word in project. to provide 'find usages'
map <F12> :execute "noautocmd vimgrep /" . expand("<cword>") . "/j ~/Projecten/Bofas/bofas/application/**/*.php ~/Projecten/Bofas/bofas/tests/**/*.php ~/Projecten/Bofas/bofas/library/Bofas/**/*.php" <Bar> cw<CR>

