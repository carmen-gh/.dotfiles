local utils = require("utils")
local colors = require("colors")
local wezterm = require("wezterm")
local config = wezterm.config_builder()
require("tab_title").setup(config)
require("vim_navigation").addNavigationKeys(config)
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local act = wezterm.action

config.font = wezterm.font("JetBrains Mono")
config.window_frame = {
	font = wezterm.font({
		family = "Cantarell",
		weight = "Regular",
	}),
}
config.window_frame = { active_titlebar_bg = colors.bg.inactive }
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
-- config.show_close_tab_button_in_tabs = false
config.colors = {
	background = colors.bg.active,
	tab_bar = {
		active_tab = {
			bg_color = colors.bg.active,
			fg_color = colors.fg.active,
		},
		inactive_tab = {
			bg_color = colors.bg.inactive,
			fg_color = colors.fg.inactive,
		},
		inactive_tab_hover = {
			bg_color = colors.bg.active,
			fg_color = colors.fg.inactive,
		},
		inactive_tab_edge = colors.fg.border,
	},
}
config.term = "wezterm"

wezterm.on("update-right-status", function(window, _)
	local name = wezterm.mux.get_active_workspace()
	local workspace_names = wezterm.mux.get_workspace_names()
	local num_of_workspaces = #workspace_names

	-- only show worspace title if name is not "default" or more then one workspaces exists
	if name ~= "default" or num_of_workspaces > 1 then
		local space = "    "
		window:set_right_status(wezterm.format({
			{ Foreground = { Color = colors.fg.outline } },
			{ Background = { Color = colors.bg.inactive } },
			{ Text = space },
			{ Text = wezterm.nerdfonts.fa_window_restore },
			{ Text = space },
			{ Text = string.gsub(name, "(.*[/\\])(.*)", "%2") },
			{ Text = space },
		}))
	end
end)

-- --------------------------------------------------------------------------------------------------------------------
-- KEYBINDINGS --------------------------------------------------------------------------------------------------------
config.keys = config.keys or {} -- init config.keys if it doesn't exist

local new_keys = {
	-- font reset
	{ key = "0", mods = "CTRL|SHIFT", action = act.ResetFontSize },
	-- activate copy mode
	{ key = "Enter", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
	-- activate search mode leader and /
	{ key = "?", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },

	-- PANE -------------------------------------------------------------------------------------------------------------

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

	-- TAB --------------------------------------------------------------------------------------------------------------

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
				{ Foreground = { Color = colors.fg.active } },
				{ Text = "Renaming Tab Title...:" },
			}),
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- WORKSPACE --------------------------------------------------------------------------------------------------------
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({ name = "workspace", one_shot = true }),
	},
	{
		key = "Space",
		mods = "CTRL|SHIFT",
		action = wezterm.plugin
			.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
			.switch_workspace(),
	},
}
utils.merge_keybindings(config, new_keys)

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
					{ Foreground = { Color = colors.fg.active } },
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
					{ Foreground = { Color = colors.fg.active } },
					{ Text = "Enter name for current workspace" },
				}),
				action = wezterm.action_callback(function(_, _, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		-- switch between space (without smart-workspace-switcher)
		{
			key = "Space",
			action = wezterm.action_callback(function(window, pane)
				local choices = {}
				for _, value in ipairs(wezterm.mux.get_workspace_names()) do
					table.insert(choices, { label = value })
				end

				window:perform_action(
					act.InputSelector({
						description = wezterm.format({
							{ Attribute = { Intensity = "Bold" } },
							{ Foreground = { Color = colors.fg.outline } },
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

-----------------------------------------------------------------------------------------------------------------------
-- PLUGINS

workspace_switcher.apply_to_config(config)
workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = colors.fg.outline } },
		{ Background = { Color = colors.bg.active } },
		{ Text = wezterm.nerdfonts.fa_window_restore .. "  " .. label },
	})
end

wezterm.plugin.update_all()

return config
