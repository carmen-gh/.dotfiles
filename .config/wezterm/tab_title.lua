local wezterm = require("wezterm")

local M = {}
-- TODO add brew entry
M.icons = {
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["brew"] = wezterm.nerdfonts.cod_package,
	["btop"] = wezterm.nerdfonts.md_chart_areaspline,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["dnf"] = wezterm.nerdfonts.linux_fedora, -- does not show the right icon, instead '#'
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["lg"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.linux_neovim,
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["Yazi"] = wezterm.nerdfonts.oct_file_directory, -- Bug: not working
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["fish"] = wezterm.nerdfonts.dev_terminal,
}

function M.title(tab)
	local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
	local process, other = title:match("^(%S+)%s*%-?%s*%s*(.*)$")
	local space = "    "

	if M.icons[process] then
		title = M.icons[process] .. space .. (other or "")
	end

	local is_zoomed = false
	for _, pane in ipairs(tab.panes) do
		if pane.is_zoomed then
			is_zoomed = true
			break
		end
	end
	if is_zoomed then -- or (#tab.panes > 1 and not tab.is_active) then
		title = "  " .. title
	end

	return space .. title .. space
end

---@class config Config
function M.setup(config)
	config.tab_bar_at_bottom = false
	config.hide_tab_bar_if_only_one_tab = false
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 32
	config.unzoom_on_switch_pane = true

	wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
		local title = M.title(tab)

		local ret = tab.is_active
				and {
					{ Attribute = { Intensity = "Bold" } },
					{ Attribute = { Italic = true } },
				}
			or {}
		ret[#ret + 1] = { Text = title }
		return ret
	end)
end

return M
