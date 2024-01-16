return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			filesystem = {
				follow_current_file = { enabled = true },
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(_)
						require("neo-tree.command").execute({ action = "close" }) -- auto close
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "explorer" })
	end,
}
