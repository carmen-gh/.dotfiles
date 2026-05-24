-- vim.opt.numberwidth = 4
-- vim.opt.statuscolumn = "%= %{&nu?(&rnu && v:relnum ? v:relnum : v:lnum) : ''}%=%s"
-- vim.opt.colorcolumn = "120"

-- local opt = vim.opt
--
-- opt.colorcolumn = "120" -- max text width column
-- --opt.timeoutlen = 300
-- opt.autowrite = true -- enable auto write
-- opt.clipboard = "unnamedplus" -- sync with system clipboard
-- opt.completeopt = "menu,menuone,noselect"
-- opt.confirm = true -- confirm to save changes before exiting modified buffer
-- opt.cursorline = true -- enable highlighting of the current line
-- opt.expandtab = true -- use spaces instead of tabs
-- opt.ignorecase = true -- ignore case
-- opt.inccommand = "nosplit" -- preview incremental substitute
-- opt.laststatus = 3 -- global statusline
-- opt.mouse = "a" -- enable mouse mode
-- opt.number = true -- print line number
-- opt.relativenumber = true -- relative line numbers
-- opt.scrolloff = 4 -- lines of context
-- --opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- --opt.shiftround = true -- round indent
-- opt.shiftwidth = 2 -- size of an indent
-- --opt.shortmess:append({ w = true, i = true, c = true, c = true })
-- opt.showmode = false -- dont show mode since we have a statusline
-- opt.sidescrolloff = 8 -- columns of context
-- opt.signcolumn = "yes" -- always show the signcolumn, otherwise it would shift the text each time
-- opt.smartcase = true -- don't ignore case with capitals
-- opt.smartindent = true -- insert indents automatically
-- opt.spelllang = { "en" }
-- opt.splitbelow = true -- put new windows below current
-- opt.splitkeep = "screen"
-- opt.splitright = true -- put new windows right of current
-- opt.tabstop = 2 -- number of spaces tabs count for
-- opt.termguicolors = true -- true color support
-- opt.undofile = true
-- opt.undolevels = 10000:
-- opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode
-- opt.wildmode = "longest:full,full" -- command-line completion mode
-- opt.winminwidth = 5 -- minimum window width
-- opt.wrap = false -- disable line wrap
--

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true

-- vim.opt.statuscolumn = "%= %{&nu?(&rnu && v:relnum ? v:relnum : v:lnum) : ''}%=%s"
vim.opt.confirm = true
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.laststatus = 3 -- global statusline
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smoothscroll = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.colorcolumn = "120" -- max text width column
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.fillchars = {
  eob = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  fold = " ",
  foldinner = " ", -- Specify the character to display instead of nesting depth
}
vim.o.foldtext =
  [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... ' . '(' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.o.foldcolumn = "1" -- Specify the column width for fold display
vim.o.foldlevelstart = 99 -- prevent from fold everything
vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
