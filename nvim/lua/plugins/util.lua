return {
	{ "tpope/vim-sleuth" },
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "VeryLazy",
		config = true,
		opts = {
			signs = false,
		},
	  -- stylua: ignore
	    keys = {
	      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
	      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
	      { "<leader>xt", "<cmd>TodoTelescope theme=ivy<cr>", desc = "Todo comments" },
	      { "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME theme=ivy<cr>", desc = "Todo/Fix/Fixme comments" },
	    },
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
			}
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = {
			fileytypes = { "css", "javascript", "toml", "html" },
			user_default_options = {
				names = false, -- "Name" codes like Blue or blue
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				mode = "virtualtext", -- Set the display mode.
				tailwind = false, -- Enable tailwind colors
				sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
				virtualtext = "󰋘 ",
				always_update = false,
			},
		},
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			require("harpoon"):setup(opts)
		end,
	-- stylua: ignore
	    keys = {
	      { "<leader>hm", function() require("harpoon"):list():append() end, desc = "mark file", },
	      { "<leader>hl", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "list marked files", },
	      { "<leader>ha", function() require("harpoon"):list():select(1) end, desc = "file 1", },
	      { "<leader>hs", function() require("harpoon"):list():select(2) end, desc = "file 2", },
	      { "<leader>hd", function() require("harpoon"):list():select(3) end, desc = "file 3", },
	      { "<leader>hf", function() require("harpoon"):list():select(4) end, desc = "file 4", },
	      { "<leader>hg", function() require("harpoon"):list():select(5) end, desc = "file 5", },
	    },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")
			wk.register({
				["<leader>f"] = { name = "file" },
				["<leader>c"] = { name = "code" },
				["<leader>d"] = { name = "debug" },
				["<leader>g"] = { name = "git" },
				["<leader>h"] = { name = "harpoon" },
				["<leader>q"] = { name = "quit" },
				["<leader>x"] = { name = "quickfix" },
			})
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			require("mini.comment").setup()
			require("mini.files").setup()
			require("mini.misc").setup()
			require("mini.pairs").setup()
			require("mini.splitjoin").setup()
			require("mini.indentscope").setup({
				symbol = "▏",
				draw = { animation = require("mini.indentscope").gen_animation.none() },
			})
		end,
	},
}
