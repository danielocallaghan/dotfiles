
autocmd rooter BufEnter *.ru :Rooter
autocmd rooter BufEnter *.rb :Rooter
autocmd rooter BufEnter *.feature :Rooter
autocmd rooter BufEnter *.js :Rooter
autocmd rooter BufEnter *.coffee :Rooter
autocmd rooter BufEnter *.haml :Rooter
autocmd rooter BufEnter *.html :Rooter
autocmd rooter BufEnter *.css :Rooter
autocmd rooter BufEnter *.sass :Rooter
autocmd rooter BufEnter *.scss :Rooter
autocmd rooter BufEnter *.yml :Rooter
autocmd rooter BufEnter *.rake :Rooter
autocmd rooter BufEnter config.ru :Rooter
autocmd rooter BufEnter Gemfile :Rooter
autocmd rooter BufEnter Rakefile :Rooter
autocmd rooter BufEnter Procfile :Rooter

let g:rooter_patterns = [ '.root', 'Gemfile', 'config.ru', 'Rakefile', '.git/']

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

""improve autocomplete menu color
hi Pmenu ctermbg=LightGrey guifg=white gui=bold
hi PmenuSel ctermbg=NONE ctermfg=Yellow ctermbg=NONE cterm=bold
hi TabLineSel ctermfg=white cterm=bold
hi TabLine ctermfg=LightGrey ctermbg=NONE gui=NONE guifg=DarkGrey cterm=NONE

