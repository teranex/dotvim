syn match VimwikiTag /\v\@[a-zA-Z0-9:_-]+/ containedin=VimwikiTableRow
hi link VimwikiTag VimwikiTodo

syn match VimwikiDate /\v\(\d{4}-\d\d-\d\d( \d\d:\d\d)?\)/
hi link VimwikiDate VimwikiCheckBox

syn match VimwikiDateAdded /\v\[\d{4}-\d\d-\d\d\]/
hi link VimwikiDateAdded Comment

syn match VimwikiNoteDate /\v^\d{4}-\d\d-\d\d \d\d:\d\d/
syn match VimwikiNoteHeader /\v^\d{4}-\d\d-\d\d \d\d:\d\d .*/ contains=VimwikiNoteDate,VimwikiTag
