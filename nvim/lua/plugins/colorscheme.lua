-- Catppuccin Theme
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "frappe", -- "latte, frappe, macchiato, mocha"
		integrations = {
			mason = true,
			harpoon = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
				inlay_hints = {
					background = true,
				},
			},
			neotree = true,
			neotest = true,
			which_key = true,
			alpha = true,
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin")
	end,
}

-- One Nord Theme
-- return {
-- 	-- https://github.com/rmehri01/onenord.nvim
-- 	"shaunsingh/nord.nvim",
-- 	lazy = false, -- We want the colorscheme to load immediately when starting Neovim
-- 	priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
-- 	config = function(_, opts)
-- 		vim.cmd("colorscheme nord") -- Replace this with your favorite colorscheme
-- 	end,
-- }
--

-- Tokyo Night Theme
-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd([[colorscheme tokyonight-storm]])
-- 	end,
-- }
