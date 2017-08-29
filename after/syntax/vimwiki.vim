" syn match VimwikiDateAdded /\v\[\d{4}-\d\d-\d\d\]/
" hi link VimwikiDateAdded Comment

" syn match VimwikiHeader2Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader2
" syn match VimwikiHeader3Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader3
" syn match VimwikiHeader4Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader4


syn match xVimwikiDate /\v(\[|^)\d{4}-\d\d-\d\d( \d\d:\d\d)?(\])?/ containedin=VimwikiHeader1,VimwikiHeader2,VimwikiHeader3,VimwikiHeader4,VimwikiHeader5,VimwikiHeader6
hi link xVimwikiDate Comment

syn match xVimwikiEsitmate /\v\[\d+[ud]\]/
hi link xVimwikiEsitmate VimwikiHeader4

syn match xVimwikiMainTitle /\v^\%\s.+/
