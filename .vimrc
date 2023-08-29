" Leader
:let mapleader = "\\"
:let maplocalleader = "-"

" Config
set number
set tabstop=2
set numberwidth=4
set nowrap
set hlsearch incsearch

" Color Scheme
colorscheme elflord

" Mappings
:nnoremap j k
:nnoremap k j
" Leader Mappings
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>q :Ex<cr>
:nnoremap <leader>p :bnext<cr>
:nnoremap <leader>o :bprevious<cr>
:nnoremap <leader>d :bdelete<cr>

" File Types :help autocmd-events
:autocmd FileType python set noexpandtab

" Operator-pending Movement
:onoremap p i(


" Toggle Options
:nnoremap <leader>n :setlocal number!<cr>
:nnoremap <leader>w :setlocal wrap!<cr>
