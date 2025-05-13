local wezterm = require "wezterm"

local palette = {
  bg          = "#1a1a1a",  -- soil
  fg          = "#c0c0c0",  -- mist
  green       = "#7aa37a",  -- leaf
  violet      = "#9f84bd",  -- bloom
  yellow      = "#d1b56f",  -- lantern
  gray        = "#3a3a3a",  -- rock
}

return {
  font = wezterm.font_with_fallback { "JetBrainsMono Nerd Font", "Iosevka Term" },
  font_size = 13.0,
  color_scheme = "Builtin Solarized Dark", -- base; we override below
  colors = {
    foreground = palette.fg,
    background = palette.bg,
    cursor_bg  = palette.green,
    cursor_fg  = palette.bg,
    selection_bg = "#303030",
    selection_fg = palette.fg,
    ansi = { palette.gray, palette.violet, palette.green, palette.yellow, palette.violet, palette.green, palette.yellow, palette.fg },
    brights = { palette.gray, palette.violet, palette.green, palette.yellow, palette.violet, palette.green, palette.yellow, palette.fg },
  },
  window_background_opacity = 0.95,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW", -- clean edges
  inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 },
  -- leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }, -- matches tmux prefix
  -- keys = {
  --   {key = "v", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  --   {key = "s", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  -- },
}
