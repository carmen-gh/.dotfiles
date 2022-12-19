-- set leader key tospace
vim.g.mapleader = " "

-- --------------------------------------------
-- general keymaps
-- --------------------------------------------

-- escape
vim.keymap.set("i", "jj", "<ESC>")

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>") -- increment
vim.keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- disable arrow keys
vim.keymap.set("n", "<UP>", "<NOP>")
vim.keymap.set("n", "<DOWN>", "<NOP>")
vim.keymap.set("n", "<LEFT>", "<NOP>")
vim.keymap.set("n", "<RIGHT>", "<NOP>")

-- save buffer
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>")

-- run the last command
-- vim.keymap.set("n", "<leader>x", "<cmd><UP><CR>")

-- Line movement (alt-j and alt-k)
vim.keymap.set("n", "∆", "<cmd>m .+1<CR>==")
vim.keymap.set("n", "˚", "<cmd>m .-2<CR>==")
vim.keymap.set("i", "∆", "<ESC><cmd>m .+1<CR>==gi")
vim.keymap.set("i", "˚", "<ESC><cmd>m .-2<CR>==gi")
vim.keymap.set("v", "∆", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set("v", "˚", "<cmd>m '<-2<CR>gv=gv")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- clear search highlight
vim.keymap.set("n", "<C-c>", "<Cmd>noh<cr>")

-- --------------------------------------------
-- plugin keymaps
-- --------------------------------------------

-- neotree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- telescope
vim.keymap.set("n", "<leader>ff",
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- find open buffers in current neovim instance
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_status<cr>") -- find current changes per file with diff preview and add action
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>") -- find all marks
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>") -- find all keymaps
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- find available help tags
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>") -- find all diagnostic
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope lsp_references<cr>") -- find all references (find usage)

-- terminal
vim.keymap.set("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true }) -- toggle lazygit terminal
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>") -- toggle terminal horizontal
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>") -- toggle terminal vertical

-- lsp
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true }) -- Code action
-- vim.keymap.set("n", "<leader>u", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })        -- find definition and reference aka usage
vim.keymap.set("n", "<leader>cf", "<cmd>LspZeroFormat<CR>", { silent = true }) -- format code
vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { silent = true }) -- Rename
vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga peek_definition<CR>", { silent = true }) -- Peek definition
vim.keymap.set("n", "<leader>co", "<cmd>LSoutlineToggle<CR>",{ silent = true })             -- Outline

-- diagnostic
-- vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })   -- Show line diagnostics
-- vim.keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true }) -- Show cursor diagnostic
-- vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })      -- Diagnostics jump next
-- vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })      -- Diagnostics jump previous
vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true }) -- toggle breakpoint
-- step back
-- continue
-- run to cursor
-- disconnect
-- step into
-- step over
-- step out
-- pause
-- start
-- quit
-- toggle ui

-- snippets

-- sorround
-- vim.keymap.set("n", "S", "ysiW")

-- Json format
-- vim.api.nvim_create_user_command('FormatJson', "%!jq", {bang = true, desc = 'format json in current buffer'})
