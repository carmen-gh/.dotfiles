local wezterm = require("wezterm")

local M = {}
M.icons = {
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["fish"] = wezterm.nerdfonts.md_fish,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["btop"] = wezterm.nerdfonts.md_chart_areaspline,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["lazygit"] = wezterm.nerdfonts.dev_git,
}

---@param tab MuxTabObj
---@param max_width number
function M.title(tab, max_width)
	local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
	local process, other = title:match("^(%S+)%s*%-?%s*%s*(.*)$")

	if M.icons[process] then
		title = M.icons[process] .. " " .. (other or "")
	end

	local is_zoomed = false
	for _, pane in ipairs(tab.panes) do
		if pane.is_zoomed then
			is_zoomed = true
			break
		end
	end
	if is_zoomed then -- or (#tab.panes > 1 and not tab.is_active) then
		title = " " .. title
	end

	title = wezterm.truncate_right(title, max_width - 0)
	return " " .. title .. " "
end

---@param config Config
function M.setup(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = false
	config.hide_tab_bar_if_only_one_tab = false
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 32
	config.unzoom_on_switch_pane = true

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = M.title(tab, max_width)
		local colors = config.resolved_palette
		local active_bg = colors.tab_bar.active_tab.bg_color
		local inactive_bg = colors.tab_bar.inactive_tab.bg_color

		local tab_idx = 1
		for i, t in ipairs(tabs) do
			if t.tab_id == tab.tab_id then
				tab_idx = i
				break
			end
		end
		local is_last = tab_idx == #tabs
		local next_tab = tabs[tab_idx + 1]
		local next_is_active = next_tab and next_tab.is_active

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
