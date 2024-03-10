return {
	{
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
	},
	{
		"echasnovski/mini.files",
		config = function(_, opts)
			require("mini.files").setup(opts)

			vim.keymap.set("n", "<leader>E", function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end, { desc = "mini explorer" })

			-- Create mappings to modify target window via split
			local map_split = function(buf_id, lhs, direction)
				local rhs = function()
					-- Make new window and set it as target
					local new_target_window
					vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
						vim.cmd(direction .. " split")
						new_target_window = vim.api.nvim_get_current_win()
					end)

					MiniFiles.set_target_window(new_target_window)
				end

				-- Adding `desc` will result into `show_help` entries
				local desc = "Split " .. direction
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					map_split(buf_id, "gs", "belowright horizontal")
					map_split(buf_id, "gv", "belowright vertical")
				end,
			})
		end,
	},
}
