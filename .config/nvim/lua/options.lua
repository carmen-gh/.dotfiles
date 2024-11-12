-- vim.opt.numberwidth = 4
-- vim.opt.statuscolumn = "%= %{&nu?(&rnu && v:relnum ? v:relnum : v:lnum) : ''}%=%s"
-- vim.opt.colorcolumn = "120"

-- local opt = vim.opt
--
-- opt.colorcolumn = "120" -- max text width column
-- --opt.timeoutlen = 300
-- opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.completeopt = "menu,menuone,noselect"
-- opt.confirm = true -- Confirm to save changes before exiting modified buffer
-- opt.cursorline = true -- Enable highlighting of the current line
-- opt.expandtab = true -- Use spaces instead of tabs
-- opt.ignorecase = true -- Ignore case
-- opt.inccommand = "nosplit" -- preview incremental substitute
-- opt.laststatus = 3 -- global statusline
-- opt.mouse = "a" -- Enable mouse mode
-- opt.number = true -- Print line number
-- opt.relativenumber = true -- Relative line numbers
-- opt.scrolloff = 4 -- Lines of context
-- --opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- --opt.shiftround = true -- Round indent
-- opt.shiftwidth = 2 -- Size of an indent
-- --opt.shortmess:append({ W = true, I = true, c = true, C = true })
-- opt.showmode = false -- Dont show mode since we have a statusline
-- opt.sidescrolloff = 8 -- Columns of context
-- opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.smartcase = true -- Don't ignore case with capitals
-- opt.smartindent = true -- Insert indents automatically
-- opt.spelllang = { "en" }
-- opt.splitbelow = true -- Put new windows below current
-- opt.splitkeep = "screen"
-- opt.splitright = true -- Put new windows right of current
-- opt.tabstop = 2 -- Number of spaces tabs count for
-- opt.termguicolors = true -- True color support
-- opt.undofile = true
-- opt.undolevels = 10000
-- opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
-- opt.wildmode = "longest:full,full" -- Command-line completion mode
-- opt.winminwidth = 5 -- Minimum window width
-- opt.wrap = false -- Disable line wrap
--
-- opt.fillchars = {
-- 	foldopen = "",
-- 	foldclose = "",
-- 	-- fold = "⸱",
-- 	fold = " ",
-- 	foldsep = " ",
-- 	diff = "╱",
-- 	eob = " ",
-- }

-- vim.opt.statuscolumn = "%= %{&nu?(&rnu && v:relnum ? v:relnum : v:lnum) : ''}%=%s"
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
