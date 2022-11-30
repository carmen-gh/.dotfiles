require("catppuccin").setup({
	flavour = "frappe",
	term_colors = true,
	dim_inactive = {
		enabled = true,
		shade = "light",
		percentage = 0.5,
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
		neotree = true,
		dap = true,
		notify = true,
	},
})

-- local C = require("catppuccin.palettes").get_palette()

vim.cmd("colorscheme catppuccin")
vim.cmd("highlight WinSeparator guibg=None guifg=#719cd6")
vim.cmd("highlight GitSignsAdd guibg=None guifg=#3ad900")
vim.cmd("highlight GitSignsChange guibg=None guifg=#fff44f")
-- vim.cmd("highlight GitSignsDelete guibg=None guifg=#ff2600")

local C = require("catppuccin.palettes").get_palette()
local function set_hl(group, values)
	vim.api.nvim_set_hl(0, group, values)
end

set_hl( "DiagnosticHint", { fg = C.text })

-- rosewater
-- flamingo
-- pink
-- mauve
-- red
-- maroon
-- peach
-- yellow
-- green
-- teal
-- sky
-- sapphire
-- blue
-- lavender
-- text
-- subtext1
-- subtext0
-- overlay2
-- overlay1
-- overlay0
-- surface2
-- surface1
-- surface0
-- base
-- mantle
-- crust
