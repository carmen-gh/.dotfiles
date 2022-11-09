-- require('nightfox').setup({
--     options = {
--         terminal_colors = true,
--         dim_inactive = true,
--         styles = {
--             comments = "italic",
--             keywords = "bold",
--             types = "italic,bold",
--
--         },
--   }
-- })
-- vim.cmd("colorscheme nordfox")


require("catppuccin").setup({
	flavour = "frappe",
	term_colors = true,
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.05,
	},
	styles = {
		comments = { "italic" },
		keywords = { "bold" },
		types = { "italic,bold" },
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		lsp_saga = true,
		mason = true,
		telescope = true,
		treesitter = true,
		ts_rainbow = true,
	},
})

vim.cmd("colorscheme catppuccin")
vim.cmd("highlight WinSeparator guibg=None guifg=#719cd6")
vim.cmd("highlight GitSignsAdd guibg=None guifg=#3ad900")
vim.cmd("highlight GitSignsChange guibg=None guifg=#ffc600")
vim.cmd("highlight GitSignsDelete guibg=None guifg=#ff2600")
