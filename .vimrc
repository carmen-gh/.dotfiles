call plug#begin()

 Plug 'EdenEast/nightfox.nvim'
 Plug 'airblade/vim-gitgutter'
 Plug 'inkarkat/vim-ReplaceWithRegister'
 Plug 'itchyny/lightline.vim'
 Plug 'jiangmiao/auto-pairs'
 Plug 'junegunn/vim-easy-align'
 Plug 'lilyball/vim-swift'
 Plug 'matthewbdaly/vim-filetype-settings'
 Plug 'mhinz/vim-startify'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'preservim/nerdcommenter'
 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'sheerun/vim-polyglot'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-surround'
 Plug 'udalov/kotlin-vim'
 Plug 'vim-scripts/argtextobj.vim'

call plug#end()

colorscheme nordfox

set autoindent
set clipboard=unnamed
set expandtab
set hidden
set ignorecase
set mouse=v
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
set textwidth=80
set colorcolumn=+1

syntax on

let g:lightline= { 'colorscheme': 'wombat', }

" neovim highlight a selection on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

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
let NERDTreeShowHidden=1
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

"press ⌥-j (option-j) to move the current line down, or press ⌥-k (option-k) to move the current line up.
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" stay in search mode and press ctrl+n for next result, or previous ctrl+p 
cnoremap <C-n> <C-g>
cnoremap <C-p> <C-t>

