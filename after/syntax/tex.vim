" Match natbib citations
syn match  texRefZone		'\\cite\%([a-z]*\*\=\)\=' nextgroup=texRefOption,texCite
syn match  texStatement         '\\citetext'
" Match the most commmon hyperref commands
syn region texRefZone		matchgroup=texStatement start="\\v\=autoref{"		end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\v\=url{"		end="}\|%stopzone\>"	contains=@texRefGroup

