-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.conceallevel = 0
-- No separator.
vim.opt.numberwidth = 4
vim.opt.statuscolumn = "%= %{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : ''}%=%s"

-- With sepaartor.
-- vim.opt.numberwidth = 5
-- vim.opt.statuscolumn = "%= %{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : ''}%=│%s"
