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
" Bundle 'airblade/vim-rooter'
" Bundle 'Lokaltog/vim-easymotion'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'tjennings/git-grep-vim'
" Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'rubycomplete.vim'
" Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/molokai'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'spf13/vim-colors'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'delimitMate.vim'

" == general config ==
set number
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
" set gcr=a:blinkon0              "Disable cursor blink
set guicursor=a:blinkon1000
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
let macvim_skip_cmd_opt_movement = 1
let mapleader=','
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" == search settings ==
set hlsearch         "Hilight searches by default
set incsearch        "Find the next match as we type the search
set ignorecase
set smartcase
nmap <silent> <leader>/ :nohlsearch<CR>
nmap <CR> :nohlsearch<CR>

set gdefault
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb
" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=100
" ================ Indentation ======================
set smartindent
set expandtab
set softtabstop=2
set pastetoggle=<F2>
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set nowrap       "Don't wrap lines
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================
set wildmode=longest,list
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
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

if has("statusline") && !&cp
  set laststatus=2              " always show the status bar
  set statusline=%f\ %m\ %r     " filename, modified, readonly
  set statusline+=%{fugitive#statusline()}
  set statusline+=\ %l/%L[%p%%] " current line/total lines
  set statusline+=\ %v[0x%B]    " current column [hex char]
endif

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <C-k> 10k
nnoremap <C-j> 10j

syntax on
filetype off
filetype plugin indent on
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

au BufNewFile,BufRead,BufWrite *.dump set filetype=sql
au BufNewFile,BufRead,BufWrite Gemfile,Gemfile.lock,config.ru,*.rabl set filetype=ruby
au BufNewFile,BufRead,BufWrite *.yml set filetype=yaml
au BufNewFile,BufRead,BufWrite *.json set filetype=javascript

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1


""""""""""" Move around splits """""""""""""""""
map <leader>h              :wincmd h<cr>
map <leader>j              :wincmd j<cr>
map <leader>k              :wincmd k<cr>
map <leader>l              :wincmd l<cr>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"""""""""""" GUI/Look & Feel """""""""""""""
set background=dark
if has('gui_running')
  colorscheme molokai
endif
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guifont=Menlo\ Regular:h13 " solarized bg: 002933
hi normal guibg=#002933
hi LineNr guifg=#9C9C9C guibg=NONE
""improve autocomplete menu color
hi TabLineSel ctermfg=white cterm=bold
hi TabLine ctermfg=LightGrey ctermbg=NONE gui=NONE guifg=DarkGrey cterm=NONE


"""""""""""""""""""""""""""""""""""""""""""""
"""""        Misc Editing       """""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" overwrite word, replace a word with what's in the yank buffer
nnoremap ,ow "_diwhp
" ,# Surround a word with #{ruby interpolation}
map ,# ysiw#
vmap ,# c#{<C-R>"}<ESC>
" ," Surround a word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>
" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>
" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c(<C-R>")<ESC>
vmap ,) c(<C-R>")<ESC>
" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>
" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw}
vmap ,} c{<C-R>"}<ESC>
vmap ,{ c{<C-R>"}<ESC>

nnoremap <D-(> f(ci(
nnoremap <D-)> f)ci)
nnoremap <D-[> f[ci[
nnoremap <D-]> f]ci]
nnoremap <D-{> f{ci{

"When typing a string, your quotes auto complete. Move past the quote
"while still in insert mode
imap <C-a> <esc>la
imap <D-l> <esc>la

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" ERB
imap <silent> <C-k> <%=   %><Esc>3hi
imap <silent> <D-k> <%=   %><Esc>3hi
imap <silent> <C-j> <%  %><Esc>2hi
imap <silent> <D-j> <%  %><Esc>2hi
" Line Bubbling
nmap <D-k> [e
nmap <D-j> ]e
vmap <D-k> [egv
vmap <D-j> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]
" paste lines from unnamed register and fix indentation
map <leader>p pV`]=
nmap <leader>P PV`]=
imap <silent> <D-d> _
imap <C-l> <space>=><space>


"""""""""""""" Tab/Buffer Navigation """""""""""""""
nmap <C-Tab> :tabn<CR>
nmap <C-S-Tab> :tabp<CR>
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>
" toggle between most recently opened buffer
nnoremap <leader><leader> <c-^>

noremap <C-s> :w<CR>
vnoremap <C-s> <C-C>:w<CR>
inoremap <C-s> <C-O>:w<CR>
cmap w!! w !sudo tee % >/dev/null
" In command-line mode, C-a jumps to beginning (to match C-e)
cnoremap <C-a> <Home>
inoremap jk <esc>
inoremap kj <esc>
" Keep search hit centered
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap ,gg :GitGrep ""<left>


""""""""""""" Plugin Configs """"""""""""""""""""
let g:netrw_preview=1 " preview window shown in a vertically split
let g:netrw_winsize=20
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
map <silent> <leader>ntt :NERDTreeToggle<CR>
map <silent> <leader>ntf :NERDTree<CR>:wincmd l<cr>p:NERDTreeFind<CR> " Show current file in NERDTree

let g:ctrlp_map = 'cp'
map <silent> <leader>cpb :CtrlPBookmarkDir<CR>
map <leader>F :CtrlP %%<CR>
nmap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = '0'
" let g:ctrlp_root_markers = [ '.root', 'Gemfile', 'config.ru', 'Rakefile', '.git/']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|.DS_Store)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  \ }
" add mapping
" <leader>gv app/views
" <leader>gv app/controllers
" <leader>gv app/models
" learn & repeat after substitution
" more normal mode keys
"     -> motion commands
" never repeat yourself
" add PromoteToLet()
" add test runner


""""""""""""" Functions """""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a tab for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "tabnew " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

nmap <leader>ocf :OpenChangedFiles<CR>

