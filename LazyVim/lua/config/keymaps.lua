-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<ESC>", { noremap = false }) -- better escape
vim.keymap.set("n", "x", '"_x') -- delete single character without copying into register
vim.keymap.set("n", "<leader>d", '"_d', { desc = "delete without putting into register" })
vim.keymap.set("n", "<leader>p", '"_0p', { desc = "copy last yanked text" })
vim.keymap.set("n", "YY", "va{Vy}", { desc = "copy function or json object" })

-- disable arrow keys
vim.keymap.set("n", "<UP>", "<NOP>")
vim.keymap.set("n", "<DOWN>", "<NOP>")
vim.keymap.set("n", "<LEFT>", "<NOP>")
vim.keymap.set("n", "<RIGHT>", "<NOP>")

-- Move to window using the <ctrl> hjkl keys even between tmux and neovim
vim.keymap.set("n", "<C-h>", require("tmux").move_left, { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", require("tmux").move_bottom, { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", require("tmux").move_top, { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", require("tmux").move_right, { desc = "Go to right window", remap = true })
