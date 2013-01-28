let s:source = {
      \ 'name' : 'ultisnips_complete',
      \ 'kind' : 'plugin',
      \}

function! s:source.initialize()
endfunction

function! s:source.finalize()
endfunction

function! s:source.get_keyword_list(cur_keyword_str)
  let l:snips = []
python << EOF
import vim
from UltiSnips import UltiSnips_Manager
snippets = UltiSnips_Manager._snips(vim.eval('a:cur_keyword_str'), True)
snippets.sort(key=lambda x: x.trigger)
snips = ["{'word': '%s', 'menu': '[Snip] %s'}" % (s.trigger, s.description) for s in snippets]
for snip in snips:
    vim.eval("add(l:snips, " + snip + ")")
EOF
  return l:snips
endfunction

function! neocomplcache#sources#ultisnips_complete#define()
  return s:source
endfunction

