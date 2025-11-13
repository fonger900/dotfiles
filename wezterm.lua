-- wezterm.lua
--
--since: 2024-01-13
--author: fonger
--
-- This file is the configuration for the Wezterm terminal emulator.
-- It is written in Lua and allows for extensive customization of the
-- terminal's appearance and behavior.

-- Import the wezterm module to access its configuration and action APIs.
local wezterm = require 'wezterm'
-- Get a reference to the action API for defining keymaps.
local act = wezterm.action
-- Initialize an empty configuration table.
local config = {}

-- For older versions of Wezterm, we need to use the config_builder function
-- to get the configuration table. This ensures backward compatibility.
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font Configuration
-- Sets the font used by the terminal. 'JetBrains Mono' is a popular choice
-- for its readability and programming ligatures.
config.font = wezterm.font 'JetBrainsMono Nerd Font'
-- Sets the font size to 16.0 points.
config.font_size = 13.0

-- Theme Configuration
-- Sets the color scheme for the terminal. 'Catppuccin Mocha' is a
-- popular dark theme with pleasant colors.
config.color_scheme = 'Catppuccin Mocha'

-- Tab Bar Configuration
-- Enables a fancier, more modern tab bar design.
config.use_fancy_tab_bar = true
-- Hides the tab bar when there is only one tab, saving vertical space.
config.hide_tab_bar_if_only_one_tab = true

-- Window Configuration
-- Sets the padding around the inside of the terminal window.
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}
-- Sets the background opacity of the window. 0.95 makes it slightly transparent.
config.window_background_opacity = 0.95
-- Removes the default window title bar and buttons, leaving only resize handles.
config.window_decorations = 'RESIZE'

-- Cursor Configuration
-- Sets the default cursor style to a blinking bar.
config.default_cursor_style = 'BlinkingBar'

-- Scrollback Configuration
-- Sets the number of lines of scrollback history to keep.
config.scrollback_lines = 5000

-- Keymaps Configuration
-- Defines custom keybindings for various actions.
config.keys = {
  -- Create a new vertical split pane.
  {
    key = 'e',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Create a new horizontal split pane.
  {
    key = 'o',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Navigate to the pane on the left.
  {
    key = 'h',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Left',
  },
  -- Navigate to the pane on the right.
  {
    key = 'l',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Right',
  },
  -- Navigate to the pane above.
  {
    key = 'k',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Up',
  },
  -- Navigate to the pane below.
  {
    key = 'j',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Down',
  },
  -- Create a new tab.
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab {},
  },
}

-- Return the configuration table to Wezterm.
return config
