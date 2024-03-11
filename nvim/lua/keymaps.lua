vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "x", '"_x', { desc = "delete single character without copying into register" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
--vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

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

-- Edit the alternate / previously edited file
vim.keymap.set("n", "<leader>o", "<C-^>", { desc = "edit prev edited file" })

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

-- better indenting (keep visual selection)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Open line, but stay in normal mode
vim.keymap.set("n", "<leader><CR>", "o<Esc>", { desc = "add line below in normal mode" })

-- Increment/decrement numbers
vim.keymap.set({ "n", "v" }, "+", "<C-a>", { desc = "increment number" })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { desc = "decrement number" })

-- Quickfix
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "prev diagnostics" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostics" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic line" })
vim.keymap.set("n", "gq", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

-- Close
function CloseAllOtherBuffers()
	vim.cmd([[up | %bd | e#]]) -- to save current buffer and close delete all open hidden buffers
end
vim.keymap.set("n", "<leader>qb", "<cmd>lua CloseAllOtherBuffers()<CR>", { desc = "quite other buffers" })
vim.keymap.set("n", "<leader>qs", "<cmd>only<CR>", { desc = "quite other splits" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "quite all}" })
