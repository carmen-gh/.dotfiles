-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<ESC>") -- better escape
vim.keymap.set("n", "x", '"_x') -- delete single character without copying into register
vim.keymap.set("v", "<leader>p", [["_dP]]) -- paste and keep
vim.keymap.set("n", "<leader>d", [["_d]]) -- delete without putting into register
vim.keymap.set("n", "YY", "va{Vy}", { desc = "copy function or json object" })

-- disable arrow keys
vim.keymap.set("n", "<UP>", "<NOP>")
vim.keymap.set("n", "<DOWN>", "<NOP>")
vim.keymap.set("n", "<LEFT>", "<NOP>")
vim.keymap.set("n", "<RIGHT>", "<NOP>")
