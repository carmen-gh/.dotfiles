return {
	{ "tpope/vim-sleuth" },
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
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
		version = false,
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			require("mini.comment").setup()
			require("mini.misc").setup()
			require("mini.pairs").setup()
			require("mini.splitjoin").setup()
			require("mini.notify").setup({
				lsp_progress = {
					duration_last = 3000,
				},
			})
			require("mini.indentscope").setup({
				symbol = "▏", -- "│",
				draw = { animation = require("mini.indentscope").gen_animation.none() },
			})
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
}
