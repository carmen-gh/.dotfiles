call plug#begin()

 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'junegunn/vim-easy-align'
 Plug 'tpope/vim-fugitive'
 Plug 'airblade/vim-gitgutter'
 Plug 'junegunn/gv.vim'
 Plug 'lilyball/vim-swift'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'tpope/vim-surround'
 Plug 'jiangmiao/auto-pairs'
 Plug 'sheerun/vim-polyglot'
 Plug 'matthewbdaly/vim-filetype-settings'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'arcticicestudio/nord-vim'
 Plug 'joshdick/onedark.vim'
 Plug 'hzchirs/vim-material'
 Plug 'EdenEast/nightfox.nvim'
 Plug 'udalov/kotlin-vim'

call plug#end()

colorscheme nordfox

set autoindent
set clipboard=unnamed
set expandtab
set hidden
set ignorecase
set mouse=a
set nohlsearch 
set noshowmode
set noswapfile
set number relativenumber
set scrolloff=8
set shiftwidth=4
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set ttyfast


syntax on

" Airline settings___________________________________
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme='material'

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>

" remap leader key to space <leader>
let mapleader = " "

" Tabs______________________________________________
" ctrl+t to open a new tab and select a file
map <c-t> :tabnew<cr><c-p>

" vim tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tw  :tabclose<CR>
nnoremap tn  :tabnew<CR>


" NERDTree__________________________________________
"  \+n tree focus 
nnoremap <leader>n :NERDTreeFocus<CR> 
" show/hide NERDTree
"nnoremap <C-n> :NERDTreeToggle<CR>
" ctrl+f show current file in NerdTree 
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" close NERDTree with last open tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Auto start NERD tree if no files are specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif
"
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p


"disable key movement in normal, visual, select, and operator-pending modes
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"press Alt-j to move the current line down, or press Alt-k to move the current line up.
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" stay in search mode and press ctrl+n for next result, or previous ctrl+p 
cnoremap <C-n> <C-g>
cnoremap <C-p> <C-t>

