" syn match VimwikiDateAdded /\v\[\d{4}-\d\d-\d\d\]/
" hi link VimwikiDateAdded Comment

" syn match VimwikiHeader2Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader2
" syn match VimwikiHeader3Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader3
" syn match VimwikiHeader4Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader4


syn match xVimwikiDate /\v(\*|^)\d{4}-\d\d-\d\d( \d\d:\d\d)?(\*)?/ containedin=VimwikiHeader1,VimwikiHeader2,VimwikiHeader3,VimwikiHeader4,VimwikiHeader5,VimwikiHeader6
hi link xVimwikiDate Comment

syn match xVimwikiEsitmate /\v\[\d+([\.,]\d+)?[udh]\]/
hi link xVimwikiEsitmate VimwikiHeader4

syn match xVimwikiIssueNumber /\v(#\d+|\w+-\d+)/
hi link xVimwikiIssueNumber VimwikiHeader1

syn match xVimwikiMainTitle /\v^\%\s.+/

syntax match VimwikiTodo /\C\%(DISCUSS:\|ISSUE:\|TODO:\|STARTED:\|FIXME:\|FIXED:\|XXX:\)/
syntax match xVimwikiTodoBlue /\C\%(DISCUSS:\)/
hi link xVimwikiTodoBlue MatchParen
syntax match xVimwikiTodoRed /\C\%(ISSUE:\)/
hi link xVimwikiTodoRed User1

syntax match xVimwikiTodoDone /\C\%(D̶I̶S̶C̶U̶S̶S̶:\|I̶S̶S̶U̶E̶:\|T̶O̶D̶O̶:\|X̶X̶X̶:\|D̶O̶N̶E̶:\)/
" hi link xVimwikiTodoDone xVimwikiTodoDone

syntax match xVimwikiFootnote /\C\[\^\w\{-}\]/
hi link xVimwikiFootnote Character

