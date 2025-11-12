local wezterm = require "wezterm"

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback {
	"JetBrainsMono Nerd Font",
	"SFMono Nerd Font",
	"Menlo",
}
config.font_size = 13.0
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"
config.scrollback_lines = 5000
config.default_prog = { "/bin/zsh", "-l" }

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

-- Pane and workspace navigation tuned for project work.
config.keys = {
	{ key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentPane { confirm = false } },
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Left" },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Down" },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Up" },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Right" },
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize { "Left", 3 } },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize { "Down", 3 } },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize { "Up", 3 } },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize { "Right", 3 } },
	{ key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab "DefaultDomain" },
	{ key = "n", mods = "LEADER", action = wezterm.action.SwitchToWorkspace { name = "default" } },
	{ key = "p", mods = "LEADER", action = wezterm.action.PromptInputLine {
			description = "Workspace name",
			action = wezterm.action_callback(function(window, pane, line)
				if not line or #line == 0 then
					return
				end
				window:perform_action(wezterm.action.SwitchToWorkspace { name = line }, pane)
			end),
		},
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize { "Left", 1 } },
		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize { "Right", 1 } },
		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize { "Up", 1 } },
		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize { "Down", 1 } },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

config.launch_menu = {
	{ label = "Dev: docker compose", args = { "docker", "compose", "up" } },
	{ label = "Dev: pnpm install", args = { "pnpm", "install" } },
	{ label = "Dev: pytest", args = { "pytest" } },
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
	regex = [[\b(PR|pr)#(\d+)\b]],
	format = "https://github.com/fonger900/dotfiles/pull/$2",
})

config.set_environment_variables = {
	TERM = "xterm-256color",
}

config.keys[#config.keys + 1] = {
	key = "s",
	mods = "LEADER",
	action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES|LAUNCH_MENU" },
}

return config
