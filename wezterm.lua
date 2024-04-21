local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Catppuccin Macchiato"
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = 1000
config.default_prog = { "/usr/bin/fish", "-l" }
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 15,
}
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#24273a",
			fg_color = "#cad3f5",
		},
		inactive_tab = {
			bg_color = "#181926",
			fg_color = "#939ab7",
		},
	},
}
config.keys = {
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
}
return config
