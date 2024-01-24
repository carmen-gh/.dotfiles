return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[                                                 ]],
			[[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
			[[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
			[[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
			[[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
			[[██   ████ ███████  ██████    ████   ██ ██      ██]],
			[[                                                 ]],
			[[                                                 ]],
		}
		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", "<cmd>ene<CR>"),
			dashboard.button("f", "  Find file", "<cmd>Telescope find_files theme=dropdown preview=false<CR>"),
			dashboard.button("o", "  Find old files", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>"),
			dashboard.button("d", "  Diffview", "<cmd>DiffviewOpen<CR>"),
			dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
			dashboard.button("u", "  Update", "<cmd>Lazy update<cr>"),
			dashboard.button("q", "  Close", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
