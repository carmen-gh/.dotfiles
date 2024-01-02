local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local Icons = require("camina.icons")

-- configure telescope
telescope.setup({
	defaults = {
		prompt_prefix = Icons.ui.search,
		selection_caret = Icons.ui.BoldDividerRight,
		mappings = {
			i = {
				["<C-p>"] = actions.move_selection_previous, -- move to prev result
				["<C-n>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
				["<C-s>"] = actions.file_vsplit, -- Perform file vsplit on selection
				["<C-S>"] = actions.file_vsplit, -- Perform file horizontal split on selection
			},
			n = {
				["s"] = actions.file_vsplit, -- Perform file vsplit on selection
				["S"] = actions.file_split, -- Perform file hsplit on selection
			}
		},
	},
})

telescope.load_extension("fzf")
