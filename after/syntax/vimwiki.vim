syn match VimwikiDateAdded /\v\[\d{4}-\d\d-\d\d\]/
hi link VimwikiDateAdded Comment

syn match VimwikiHeader2Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader2
syn match VimwikiHeader3Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader3
syn match VimwikiHeader4Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader4
