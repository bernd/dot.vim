execute pathogen#infect('bundle/{}', 'manual/{}')

syntax on
filetype plugin indent on

colorscheme solarized
set background=dark " options: light, dark

set directory=~/.vim/tmp
set backspace=indent,eol,start
set title
set t_Co=256
set nowrap
set number
set ruler
set nofoldenable
set scrolloff=5
set wildmenu wildmode=list:longest
set laststatus=2
set timeoutlen=750
set cryptmethod=blowfish
set colorcolumn=80
set listchars=trail:.,extends:>,tab:>-
set nolist
set encoding=utf-8
set showmode
set pastetoggle=<F2>

" Search behaviour related
set ignorecase smartcase incsearch

" Indentation
set autoindent smartindent

" Tabs and spaces (default: ts=8 sw=8 sts=0)
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set list

" Autocommands

" Detect filetypes
au BufRead,BufNewFile *.rb set filetype=ruby.rspec

" Filetype settings
au FileType python set ts=4 sw=4 sts=4
au FileType html,erb set nosmartindent
au FileType sh,make,text,cfg,mail set ts=8 sw=8 sts=0 nolist noexpandtab
au FileType gitcommit,snippet set ts=8 sw=8 sts=0 nolist noexpandtab

" Restore last cursor position in the file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" Set leader key
let mapleader=","

" Key mappings

" Toggle paste mode.
nnoremap <leader>p :set invpaste paste?<cr>

" Remove all ^M/\r occurances
nnoremap <leader>M <esc>:%s,\r,,g<cr>

" Buffer navigation
nnoremap <leader>N :next<cr>

" Remove all trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Split window navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Switch to regular tabbing.
nnoremap !T :set ts=8 sw=8 sts=0 nolist noexpandtab<cr>


" Highlight config

" Highlight trailing whitespace.
highlight TrailingWhitespace ctermbg=88

" Match extra whitespace in all windows ...
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
" ... but not in insert mode
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" File type dependent settings

" Ruby
function! s:ruby_setup() abort
  " Map <leader>h to convert to new ruby hash syntax
  nnoremap <leader>h :%s/:\([a-zA-Z0-9_]\+\) =>/\1:/gc<cr>
endfunction

autocmd FileType ruby call s:ruby_setup()

" Clojure
function! s:clojure_setup() abort
  nnoremap <leader>t :Eval (clojure.test/run-tests)<cr>
  nnoremap <leader>e :%Eval<cr>
endfunction

autocmd FileType clojure call s:clojure_setup()


" Plugin related

" Airline plugin
let g:airline_theme='ubaryd'
let g:airline_powerline_fonts=0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_linecolumn_prefix = '¶ '
let g:airline_branch_prefix = '⎇  '
let g:airline_paste_symbol = 'PASTE'

" Clojure plugin
let g:clojure_align_multiline_strings = 1

" Gitgutter plugin
let g:gitgutter_eager = 0

" Custom smartinput rules.
if exists('g:loaded_smartinput')
  " Do not close a '[' if there is a " or ' after the cursor.
  call smartinput#define_rule({'at': '\%#"', 'char': '[', 'input': '['})
  call smartinput#define_rule({'at': '\%#''', 'char': '[', 'input': '['})
  " Do not close a '{' if there is a " or ' after the cursor.
  call smartinput#define_rule({'at': '\%#"', 'char': '{', 'input': '{'})
  call smartinput#define_rule({'at': '\%#''', 'char': '{', 'input': '{'})
endif

" Ruby plugin
" Set the global ruby path to avoid calling ruby when open a ruby file.
let g:ruby_path = ".,,"
