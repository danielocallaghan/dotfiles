set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-ragtag'
Bundle 'skwp/YankRing.vim'
Bundle 'git-mirror/vim-l9'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'airblade/vim-rooter'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/greplace.vim'
Bundle 'tjennings/git-grep-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'rubycomplete.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/molokai'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'spf13/vim-colors'
Bundle 'vim-scripts/bufexplorer.zip'

" == general config ==
set number
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
let macvim_skip_cmd_opt_movement = 1

" == search settings ==
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set ignorecase
set smartcase
nmap <silent> ,/ :nohlsearch<CR>

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set smartindent
set expandtab
set softtabstop=2
set pastetoggle=<F2>
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent

" Display tabs and trailing spaces visually
" set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
"set linebreak    "Wrap lines at convenient points
"set wrap linebreak textwidth=0

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================
"set wildmode=list:longest
set wildmode=""
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

syntax on
filetype off
filetype plugin indent on
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

au BufNewFile,BufRead,BufWrite *.dump set filetype=sql
au BufNewFile,BufRead,BufWrite Gemfile,Gemfile.lock,config.ru,*.rabl set filetype=ruby
au BufNewFile,BufRead,BufWrite *.yml set filetype=yaml
au BufNewFile,BufRead,BufWrite *.json set filetype=javascript
"au BufAdd,BufNewFile,BufRead * nested tab sball

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

""improve autocomplete menu color
hi TabLineSel ctermfg=white cterm=bold
hi TabLine ctermfg=LightGrey ctermbg=NONE gui=NONE guifg=DarkGrey cterm=NONE

map <leader>h              :wincmd h<cr>
map <leader>j              :wincmd j<cr>
map <leader>k              :wincmd k<cr>
map <leader>l              :wincmd l<cr>

set background=dark
"colorscheme solarized
if has('gui_running')
  colorscheme molokai
endif
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guifont=Menlo\ Regular:h13 " solarized bg: 002933
hi normal guibg=#002933
hi LineNr guifg=#9C9C9C guibg=NONE

noremap <F5> :bprev!<CR>
noremap <F6> :bnext!<CR>
noremap <F8> :tabnext<CR>
noremap <F7> :tabprev!<CR>
inoremap <F5> :bprev!<CR>
inoremap <F6> :bnext!<CR>
inoremap <F7> :tabprev!<CR>
inoremap <F8> :tabnext!<CR>
nmap <C-Tab> :tabn<CR>
nmap <C-S-Tab> :tabp<CR>
noremap <C-s> :w<CR>
vnoremap <C-s> <C-C>:w<CR>
inoremap <C-s> <C-O>:w<CR>
cmap w!! w !sudo tee % >/dev/null

inoremap jk <esc>
inoremap kj <esc>

" Keep search hit centered
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Line Bubbling
nmap <D-Up> [e
nmap <D-Down> ]e
nmap <D-k> [e
nmap <D-j> ]e
vmap <D-Up> [egv
vmap <D-Down> ]egv
vmap <D-k> [egv
vmap <D-j> ]egv

imap <silent> <C-k> _
imap <silent> <C-d> -
imap <C-l> <space>=><space>
if has('gui_running')
  imap <silent> <D-k> _
  imap <silent> <D-d> -
  imap <D-l> <space>=><space>
endif

let mapleader=','

let g:netrw_preview=1 " preview window shown in a vertically split
let g:netrw_winsize=20
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
map <silent> <leader>ntt :NERDTreeToggle<CR>
map <silent> <leader>ntf :NERDTree<CR>:wincmd l<cr>p:NERDTreeFind<CR> " Show current file in NERDTree

let g:ctrlp_map = 'cp'
map <silent> <leader>cpb :CtrlPBookmarkDir<CR>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_root_markers = [ '.root', 'Gemfile', 'config.ru', 'Rakefile', '.git/']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|.DS_Store)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  \ }

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap ,w :StripTrailingWhitespaces<CR>:w<CR>
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
