local M = {}

local color = require("catppuccin.palettes").get_palette("frappe")

vim.api.nvim_set_hl(0, "WinBarPath", { bg = color.overlay1, fg = color.base })
vim.api.nvim_set_hl(0, "WinBarModified", { bg = color.overlay1, fg = color.base })
vim.api.nvim_set_hl(0, "WinBarEndings", { bg = NONE, fg = color.overlay1 })

function M.eval()
	local file_path = vim.api.nvim_eval_statusline("%f", {}).str
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "[+] " or ""

	file_path = file_path:gsub("/", "  ")

	return "%#WinBarEndings#"
		.. ""
		.. "%*"
		.. "%#WinBarPath#"
		.. " "
		.. file_path
		.. "%*"
		.. "%#WinBarModified#"
		.. " "
		.. modified
		.. "%*"
		.. "%#WinBarEndings#"
		.. ""
		.. "%*"
end

return M
