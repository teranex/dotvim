syn match VimwikiTag /@[a-zA-Z0-9:_-]\+/
hi link VimwikiTag VimwikiTodo

syn match VimwikiDate /(\d\d\d\d-\d\d-\d\d\( \d\d:\d\d\)\?)/
hi link VimwikiDate VimwikiCheckBox
