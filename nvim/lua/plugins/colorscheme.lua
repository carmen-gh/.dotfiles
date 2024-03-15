-- Catppuccin Theme
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "macchiato", -- "latte, frappe, macchiato, mocha"
		background = { -- :h background
			dark = "mocha",
		},
		-- transparent_background = true,
		integrations = {
			alpha = true,
			cmp = true,
			dap = true,
			dap_ui = true,
			fidget = true,
			gitsigns = true,
			harpoon = true,
			markdown = true,
			mason = true,
			mini = {
				enabled = true,
				indentscope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
			},
			neotree = true,
			neotest = true,
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
			treesitter = true,
			treesitter_context = true,
			rainbow_delimiters = true,
			telescope = {
				enabled = true,
			},
			which_key = true,
		},
		custom_highlights = function(colors)
			return {
				Pmenu = { bg = colors.surface1 },
				PmenuSel = { bg = colors.overlay0 },
				NormalFloat = { bg = colors.surface0 },
				FloatBorder = { bg = colors.surface0 },
				TelescopeNormal = { bg = colors.surface0 },
				TelescopeSelection = { bg = colors.overlay0 },
			}
		end,
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
