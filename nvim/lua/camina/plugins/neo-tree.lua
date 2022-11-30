local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

neotree.setup({
	close_if_last_window = true,
	enable_diagnostics = false,
	source_selector = {
		winbar = true,
		content_layout = "center",
	},
	default_component_configs = {
		indent = {
			padding = 0,
		},
		git_status = {
			symbols = {
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "◌",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		width = 40,
		mappings = {
			["o"] = "open",
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
		{
			event = "file_opened",
			handler = function()
				neotree.close_all()
			end,
		},
	},
})

local C = require("catppuccin.palettes").get_palette()
local function set_hl(group, values)
	vim.api.nvim_set_hl(0, group, values)
end

set_hl("NeoTreeDirectoryIcon", { fg = C.sky })
set_hl("NeoTreeRootName", { fg = C.fg, bold = true })
set_hl("NeoTreeFileName", { fg = C.fg })
set_hl("NeoTreeFileIcon", { fg = C.fg })
set_hl("NeoTreeFileNameOpened", { fg = C.blue })
-- set_hl("NeoTreeIndentMarker", { fg = C.blue_3 })
set_hl("NeoTreeGitAdded", { fg = C.green })
set_hl("NeoTreeGitConflict", { fg = C.red })
set_hl("NeoTreeGitModified", { fg = C.sky })
set_hl("NeoTreeGitUntracked", { fg = C.sky })
-- set_hl("NeoTreeNormal", { bg = C.blue })
-- set_hl("NeoTreeNormalNC", { bg = C.blue })
-- set_hl("NeoTreeSymbolicLinkTarget", { fg = C.cyan })
