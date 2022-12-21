-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs & indentation
vim.opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- 4 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
vim.opt.cursorline = true

-- appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.opt.textwidth = 120
vim.opt.colorcolumn= "+1" -- show max textwidth column
vim.opt.showmode = false
-- vim.opt.winbar = "%{%v:lua.require'camina.plugins.winbar'.eval()%}"
vim.opt.laststatus = 3
-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- word objects
vim.opt.iskeyword:append("-") -- consider string-string as whole word

-- swapfile and backup
vim.opt.swapfile = false

-- completion
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.clipboard = "unnamed"

vim.opt.autoread = true

-- autoreload buffer after change on disk (e.g. lazygit toggleterm)
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]
