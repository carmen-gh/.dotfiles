return {
	{
		"fnune/recall.nvim",
		version = "*",
		config = function()
			local recall = require("recall")

			recall.setup({
				sign = "",
				sign_highlight = "",
			})

			vim.keymap.set("n", "<leader>mm", recall.toggle, { noremap = true, silent = true, desc = "toggle" })
			vim.keymap.set("n", "<leader>mn", recall.goto_next, { noremap = true, silent = true, desc = "next" })
			vim.keymap.set("n", "<leader>mp", recall.goto_prev, { noremap = true, silent = true, desc = "prev" })
			vim.keymap.set(
				"n",
				"<leader>md",
				recall.clear,
				{ noremap = true, silent = true, desc = "delete all marks" }
			)
			vim.keymap.set(
				"n",
				"<leader>ml",
				":Telescope recall theme=ivy<CR>",
				{ noremap = true, silent = true, desc = "list" }
			)
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
				},
			})

			vim.keymap.set("n", "<leader>hm", function()
				harpoon:list():append()
			end, { desc = "mark" })
			vim.keymap.set("n", "<leader>hl", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "list" })
			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "1. entry" })
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "2. entry" })
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "3. entry" })
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "4. entry" })
		end,
	}, -- maybe add https://github.com/letieu/harpoon-lualine
}
