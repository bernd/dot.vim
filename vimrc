" My vimrc. Based on a config kindly provided by auxesis.
" Some more inspiration from:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

set directory=~/.vim/tmp
set viminfo='100,f1

" How long key sequences can take to complete
set timeoutlen=750

" Color and color schemes
set t_Co=256
set background=dark
colorscheme solarized

" Make Ctrl+PgUp/PgDn work in tmux
if &term == "screen-256color"
  set t_kN=[6;*~
  set t_kP=[5;*~
endif

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

" Airline plugin
let g:airline_theme='ubaryd'
let g:airline_powerline_fonts=0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_linecolumn_prefix = '¶ '
let g:airline_branch_prefix = '⎇  '
let g:airline_paste_symbol = 'PASTE'

set backspace=indent,eol,start

" This only works since vim 7.3
if version >= 703
  set colorcolumn=81
  "hi ColorColumn ctermbg=235
  hi ColorColumn ctermbg=0

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

" Restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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

" Map <leader>h to convert to new ruby hash syntax
nnoremap <leader>h :%s/:\([a-zA-Z0-9_]\+\) =>/\1:/gc<cr>

" Map <leader>n to toggle line numbering
nnoremap <leader>n :set invnumber number?<cr>:GitGutterToggle<cr>
nnoremap <leader>m :next<cr>
" Avoid flickering on redraw but will always show the sign column.
"let g:gitgutter_sign_column_always = 1
let g:gitgutter_eager = 0

" Highlight VCS conflict marker
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Custom smartinput rules.
" Do not close a '[' if there is a " or ' after the cursor.
call smartinput#define_rule({'at': '\%#"', 'char': '[', 'input': '['})
call smartinput#define_rule({'at': '\%#''', 'char': '[', 'input': '['})
" Do not close a '{' if there is a " or ' after the cursor.
call smartinput#define_rule({'at': '\%#"', 'char': '{', 'input': '{'})
call smartinput#define_rule({'at': '\%#''', 'char': '{', 'input': '{'})

" fugitive related commands.
" Open a split and execute git diff
nnoremap <leader>d :50sp new<cr>:Git! diff<cr>

" Open a split and execute git diff --cached
nnoremap <leader>c :50sp new<cr>:Git! diff --cached<cr>

" Exec Gstatus
nnoremap <leader>s :Gstatus<cr>

" Align blocks on first '=' (from tenderlove)
" Usage: ctrl-v + <leader>a
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<CR>
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction
