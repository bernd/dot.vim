" My vimrc. Based on a config kindly provided by auxesis.

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
set cursorline

" Searching behavior
set ignorecase
set smartcase
set incsearch

" Indentation
set autoindent
set smartindent
set ts=8
set sw=8

" Filetypes
filetype on
filetype plugin on
filetype indent on

" Set listchars and disable list by default
set listchars=trail:.,extends:>,tab:>-
set nolist

if (&termencoding == "utf-8")
  set encoding=utf-8
endif

au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile *.haml set filetype=haml
au BufRead,BufNewFile *.sass set filetype=sass
au BufRead,BufNewFile *.feature,*.story set filetype=cucumber
au BufRead,BufNewFile *.md,*.mdown,*.markdown set filetype=markdown
au BufRead,BufNewFile *.erb set filetype=eruby
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.rb set filetype=ruby.rspec

au FileType python set ts=4 sw=4 tw=100 sts=4 expandtab list
au FileType ruby set ts=2 sw=2 tw=100 sts=2 expandtab list
au FileType javascript set ts=2 sw=2 tw=100 sts=2 expandtab list
au FileType html set ts=2 sw=2 tw=100 sts=2 expandtab list
au FileType eruby set ts=2 sw=2 expandtab list
au FileType haml set ts=2 sw=2 expandtab list
au FileType css set expandtab list
au FileType cucumber set ts=2 sw=2 expandtab list
au FileType markdown set ai formatoptions=tcroqn2 comments=n:> expandtab list

" F8 sets encoding to utf-8
map <F8> <esc>:set encoding=utf-8<cr>

" F9 opens the NERDTree
map <F9> <esc>:NERDTree<cr>

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

au FileWritePre * :call TrimWhiteSpace()
au FileAppendPre * :call TrimWhiteSpace()
au FilterWritePre * :call TrimWhiteSpace()
au BufWritePre * :call TrimWhiteSpace()
