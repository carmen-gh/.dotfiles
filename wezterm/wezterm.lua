local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("tabs").setup(config)

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Catppuccin Macchiato"
config.status_update_interval = 1000
config.default_prog = { "/usr/bin/fish", "-l" }
config.default_cursor_style = "SteadyBar"
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

config.term = "wezterm"
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
		key = "z",
		mods = "CTRL|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
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
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
	},

	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
	},
}
return config
