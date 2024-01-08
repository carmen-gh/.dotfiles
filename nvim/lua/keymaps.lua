vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "x", '"_x', { desc = "delete single character without copying into register" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Line movement (alt-j and alt-k)
vim.keymap.set("n", "<A-j>", ":m+1<CR>", { desc = "Move line down [alt + j]" })
vim.keymap.set("n", "<A-k>", ":m-2<CR>", { desc = "Move line up [alt + k]" })
vim.keymap.set("i", "<A-j>", "<ESC><cmd>m .+1<CR>==gi", { desc = "Move line down [alt + j]" })
vim.keymap.set("i", "<A-k>", "<ESC><cmd>m .-2<CR>==gi", { desc = "Move line up [alt + k]" })
vim.keymap.set("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move line down [alt + j]" })
vim.keymap.set("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move line up [alt + k]" })

-- window navigation <ctrl> hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "jump to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "jump down to window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "jump up to window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "jump to right window" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffer navigation
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "next buffer" })
vim.keymap.set("n", "[B", "<cmd>bfirst<CR>", { desc = "first buffer" })
vim.keymap.set("n", "]B", "<cmd>blast<CR>", { desc = "last buffer" })

-- splitting
vim.keymap.set("n", "<leader>|", "<cmd>vs<CR>", { desc = "split vertically" })
vim.keymap.set("n", "<leader>-", "<cmd>sp<CR>", { desc = "split horizontally" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Quickfix
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Close
function CloseAllOtherBuffers()
	vim.cmd([[up | %bd | e#]]) -- to save current buffer and close delete all open hidden buffers
end
vim.keymap.set("n", "<leader>qb", "<cmd>lua CloseAllOtherBuffers()<CR>", { desc = "quite other buffers" })
vim.keymap.set("n", "<leader>qs", "<cmd>only<CR>", { desc = "quite other splits" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "quite all" })
