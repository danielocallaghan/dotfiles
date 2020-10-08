set nocompatible              " be iMproved, required filetype off                  " required

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'ecomba/vim-ruby-refactoring' " https://github.com/ecomba/vim-ruby-refactoring
Plug 'skwp/YankRing.vim'
Plug 'git-mirror/vim-l9'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/snipmate-snippets'
Plug 'scrooloose/nerdtree'
Plug 'tjennings/git-grep-vim'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/molokai'
Plug 'spf13/vim-colors'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'adelarsq/vim-matchit'
Plug 'ngmy/vim-rubocop'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'scrooloose/syntastic'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'leafgarland/typescript-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'udalov/kotlin-vim'
Plug 'keith/swift.vim'
Plug 'dense-analysis/ale'
Plug 'bufbuild/vim-buf'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" == general config ==
set number
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
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
" Keep search hit centered
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz

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
" Get rid of the delay when hitting esc!
set noesckeys

" ================ Indentation ======================
set smartindent
set expandtab
set softtabstop=2
" set pastetoggle=<F2>
set tabstop=2
set smarttab
set shiftwidth=2
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set autoindent
set nowrap       "Don't wrap lines
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or
set maxmempattern=3000

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
set scrolloff=12         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1


if has("statusline") && !&cp
  set laststatus=2              " always show the status bar
  set statusline=%f\ %m\ %r     " filename, modified, readonly
  set statusline+=%{fugitive#statusline()}
  set statusline+=\ %l/%L[%p%%] " current line/total lines
  set statusline+=\ %v[0x%B]    " current column [hex char]
endif

syntax on
filetype off
filetype plugin indent on

au BufNewFile,BufRead,BufWrite *.dump set filetype=sql
au BufNewFile,BufRead,BufWrite Gemfile,Gemfile.lock,config.ru,*.rabl set filetype=ruby
au BufNewFile,BufRead,BufWrite *.yml set filetype=yaml
au BufNewFile,BufRead,BufWrite *.json set filetype=javascript
au BufNewFile,BufRead,BufWrite *.es6 set filetype=javascript

"ruby
" Disable that goddamn 'Entering Ex mode. Type 'visual' to go to Normal mode.'
" that I trigger 40x a day.
map Q <Nop>
" Disable K looking stuff up
map K <Nop>

" These are very similar keys. Typing 'a will jump to the line in the current
" file marked with ma. However, `a will jump to the line and column marked
" with ma.  It’s more useful in any case I can imagine, but it’s located way
" off in the corner of the keyboard. The best way to handle this is just to
" swap them: http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

""""""""""" Move around splits """""""""""""""""
map <leader>h :wincmd h<cr>
map <leader>j :wincmd j<cr>
map <leader>k :wincmd k<cr>
map <leader>l :wincmd l<cr>
" TODO: Below now maps to jump up/down by method/block, need to think of a better
" binding
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"""""""""""" GUI/Look & Feel """""""""""""""
colorscheme molokai
set background=dark
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guifont=Menlo\ Regular:h13 " solarized bg: 002933
hi normal guibg=#002933
hi LineNr guifg=#9C9C9C guibg=NONE ctermbg=NONE ctermfg=DarkGrey
hi TabLineSel ctermfg=white cterm=bold " improve autocomplete menu color
hi Tabline ctermfg=LightGrey ctermbg=NONE gui=NONE guifg=DarkGrey cterm=NONE
" hi Search gui=underline cterm=underline guifg=#FFFFFF guibg=#303030
hi Search gui=NONE cterm=NONE guifg=#FFFFFF guibg=#303030
set cul
hi CursorLine term=none cterm=none ctermbg=none gui=none guibg=#053437
hi CursorLineNR guifg=#9C9C9C

" Golang
" au FileType go nmap <leader>r <Plug>(go-run)
" au FIleType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)

" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FiLeType go nmap <Leader>dt <Plug>(go-def-tab)

" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Run gofmt and goimports on save
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

let g:mix_format_on_save = 1

let g:ackprg = 'ag --nogroup --nocolor --column'

"""""""""""""""""""""""""""""""""""""""""""""
"""""        Misc Editing       """""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
" break undo operations into smaller chunks (per line)
inoremap <CR> <C-G>u<CR>
map <leader>y "*y
map <leader>Y "*Y
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
" nnoremap ei( f(ci(

nnoremap <D-[> f[ci[
nnoremap <D-]> f]ci]
" nnoremap ei[ f[ci[

nnoremap <D-{> f{ci{
" nnoremap ei{ f{ci{

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Line Bubbling
nmap <D-k> [e
nmap <D-j> ]e
vmap <D-k> [egv
vmap <D-j> ]egv

" move up/down quickly by using C-j, C-k
" which will move us around by functions
noremap <silent> <C-j> 5j
noremap <silent> <C-k> 5k

""""""""""""""" Paste Behaviour Tweaks """"""""""""""""""""
" Use black hole register ("_) for the deletion so the unnamed register is not changed
" nnoremap S "_diwP
" vnoremap S "_d"0P
" reselect and re-yank any text that is pasted in visual mode
xnoremap p pgvy

" paste lines from unnamed register and fix indentation
map <leader>p pV`]=
nmap <leader>P PV`]=
 " yg_ -> yank til last char in the current line.
nmap $ g_


imap <silent> <D-d> _
imap <C-y> <space>=><space>

"""""""""""""" Tab/Buffer Navigation """"""""""""""""""""""
nmap <C-Tab> :tabn<CR>
nmap <D-d> :tabnew<CR>:FZF<CR>
nmap <C-S-Tab> :tabp<CR>
nmap <D-right> :tabn<CR>
nmap <D-left> :tabp<CR>
imap <D-right> <esc>:tabn<CR>
imap <D-left> <esc>:tabp<CR>
map <F10> :tabmove -1<CR>
map <F12> :tabmove +1<CR>
nmap <leader>tm :tabmove +1<CR>
nmap <leader>tM :tabmove -1<CR>

" toggle between most recently opened buffer
nnoremap <leader><leader> <c-^>
nnoremap <silent><leader><C-]> <C-w><C-]><C-w>T

cmap w!! w !sudo tee % >/dev/null

"""""""""""""" Moving around within a file """""""""""""""
"""""""""""""" Arrow Key Evasion bindings  """"""""""""""""
cnoremap <C-a> <Home>
nnoremap <C-e> $
nnoremap <C-a> ^
imap <C-a> <C-o>^
imap <C-e> <C-o>$
vnoremap <C-e> $
vnoremap <C-a> ^

cnoremap <C-h> <left>
cnoremap <C-l> <right>
cnoremap <D-l> <right>

imap <C-h> <left>
imap <C-l> <right>
imap <D-l> <right>

nnoremap <C-y> 3<C-y>

inoremap jk <esc>
inoremap kj <esc>
nnoremap ,ag :Ack ""<left>
nnoremap ,gg :GitGrep ""<left>
nnoremap ,ff :FZF<CR>
nnoremap ,fm /def\s\(self\.\)\?
nnoremap ,fr :%s///c<left><left><left>
nnoremap ,chs :%s/:\([^ ]*\)\(\s*\)=>/\1:/c

cnoremap fj %!python -m json.tool
cnoremap vfj !python -m json.tool

""""""""""""" Plugin Configs """"""""""""""""""""
let g:netrw_preview=1 " preview window shown in a vertically split
let g:netrw_winsize=20
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
map <silent> <leader>ntt :NERDTreeToggle<cr>
map <silent> <leader>ntf :NERDTree<cr><leader>l<cr>:NERDTreeFind<cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

command! FZFOpen call fzf#run({'source': 'git ls-files', 'sink': 'tab drop', 'down': '40%'})
nmap <leader>ff :FZFOpen<CR>
nmap cp :FZFOpen<CR>

map <silent> <leader>cpb :CtrlPBookmarkDir<CR>
map <leader>F :CtrlP %%<CR>
nmap <leader>B :CtrlPBuffer<CR>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<c-op>'
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|coverage$',
  \ 'file': '\v\.(exe|so|dll|.DS_Store)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  \ }
let g:ctrlp_user_command = {
  \ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
  \ },
  \ 'fallback': 'find %s -type f'
  \ }

let g:vimrubocop_config = '~/.rubocop.yml'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: Debug this, not working in all file types
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

function! s:ChangeHashSyntax(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/:\([a-z0-9_]\+\)\s\+=>/\1:/g'
    call setpos('.', l:save_cursor)
endfunction
command! -range=% ChangeHashSyntax call <SID>ChangeHashSyntax(<line1>,<line2>)

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

function! Smart_TabComplete()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.'))        " from start to cursor
  let substr = matchstr(substr, "[^ \t.]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" copy current file name (relative/absolute) to system clipboard
" relative path  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>

" vim ruby refactoring plugin
nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rapnb :RAddParameterNB<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>

map <leader>ed orequire IEx;<cr>IEx.pry()<esc>:w<cr>
map <leader>d obinding.pry<esc>:w<cr>
map <leader>bb obyebug<esc>:w<cr>
map <leader>rd oRails.logger.debug("")<left><left>

map <leader>mf :MixFormat<cr>

let g:user_emmet_leader_key='<D-e>'
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,erb,xml,haml EmmetInstall

" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" let g:go_list_type = "quickfix"

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" let g:ale_linters = {
"   \ 'go': ['gopls'],
"   \ 'proto': ['buf-check-lint']
"   \ }

let g:ale_go_langserver_executable = 'gopls'
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_linters_explicit = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
nmap <silent> <C-l> <Plug>(ale_next_wrap)

" Required for operations modifying multiple buffers like rename.
set hidden

    " \ 'javascript': ['/Users/daniel/.nvm/versions/node/v10.16.0/bin/typescript-language-server', '--stdio'],
    " \ 'go': ['gopls']
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['solargraph', 'stdio']
    \ }

let g:LanguageClient_loggingLevel = 'DEBUG'

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" clash with vim-go version
nnoremap <silent> <leader>gd :call LanguageClient#textDocument_definition({ 'gotoCmd': 'tab drop' })<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition({ 'gotoCmd': 'tab drop' })<CR>
nnoremap <c-r>] :call LanguageClient#textDocument_definition({ 'gotoCmd': 'tab drop' })<CR>
nnoremap <silent> <leader>rn :call LanguageClient#textDocument_rename()<CR>
