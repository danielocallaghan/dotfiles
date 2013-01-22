set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2
set pastetoggle=<F2>
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab

noremap <F6> :bnext!<CR>
noremap <F5> :bprev!<CR>
inoremap <F6> :bnext!<CR>
inoremap <F5> :bprev!<CR>
noremap <F8> :tabnext<CR>
noremap <F7> :tabprev!<CR>
inoremap <F8> :tabnext!<CR>
inoremap <F7> :tabprev!<CR>

call pathogen#infect()
syntax on
filetype off
filetype plugin indent on
au BufNewFile,BufRead,BufWrite *.dump set filetype=sql
au BufNewFile,BufRead,BufWrite Gemfile,Gemfile.lock,config.ru,*.rabl set filetype=ruby
au BufNewFile,BufRead,BufWrite *.yml set filetype=yaml
au BufNewFile,BufRead,BufWrite *.json set filetype=javascript
autocmd FileType sh,spec,c,cpp,python,ruby,java,yaml,javascript,html,css autocmd BufWritePre <buffer> :%s/\s\+$//e

map <leader>h              :wincmd h<cr>
map <leader>j              :wincmd j<cr>
map <leader>k              :wincmd k<cr>
map <leader>l              :wincmd l<cr>

colorscheme molokai

"  autocmd vimenter * if !argc() | NERDTree | endif

inoremap jk <esc>
inoremap kj <esc>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
