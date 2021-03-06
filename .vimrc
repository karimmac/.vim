" Karim's VIM configuration

set rtp+=~/vimfiles " newer Windows Git switched from vimfiles to .vim .

set encoding=utf-8 " default encoding for files
set hidden
set nocompatible " Docs suggest this isn't really needed...
set noswapfile  " modern times, vim
set modeline    " read mode line
set modelines=10
set vb          " use a visual flash instead of beeping
set ru          " display column, line numbers
set ai          " always do autoindenting
set sw=2        " indent 2 spaces
set sts=2       " tabstop 2 spaces
set tw=78       " limit text to 78 spaces
set nu           " line numbers please
set listchars=tab:^.,trail:?
set scrolloff=2 " always leave 2 lines above/below cursor
set wildmenu    " pop menu with completions
set wildmode=list:longest,full
set backspace=indent,eol,start
set list        " show tabs
syn on          " enable syntax highlighting

" Search options
set gdefault    " :%s/foo/bar replaces in whole file not just current line
set hlsearch    " incremental search highlighting
set ignorecase  " ignore case in search patterns ...
set smartcase   " ... unless pattern contains uppercase
set incsearch   " do incremental searching

" Bundle options
" Initialise pathogen to load plugins from .vim/bundle
execute pathogen#infect()

" Shenanigans to get 256 colours in Cmder on Windows
" unfortunately one-linifies Vim in a non-Cmder Win prompt.
set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

" Text colouring
colo sri                " use sri's colorscheme: https://github.com/tempire/dotvim/blob/master/colors/sri.vim (modified)
                        " ... except the shitty distracting cyan brace matching
highlight MatchParen cterm=bold ctermfg=cyan ctermbg=black

" Rainbow parentheses!
let g:rbpt_colorpairs = [
    \ ['magenta',     'purple1'],
    \ ['cyan',        'magenta1'],
    \ ['green',       'slateblue1'],
    \ ['yellow',      'cyan1'],
    \ ['red',         'springgreen1'],
    \ ['magenta',     'green1'],
    \ ['cyan',        'greenyellow'],
    \ ['green',       'yellow1'],
    \ ['yellow',      'orange1'],
    \ ]
let g:rbpt_max = 9

if has("autocmd")
  "au VimEnter * RainbowParenthesesToggle
  au BufEnter * RainbowParenthesesToggle
  au BufLeave * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

  filetype plugin indent on

  " Turn off line wrap for common files
  au BufNewFile,BufRead db.*    setlocal nowrap
  au BufNewFile,BufRead /etc/*  setlocal nowrap

  au BufNewFile,BufRead,StdinReadPost *
    \ let s:l1 = getline(1) |
    \ if s:l1 =~ '^Return-Path: ' |
    \   setf mail |
    \ endif

  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Filetype customisations
  au BufRead,BufNewFile *.go  set filetype=go
  au FileType html            setl sw=2 sts=2 expandtab list tw=0 nowrap
  au FileType scss,css        setl sw=2 sts=2 expandtab list tw=0
  au FileType ruby            setl sw=2 sts=2 expandtab list
  au FileType javascript      setl sw=2 sts=2 expandtab list
  au FileType h,c,cpp         setl sw=4 sts=4 tw=4 expandtab list
endif

"
" Keyboard shortcuts
"

" Move up and down by screen lines not file lines
nnoremap j gj
nnoremap k gk

" Hitting F1 accidentally should be the same as escape!
inoremap <f1> <esc>
nnoremap <f1> <esc>
vnoremap <f1> <esc>

" start leader commands with comma instead of the default backslash
let mapleader = ","

" Strip all trailing while space with ,w
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>

" Fold HTML tags with ,ft
nnoremap <leader>ft Vatzf
" Fold paragraphs with ,fp
nnoremap <leader>fp Vapzf

" Split window and move to new pane with ,v
nnoremap <leader>v <C-w>v<C-w>l<cr>
" Horizontal split with ,s
nnoremap <leader>s <C-w>s<C-w>j<cr>

" taglist bindings
nnoremap <leader>tt :TlistToggle<cr>
nnoremap <leader>ts :TlistSync<cr>
nnoremap <leader>tu :TlistUpdate<cr>

" Clear annoying search highlighting with ', '
map <leader><space> :noh<cr>

" Center the current diff hunk when navigating diffs
nmap ]c ]czz
nmap [c [czz

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" :W should save as well
command W w
command Wq wq
command WQ wq
command Q q
