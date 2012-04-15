" My vimrc. Based on a config kindly provided by auxesis.
" Some more inspiration from:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

set directory=~/.vim/tmp
set viminfo='100,f1

" How long key sequences can take to complete
set timeoutlen=250

" Color and color schemes
set t_Co=256
set background=dark
colorscheme tuneafish

" Set the window title (like xterm)
set title

" Display
syntax on
set nowrap
set number
set ruler
set nofoldenable
"set cursorline
set scrolloff=5
set wildmenu
set wildmode=list:longest
set laststatus=2

" Powerline plugin
let g:Powerline_symbols = 'unicode'
" Remove mode indicator
call Pl#Theme#RemoveSegment('mode_indicator')

set backspace=indent,eol,start

" This only works since vim 7.3
if version >= 703
  set colorcolumn=81
  hi ColorColumn ctermbg=235

  " Encryption
  set cryptmethod=blowfish
endif

" Searching behavior
set ignorecase
set smartcase
set incsearch

" Indentation
set autoindent
set smartindent
set ts=8
set sw=8

" Set leader key
let mapleader=","

" Filetypes
filetype on
filetype plugin on
filetype indent on

" Set listchars and disable list by default
set listchars=trail:.,extends:>,tab:>-
set nolist

if &termencoding == "utf-8"
  set encoding=utf-8
endif

au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile *.rb set filetype=ruby.rspec
au BufRead,BufNewFile *.sub set filetype=sh
au BufRead,BufNewFile *.js set filetype=javascript.node

au FileType python set ts=4 sw=4 tw=100 sts=4 expandtab list
au FileType ruby set ts=2 sw=2 tw=100 sts=2 expandtab list
au FileType javascript set ts=2 sw=2 tw=100 sts=2 expandtab list
au FileType html set ts=2 sw=2 tw=100 sts=2 expandtab list nosmartindent
au FileType eruby set ts=2 sw=2 expandtab list
au FileType haml set ts=2 sw=2 expandtab list
au FileType css set expandtab list
au FileType cucumber set ts=2 sw=2 expandtab list
au FileType markdown set ai formatoptions=tcroqn2 comments=n:> list
au FileType sh set nolist noexpandtab
au FileType puppet set ts=2 sw=2 tw=100 sts=2 expandtab list

" F2 enables paste mode.
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Easier navigation for split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" F6 replace all ^M
map <F6> <esc>:%s,\r,,g<cr>

" F8 sets encoding to utf-8
map <F8> <esc>:set encoding=utf-8<cr>

" CTRL+b opens the buffer list
map <C-b> <esc>:BufExplorer<cr>

" gz in command mode closes the current buffer
map gz :bdelete<cr>

" g[bB] in command mode switch to the next/prev. buffer
map gb :bnext<cr>
map gB :bprev<cr>

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
"
" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

"au FileWritePre * :call TrimWhiteSpace()
"au FileAppendPre * :call TrimWhiteSpace()
"au FilterWritePre * :call TrimWhiteSpace()
"au BufWritePre * :call TrimWhiteSpace()

" Highlight trailing whitespace with a warning color.
highlight TrailingWhitespace ctermbg=88
" Match extra whitespace in all windows ...
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
" ... but not in insert mode
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Map <leader>w to manually removing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Highlight VCS conflict marker
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
