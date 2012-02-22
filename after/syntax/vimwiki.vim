syn match VimwikiTag /\v\@[a-zA-Z0-9:_-]+/
hi link VimwikiTag VimwikiTodo

syn match VimwikiDate /\v\(\d{4}-\d\d-\d\d( \d\d:\d\d)?\)/
hi link VimwikiDate VimwikiCheckBox
