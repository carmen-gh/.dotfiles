local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

require("tabs").setup(config)

config.font = wezterm.font("JetBrains Mono")
config.window_frame = {
	font = wezterm.font({ family = "Cantarell", weight = "Regular" }),
}
config.window_frame = {
	active_titlebar_bg = "#181926",
}
config.window_background_opacity = 0.97
config.macos_window_background_blur = 20
config.color_scheme = "Catppuccin Macchiato"
config.status_update_interval = 1000

if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	-- Linux
	config.default_prog = { "/usr/bin/fish", "-l" } -- set fish as login shell
	-- config.window_decorations = "RESIZE" -- NOTE: see bugreport wezterm gnome wayland issue
else
	-- Mac OS
	config.window_decorations = "RESIZE"
end

config.default_cursor_style = "SteadyBar"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 6,
	right = 6,
	top = 12,
	bottom = 12,
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
		inactive_tab_edge = "#939ab7",
	},
}

wezterm.on("update-right-status", function(window, _)
	local workspaces = wezterm.mux.get_workspace_names()
	local num_of_workspaces = #workspaces
	if num_of_workspaces > 1 then
		local title = window:active_workspace() .. "    "
		window:set_right_status(wezterm.format({
			{ Foreground = { Color = "#939ab7" } },
			{ Text = title },
		}))
	end
end)

wezterm.on("gui-startup", function()
	local _, _, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

config.term = "wezterm"
config.keys = {
	-- font reset
	{
		key = "0",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ResetFontSize,
	},
	-- split pane
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
	-- toggle zoom pane
	{
		key = "z",
		mods = "CTRL|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- resizing pane
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
	-- move between tabs
	{
		key = "{", -- key [
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "}", -- key ]
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(1),
	},
	-- activate copy mode or vim mode ('v' begin selection, 'y' copy selection)
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCopyMode,
	},
	-- WORKSPACES (simular to tmux sessions)
	-- Prompt for a name to use for a new workspace and switch to it
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = "#cad3f5" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},
	-- switching between workspaces
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = act.SwitchWorkspaceRelative(1),
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = act.SwitchWorkspaceRelative(-1),
	},
	-- rename workspace
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for currnet workspace" },
			}),
			action = wezterm.action_callback(function(_, _, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	-- Show the launcher in fuzzy selection mode and have it list all workspaces and allow activating one.
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}

require("vim").addNavigationKeys(config)

return config
