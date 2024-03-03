return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"dart",
					"go",
					"gomod",
					"gowork",
					"gosum",
					"kotlin",
					"lua",
					"rust",
					"html",
					"json",
					"toml",
					"yaml",
					"markdown",
					"markdown_inline",
					"python",
					"sql",
				},
				auto_install = true,
				rainbow = {
					enabled = true,
					extended_mode = true,
				},
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ii"] = "@conditional.inner",
							["ai"] = "@conditional.outer",
							["il"] = "@loop.inner",
							["al"] = "@loop.outer",
							["at"] = "@comment.outer",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		enabled = true,
		opts = { mode = "cursor", max_lines = 1 },
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>cj", ":lua require('treesj').toggle()<CR>", desc = "Join code block (toggle)" },
		},
	},
}
