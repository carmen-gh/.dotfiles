return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				enabled = vim.fn.executable("make") == 1,
			},
		},
		config = function()
			require("telescope").setup({
				extensions = {},
				defaults = {
					prompt_prefix = "  ",
					layout_config = {
						prompt_position = "top",
					},
				},
			})

			local builtin = require("telescope.builtin")

			-- keys
    -- stylua: ignore
			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set(
				"n",
				"<leader>fb",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown previewer=false<cr>",
				{}
			)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>", {})
			vim.keymap.set("n", "<leader>fd", function()
				builtin.find_files({ cwd = "~/.dotfiles", prompt_title = "dotfiles" })
			end, {})
			vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>", {})

			-- extensions
			require("telescope").load_extension("fzf")
		end,
	},
}
