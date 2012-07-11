let g:Powerline#Segments#trex#segments = Pl#Segment#Init(['trex',
    \ Pl#Segment#Create('bufnumber', '#%n'),
    \ Pl#Segment#Create('root_indicator', "%{$SUDO_USER != ''?'ROOT!':''}"),
	\ Pl#Segment#Create('lineinfo',
		\ Pl#Segment#Create('line.cur'    , '%3l'),
        \ Pl#Segment#Create('line.lines'  , '/%L'),
		\ Pl#Segment#Create('line.tot'    , ':%-2v', Pl#Segment#NoPadding()),
	\ ),
\ ])
