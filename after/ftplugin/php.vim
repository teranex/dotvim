" fix indent of the entire block when inserting }.
inoremap } }<ESC>m'=iB`'a
setlocal fdm=indent
syn sync fromstart
