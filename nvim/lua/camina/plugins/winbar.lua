local M = {}

local frappe = require("catppuccin.palettes").get_palette("frappe")

vim.api.nvim_set_hl(0, "WinBarPath", { bg = frappe.overlay1, fg = frappe.base })
vim.api.nvim_set_hl(0, "WinBarModified", { bg = frappe.overlay1, fg = frappe.base })
vim.api.nvim_set_hl(0, "WinBarEndings", { bg = NONE, fg = frappe.overlay1 })

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
