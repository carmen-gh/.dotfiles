-- set leader key tospace
vim.g.mapleader = " "

-- --------------------------------------------
-- general keymaps
-- --------------------------------------------

-- escape
vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "x", '"_x', { desc = "delete single character without copying into register" })

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "decrement number" })

-- disable arrow keys
vim.keymap.set("n", "<UP>", "<NOP>")
vim.keymap.set("n", "<DOWN>", "<NOP>")
vim.keymap.set("n", "<LEFT>", "<NOP>")
vim.keymap.set("n", "<RIGHT>", "<NOP>")

-- save buffer
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>", { desc = "[S]ave current buffer" })

-- run the last command
-- vim.keymap.set("n", "<leader>x", "<cmd><UP><CR>")

-- Line movement (alt-j and alt-k)
vim.keymap.set("n", "∆", "<cmd>m .+1<CR>==", { desc = "Move line down [alt + j]" })
vim.keymap.set("n", "˚", "<cmd>m .-2<CR>==", { desc = "Move line up [alt + k]" })
vim.keymap.set("i", "∆", "<ESC><cmd>m .+1<CR>==gi", { desc = "Move line down [alt + j]" })
vim.keymap.set("i", "˚", "<ESC><cmd>m .-2<CR>==gi", { desc = "Move line up [alt + k]" })
vim.keymap.set("v", "∆", "<cmd>m '>+1<CR>gv=gv", { desc = "Move line down [alt + j]" })
vim.keymap.set("v", "˚", "<cmd>m '<-2<CR>gv=gv", { desc = "Move line up [alt + k]" })

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "jump to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "jump down to window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "jump up to window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "jump to right window" })

-- clear search highlight
vim.keymap.set("n", "<C-c>", "<Cmd>noh<cr>", { desc = "[c]lear search highlight" })

-- --------------------------------------------
-- plugin keymaps
-- --------------------------------------------

-- neotree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "File [E]xplorer" })

-- telescope
vim.keymap.set("n", "<leader>ff",
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
    ,
    { desc = "[F]ind [F]ile" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [S]tring" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind open [B]uffers" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = "[F]ind modified [G]it files " })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "[F]ind [M]arks" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[F]ind [H]elp tags" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "[F]ind [D]iagnostic" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "[F]ind [R]eferences (usage)" })

-- terminal
vim.keymap.set("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>",
    { noremap = true, silent = true, desc = "toggle [T]erminal lazy[G]it" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
    { desc = "toggle [T]erminal [H]orizontaly" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",
    { desc = "toggle [T]erminal [V]erticly" })

-- lsp
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true, desc = "[C]ode [A]ction" })
-- vim.keymap.set("n", "<leader>u", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })        -- find definition and reference aka usage
vim.keymap.set("n", "<leader>cf", "<cmd>LspZeroFormat<CR>", { silent = true, desc = "[C]ode [F]ormat" })
vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { silent = true, desc = "[R]ename" })
vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = "peek [D]efinition" })
vim.keymap.set("n", "<leader>co", "<cmd>LSoutlineToggle<CR>", { silent = true, desc = "[C]ode outline toggle" })

-- diagnostic
-- vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })   -- Show line diagnostics
-- vim.keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true }) -- Show cursor diagnostic
-- vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })      -- Diagnostics jump next
-- vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })      -- Diagnostics jump previous
vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    { silent = true, desc = "toggle [B]reakpoint" })
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
