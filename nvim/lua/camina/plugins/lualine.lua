local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		theme = "wombat",
		globalstatus = true,
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {},
			lualine_x = {}, --[[ { "encoding", "filetype" },]]
			lualine_y = {}, -- [[ { "progress" }, ]]
			lualine_z = {}, -- [[ { "location" },]]
		},
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		winbar = {
			lualine_a = {"filename"},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},

		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
})
