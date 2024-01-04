-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.opt.numberwidth = 4
vim.opt.statuscolumn = "%= %{&nu?(&rnu && v:relnum ? v:relnum : v:lnum) : ''}%=%s"
vim.opt.termguicolors = true
vim.opt.colorcolumn = "120"

vim.g.markdown_fenced_languages = { "html", "kotlin", "go", "rust" } -- enable code highlight in markdown code snippets
