vmap iH :call SelectLeft('i')<CR>
vmap aH :call SelectLeft('a')<CR>
vmap iL :call SelectRight('i')<CR>
vmap aL :call SelectRight('a')<CR>

omap iL :normal viL<CR>
omap aL :normal vaL<CR>
omap iH :normal viH<CR>
omap aH :normal vaH<CR>

function! SelectLeft(inner_or_all)
  let iStart = FindEqualSign()
  if a:inner_or_all == 'i'
    let iStart = iStart - 1

    if getline('.')[iStart -1] == ' '
      let iStart = iStart - 1
    endif
  endif

  call feedkeys(iStart.'|v^')
endfunction

function! SelectRight(inner_or_all)
  let iStart = FindEqualSign()

  if a:inner_or_all == 'i'
    let nextChar = getline('.')[iStart]

    if (nextChar == '>' || nextChar == '=')
      let iStart = iStart + 2
    else
      let iStart = iStart + 1
    endif

    "if there is a space, shift one more
    if getline('.')[iStart - 1] == ' '
      let iStart = iStart + 1
    endif
  endif

  if a:inner_or_all == 'i'
    call feedkeys(iStart.'|v$h')
  else
    call feedkeys(iStart.'|v$')
  endif
endfunction

function! FindEqualSign()
  let line = getline('.')
  let i = 0 

  while i >= 0
    if (line[i] == '=') || (line[i] == '-' && line[i + 1] == '>')
      return i + 1
    endif

    let i = i + 1
  endwhile
endfunction
