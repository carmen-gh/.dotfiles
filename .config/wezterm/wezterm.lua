local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Catppuccin Mocha colors
local bg_color_active = "#1e1e2e"
local bg_color_inactive = "#313244"
local fg_color_border = "#6c7086"
local fg_color_inactive = "#89b4fa"
local fg_color_active = "#cba6f7"
local fg_color_outline = "#89dceb"

require("tab_title").setup(config)

config.font = wezterm.font("JetBrains Mono")
config.window_frame = {
	font = wezterm.font({ family = "Cantarell", weight = "Regular" }),
}
config.window_frame = {
	active_titlebar_bg = bg_color_inactive,
}
-- config.window_background_opacity = 0.97
config.macos_window_background_blur = 20
config.color_scheme = "Catppuccin Mocha"
config.status_update_interval = 1000

if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	-- Linux
	config.default_prog = { "/usr/bin/fish", "-l" } -- set fish as login shell
	-- config.window_decorations = "RESIZE" -- NOTE: see bugreport wezterm gnome wayland issue
else
	-- Mac OS
	config.font_size = 14.0
	config.window_decorations = "RESIZE"
	wezterm.on("gui-startup", function()
		local _, _, window = wezterm.mux.spawn_window({})
		window:gui_window():maximize()
	end)
end

config.default_cursor_style = "SteadyBar"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 6,
	right = 6,
	top = 12,
	bottom = 12,
}
config.show_close_tab_button_in_tabs = false
config.colors = {
	background = bg_color_active,
	tab_bar = {
		active_tab = {
			bg_color = bg_color_active,
			fg_color = fg_color_active,
		},
		inactive_tab = {
			bg_color = bg_color_inactive,
			fg_color = fg_color_inactive,
		},
		inactive_tab_hover = {
			bg_color = bg_color_active,
			fg_color = fg_color_inactive,
		},
		inactive_tab_edge = fg_color_border,
	},
}
config.term = "wezterm"

wezterm.on("update-right-status", function(window, _)
	local workspaces = wezterm.mux.get_workspace_names()
	local name = wezterm.mux.get_active_workspace()
	-- only show worspace title if name is not default name
	if name ~= "default" then
		local space = "    "
		window:set_right_status(wezterm.format({
			{ Foreground = { Color = fg_color_outline } },
			{ Background = { Color = bg_color_inactive } },
			{ Text = space },
			{ Text = wezterm.nerdfonts.fa_window_restore },
			{ Text = space },
			{ Text = window:active_workspace() },
			{ Text = space },
		}))
	end
end)

-- ------------------------------------------------------------------------------------------------------------------------
-- KEYBINDINGS ------------------------------------------------------------------------------------------------------------

config.keys = {

	-- font reset
	{ key = "0", mods = "CTRL|SHIFT", action = act.ResetFontSize },
	-- activate copy mode
	{ key = "Enter", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
	-- activate search mode leader and /
	{ key = "?", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },

	-- PANE ----------------------------------------------------------------------------------------------------------------

	-- split pane
	{ key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- toggle zoom pane
	{ key = "z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

	-- resizing pane
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- close pane (and tab or workspace if its the last pane)
	{ key = "q", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

	-- pane navgiation see config file vim.lua
	-- navigate with CTRL and hjkl also works with neovim integration and navigating between neovim splits

	-- TAB ----------------------------------------------------------------------------------------------------------------

	-- navigate between tabs "[" and "]" or "h" and "l"
	{ key = "{", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },

	-- rename tab
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = fg_color_active } },
				{ Text = "Renaming Tab Title...:" },
			}),
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- WORKSPACE ----------------------------------------------------------------------------------------------------------
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({ name = "workspace", one_shot = true }),
	},
}

config.key_tables = {
	workspace = {
		{ key = "Escape", action = "PopKeyTable" },
		-- { key = "Enter", action = "PopKeyTable" },
		-- navigate between workspaces "[" and "]" or "h" and "l"
		{ key = "{", action = act.SwitchWorkspaceRelative(-1) },
		{ key = "}", action = act.SwitchWorkspaceRelative(1) },
		{ key = "h", action = act.SwitchWorkspaceRelative(-1) },
		{ key = "l", action = act.SwitchWorkspaceRelative(1) },
		-- New workspace
		{
			key = "n",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { Color = fg_color_active } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
					end
				end),
			}),
		},
		-- rename workspace name
		{
			key = "r",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { Color = fg_color_active } },
					{ Text = "Enter name for current workspace" },
				}),
				action = wezterm.action_callback(function(_, _, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		-- open predefined workspace
		{
			key = "o",
			action = wezterm.action_callback(function(window, pane)
				local home = wezterm.home_dir
				local workspaces = {
					{ id = home, label = "Home" },
					{ id = home .. "/work", label = "Work" },
					{ id = home .. "/Developer/elixir/loki", label = "Loki" },
					{ id = home .. "/.dotfiles", label = "dotfiles" },
				}

				window:perform_action(
					act.InputSelector({
						description = wezterm.format({
							{ Attribute = { Intensity = "Bold" } },
							{ Foreground = { Color = fg_color_active } },
							{ Text = "Open or create workspace:" },
						}),
						action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
							if not id and not label then
								wezterm.log_info("cancelled")
							else
								wezterm.log_info("id = " .. id)
								wezterm.log_info("label = " .. label)
								inner_window:perform_action(
									act.SwitchToWorkspace({
										name = label,
										spawn = {
											label = "Workspace: " .. label,
											cwd = id,
										},
									}),
									inner_pane
								)
							end
						end),
						choices = workspaces,
						fuzzy = false,
					}),
					pane
				)
			end),
		},
		-- Switch between workspace
		{
			key = "s",
			action = wezterm.action_callback(function(window, pane)
				local choices = {}
				for _, value in ipairs(wezterm.mux.get_workspace_names()) do
					table.insert(choices, { label = value })
				end

				window:perform_action(
					act.InputSelector({
						description = wezterm.format({
							{ Attribute = { Intensity = "Bold" } },
							{ Foreground = { Color = fg_color_active } },
							{ Text = "Switch to workspace:" },
						}),
						action = wezterm.action_callback(function(inner_window, inner_pane, _, label)
							if not label then
								return
							end
							inner_window:perform_action(act.SwitchToWorkspace({ name = label }), inner_pane)
						end),
						choices = choices,
						fuzzy = false,
					}),
					pane
				)
			end),
		},
	},
}

-- Jump between tabs with 1-9
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|SHIFT",
		action = act.ActivateTab(i - 1),
	})
end

require("vim_navigation").addNavigationKeys(config)

return config
